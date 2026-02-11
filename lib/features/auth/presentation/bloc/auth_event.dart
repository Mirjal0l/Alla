// lib/features/auth/presentation/bloc/auth_event.dart

part of 'auth_bloc.dart';

// Explanation: Gotix uses Equatable to compare objects for equality
// This helps BLoC determine if events are the same to avoid duplicate processing



sealed class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object?> get props => []; // Equatable requires this
}

// Send OTP event - exactly like Gotix pattern
final class AuthSendOtpEvent extends AuthEvent {
  const AuthSendOtpEvent({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber]; // Include all fields for equality check
}

// Verify OTP event
// final class AuthVerifyOtpEvent extends AuthEvent {
//   const AuthVerifyOtpEvent({required this.phoneNumber, required this.otpCode});
//
//   final String phoneNumber;
//   final String otpCode;
//
//   @override
//   List<Object?> get props => [phoneNumber, otpCode];
// }

