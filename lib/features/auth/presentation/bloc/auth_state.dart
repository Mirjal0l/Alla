// Explanation: States represent what the UI should show
// Like loading, success, error, etc.

part of 'auth_bloc.dart';

// Explanation: Gotix uses enum for status and a single state class
// This is more concise than having multiple state classes



enum ApiStatus { initial, loading, success, error }

class AuthState extends Equatable {
  const AuthState({
    this.sendOtpStatus,
    this.message,
    this.sendOtpResponse,

  });

  final ApiStatus? sendOtpStatus;
  final String? message;
  final SendOtpResponse? sendOtpResponse;

  // copyWith method - allows creating new state with updated fields
  // Explanation: This is used in BLoC to create new states while keeping unchanged fields

  AuthState copyWith({
    ApiStatus? sendOtpStatus,
    String? message,
    SendOtpResponse? sendOtpResponse,
  }) =>
      AuthState(
          sendOtpStatus: sendOtpStatus ?? this.sendOtpStatus,
          message: message ?? this.message,
          sendOtpResponse: sendOtpResponse ?? this.sendOtpResponse,
      );

  @override
  List<Object?> get props => [sendOtpStatus, message, sendOtpResponse ];
}
