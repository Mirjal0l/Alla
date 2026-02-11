class SendOtpResponse {
  bool? success;
  String? message;
  String? data;

  SendOtpResponse({
    this.success, this.message, this.data
  });

  SendOtpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }
}