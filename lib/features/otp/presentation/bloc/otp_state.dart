// Explanation: States represent what the UI should show
// Like loading, success, error, etc.

part of 'otp_bloc.dart';


enum ApiStatus { initial, loading, success, error }

class OtpState extends Equatable {
  const OtpState({
    this.success,
    this.status,
    this.message,
    this.sendOtpResponse,
    this.verifyOtpResponse
  });

  final bool? success;
  final ApiStatus? status;
  final String? message;
  final SendOtpResponse? sendOtpResponse;
  final VerifyOtpResponse? verifyOtpResponse;

  // copyWith method - allows creating new state with updated fields
  // Explanation: This is used in BLoC to create new states while keeping unchanged fields

  OtpState copyWith({
    bool? success,
    ApiStatus? status,
    String? message,
    SendOtpResponse? sendOtpResponse,
    VerifyOtpResponse? verifyOtpResponse,
  }) =>
      OtpState(
        success: success ?? this.success,
          status: status ?? this.status,
          message: message ?? this.message,
          sendOtpResponse: sendOtpResponse ?? this.sendOtpResponse,
          verifyOtpResponse: verifyOtpResponse ?? this.verifyOtpResponse
      );

  @override
  List<Object?> get props => [success, status, message, sendOtpResponse, verifyOtpResponse];
}
