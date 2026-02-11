

part of 'otp_bloc.dart';



sealed class OtpEvent extends Equatable{
  const OtpEvent();

  @override
  List<Object?> get props => []; // Equatable requires this
}

// Send OTP event - exactly like Gotix pattern
final class OtpSendOtpEvent extends OtpEvent {
  const OtpSendOtpEvent({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber]; // Include all fields for equality check
}

// Verify OTP event
final class OtpVerifyOtpEvent extends OtpEvent {
  const OtpVerifyOtpEvent({required this.phoneNumber, required this.otpCode});

  final String phoneNumber;
  final String otpCode;

  @override
  List<Object?> get props => [phoneNumber, otpCode];
}

