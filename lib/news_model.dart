class News_Model {
  String? status;
  int? totalResults;
  List<Results>? results;
  String? nextPage;

  News_Model({this.status, this.totalResults, this.results, this.nextPage});

  News_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['nextPage'] = nextPage;
    return data;
  }
}

class Results {
  String? articleId;
  String? link;
  String? title;
  String? description;
  String? content;
  List<String>? keywords;
  List<String>? creator;
  String? language;
  List<String>? country;
  List<String>? category;
  String? datatype;
  String? pubDate;
  String? pubDateTZ;
  String? fetchedAt;
  String? imageUrl;
  String? videoUrl;
  String? sourceId;
  String? sourceName;
  int? sourcePriority;
  String? sourceUrl;
  String? sourceIcon;
  String? sentiment;
  String? sentimentStats;
  String? aiTag;
  String? aiRegion;
  String? aiOrg;
  String? aiSummary;
  bool? duplicate;

  Results({
    this.articleId,
    this.link,
    this.title,
    this.description,
    this.content,
    this.keywords,
    this.creator,
    this.language,
    this.country,
    this.category,
    this.datatype,
    this.pubDate,
    this.pubDateTZ,
    this.fetchedAt,
    this.imageUrl,
    this.videoUrl,
    this.sourceId,
    this.sourceName,
    this.sourcePriority,
    this.sourceUrl,
    this.sourceIcon,
    this.sentiment,
    this.sentimentStats,
    this.aiTag,
    this.aiRegion,
    this.aiOrg,
    this.aiSummary,
    this.duplicate,
  });

  Results.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    link = json['link'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    keywords = json['keywords'] != null
        ? List<String>.from(json['keywords'].map((x) => x.toString()))
        : [];
    creator = json['creator'] != null
        ? List<String>.from(json['creator'].map((x) => x.toString()))
        : [];
    language = json['language'];
    country = json['country'] != null
        ? List<String>.from(json['country'].map((x) => x.toString()))
        : [];
    category = json['category'] != null
        ? List<String>.from(json['category'].map((x) => x.toString()))
        : [];
    datatype = json['datatype'];
    pubDate = json['pubDate'];
    pubDateTZ = json['pubDateTZ'];
    fetchedAt = json['fetched_at'];
    imageUrl = json['image_url'];
    videoUrl = json['video_url'];
    sourceId = json['source_id'];
    sourceName = json['source_name'];
    sourcePriority = json['source_priority'];
    sourceUrl = json['source_url'];
    sourceIcon = json['source_icon'];
    sentiment = json['sentiment'];
    sentimentStats = json['sentiment_stats'];
    aiTag = json['ai_tag'];
    aiRegion = json['ai_region'];
    aiOrg = json['ai_org'];
    aiSummary = json['ai_summary'];
    duplicate = json['duplicate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['article_id'] = articleId;
    data['link'] = link;
    data['title'] = title;
    data['description'] = description;
    data['content'] = content;
    data['keywords'] = keywords;
    data['creator'] = creator;
    data['language'] = language;
    data['country'] = country;
    data['category'] = category;
    data['datatype'] = datatype;
    data['pubDate'] = pubDate;
    data['pubDateTZ'] = pubDateTZ;
    data['fetched_at'] = fetchedAt;
    data['image_url'] = imageUrl;
    data['video_url'] = videoUrl;
    data['source_id'] = sourceId;
    data['source_name'] = sourceName;
    data['source_priority'] = sourcePriority;
    data['source_url'] = sourceUrl;
    data['source_icon'] = sourceIcon;
    data['sentiment'] = sentiment;
    data['sentiment_stats'] = sentimentStats;
    data['ai_tag'] = aiTag;
    data['ai_region'] = aiRegion;
    data['ai_org'] = aiOrg;
    data['ai_summary'] = aiSummary;
    data['duplicate'] = duplicate;
    return data;
  }
}
