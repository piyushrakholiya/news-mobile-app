import 'dart:convert';

import 'package:api_flutter/news_model.dart';
import 'package:api_flutter/newsdetailpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Newsapp extends StatefulWidget {
  const Newsapp({super.key});

  @override
  State<Newsapp> createState() => _NewsappState();
}

class _NewsappState extends State<Newsapp> {
  String? errorMessage;
  final ScrollController _scrollController = ScrollController();
  News_Model? newsData;
  bool isLoading = true;
  bool hasMore = true;
  bool isLoadingMore = false;

  @override
  initState() {
    super.initState();
    loadingNews();

    _scrollController.addListener(() {
      final currentPosition = _scrollController.position.pixels;
      final lastPosition = _scrollController.position.maxScrollExtent;

      final nearBottom = currentPosition >= lastPosition - 200;

      if (nearBottom && !isLoadingMore && hasMore) {
        loadMoreNews();
      }
    });
  }

  Future<News_Model> fetchNews({String? pageToken}) async {
    final apiKey = dotenv.env['API_KEY'] ?? '';

    String url =
        "https://newsdata.io/api/1/latest?apikey=$apiKey&category=business";

    if (pageToken != null) {
      url += "&page=$pageToken";
    }

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final results = jsonDecode(response.body);
        return News_Model.fromJson(results);
      }
    } catch (e) {
      throw Exception("Server error");
    }
    return News_Model();
  }

  Future<void> loadingNews() async {
    try {
      var fetchedNews = await fetchNews();
      setState(() {
        newsData = fetchedNews;
        isLoading = false;
        hasMore = fetchedNews.nextPage != null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "News લોડ થઈ શક્યા નથી. ફરી પ્રયત્ન કરો.";
        isLoading = false;
      });
    }
  }

  Future<void> loadMoreNews() async {
    if (newsData?.nextPage == null) {
      setState(() => hasMore = false);
      return;
    }

    setState(() => isLoadingMore = true);

    final moreNews = await fetchNews(pageToken: newsData!.nextPage);

    final oldIds =
        newsData?.results
            ?.map((news) => news.articleId)
            .whereType<String>()
            .toSet() ??
        <String>{};

    final uniqueNews = (moreNews.results ?? [])
        .where(
          (news) => news.articleId != null && !oldIds.contains(news.articleId),
        )
        .toList();

    setState(() {
      newsData?.results?.addAll(uniqueNews);
      newsData?.nextPage = moreNews.nextPage;
      hasMore = moreNews.nextPage != null;
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News"), backgroundColor: Colors.deepOrange),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.deepOrange))
          : errorMessage != null
          ? Center(
              child: Text(
                errorMessage!,
                style: const TextStyle(fontSize: 22, color: Colors.red),
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount:
                  (newsData?.results?.length ?? 0) + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                final newsList = newsData?.results ?? [];

                if (index == newsList.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                var news = newsList[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(11),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Newsdetailpage(news: news),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          news.imageUrl != null
                              ? Hero(
                                  tag:
                                      news.articleId ??
                                      news.link ??
                                      news.title ??
                                      "news",
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      12,
                                    ),
                                    child: Image.network(
                                      news.imageUrl!,
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              width: 90,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  news.title ?? "No Title",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(height: 6),

                                Text(
                                  news.description ?? "",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
