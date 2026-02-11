class SendOtpRequest {
  final String phoneNumber;

  const SendOtpRequest({
    required this.phoneNumber
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
    "phoneNumber": phoneNumber
  };

}