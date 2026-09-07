import 'package:api_flutter/news_model.dart';
import 'package:flutter/material.dart';

class Newsdetailpage extends StatelessWidget {
  final Results news;

  const Newsdetailpage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageUrl != null && news.imageUrl!.isNotEmpty)
              Hero(
                tag: news.articleId ?? news.link ?? news.title ?? "news",
                child: Image.network(
                  news.imageUrl!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 250,
                      color: Colors.deepOrange,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 60,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title ?? "No Title",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    news.pubDate ?? "",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    news.description ?? "",
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    news.content ?? "Full content ઉપલબ્ધ નથી.",
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
