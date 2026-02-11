

import 'package:flutter/foundation.dart';

class CategoryResponseOld {
  bool? success;
  String? message;
  dynamic data;

  CategoryResponseOld({
    this.success,
    this.message,
    this.data
  });

  CategoryResponseOld.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }
}