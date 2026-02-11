

class ProfileResponse {
  bool? success;
  String? message;
  dynamic? data;


  ProfileResponse({
    this.success,
    this.message,
    this.data,
  });

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

}
