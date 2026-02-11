class CategoryContent {
  bool? success;
  String? message;
  CategoryContentData? data;

  CategoryContent({this.success, this.message, this.data});

  CategoryContent.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new CategoryContentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CategoryContentData {
  List<ContentData>? content;

  CategoryContentData(
      {
        this.content
      });

  CategoryContentData.fromJson(Map<String, dynamic> json) {

    if (json['content'] != null) {
      content = <ContentData>[];
      json['content'].forEach((v) {
        content!.add(new ContentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentData {
  int? id;
  String? title;
  String? description;
  String? mobileThumbnailUrl;
  int? ageLimit;
  int? duration;
  String? categoryId;
  String? coverImageUrl;
  String? thumbnailUrl;

  ContentData(
      {this.id,
        this.title,
        this.description,
        this.mobileThumbnailUrl,
        this.ageLimit,
        this.duration,
        this.categoryId,
        this.coverImageUrl,
        this.thumbnailUrl
      });

  ContentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    mobileThumbnailUrl = json['mobileThumbnailUrl'];
    coverImageUrl = json['coverImageUrl'];
    thumbnailUrl = json['thumbnailUrl'];
    ageLimit = json['ageLimit'];
    duration = json['duration'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['coverImageUrl'] = this.coverImageUrl;
    data['mobileThumbnailUrl'] = this.mobileThumbnailUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['ageLimit'] = this.ageLimit;
    data['duration'] = this.duration;
    data['categoryId'] = this.categoryId;
    return data;
  }
}