class VerifyOtpRequest {
  final String phoneNumber;
  final String otpCode;

  VerifyOtpRequest(
    {
      required this.phoneNumber,
      required this.otpCode
    }
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    "phoneNumber": phoneNumber,
    "otpCode": otpCode
  };
}
