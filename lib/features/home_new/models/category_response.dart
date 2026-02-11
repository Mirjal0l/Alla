


class CategoryResponse {
  bool? success;
  String? message;
  List<CategoryData>? data;

  CategoryResponse({this.success, this.message, this.data});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  String? id;
  String? name;
  String? contentIntentType;
  List? children;

  CategoryData(
      {
        this.id,
        this.name,
        this.contentIntentType,
        this.children
      });

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contentIntentType = json['contentIntentType'];
    children = json['children'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contentIntentType'] = this.contentIntentType;
    data['children'] = this.children;
    return data;
  }
}