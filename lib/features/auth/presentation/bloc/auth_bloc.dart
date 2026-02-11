
import 'package:alla/core/error/failure.dart';
import 'package:alla/core/local_source/local_source.dart';
import 'package:alla/features/auth/data/models/requests/send_otp_request.dart';
import 'package:alla/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:alla/features/auth/data/models/responses/send_otp_response.dart';
import 'package:alla/features/auth/data/models/responses/verify_otp_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alla/api/repository.dart';
import 'package:alla/core/either/either.dart';
import 'package:flutter/foundation.dart';

import '../../../../injector_container.dart'; // THIS IMPORT IS CRITICAL

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.repository})
      : super(const AuthState(sendOtpStatus: ApiStatus.initial)) {
    on<AuthSendOtpEvent>(_authSendOtpEventHandler);
  }

  final Repository repository;

  // Send OTP event handler
  Future<void> _authSendOtpEventHandler(
      AuthSendOtpEvent event,
      Emitter<AuthState> emit,
  ) async {
    // Set loading state using copyWith
    emit(state.copyWith(sendOtpStatus: ApiStatus.loading,
    message: null // Clear previous messages
        ));

    final result = await repository.sendOtp(request: SendOtpRequest(
        phoneNumber: event.phoneNumber));

    await result.fold(
      // Error case
      (Failure left) {
        emit(AuthState(sendOtpStatus: ApiStatus.error, message: left.message, sendOtpResponse: null));
      },
      // Sccess case
        (SendOtpResponse right) async {
        // store phone number when otp is successful
          await sl<LocalSource>().setPhoneNumber(event.phoneNumber);
          emit(AuthState(
              sendOtpStatus: ApiStatus.success,
              sendOtpResponse: right,
            message: 'Otp send successfully!!!' // optional
          ));
        },
    );
  }

  // Verify OTP event handler
  // Future<void> _authVerifyOtpEventHandler(
  //     AuthVerifyOtpEvent event,
  //     Emitter<AuthState> emit,
  // ) async {
  //   emit(state.copyWith(verifyOtpStatus: ApiStatus.loading));
  //
  //   final result = await repository.verifyOtp(request: VerifyOtpRequest(
  //       phoneNumber: event.phoneNumber, otpCode: event.otpCode),
  //   );
  //
  //   await result.fold(
  //         (Failure left) {
  //           emit(
  //               AuthState(verifyOtpStatus: ApiStatus.error, message: left.message,));
  //         },
  //         (VerifyOtpResponse right) async {
  //           emit(AuthState(verifyOtpStatus: ApiStatus.success, verifyOtpResponse: right));
  //         }
  //   );
  // }

}
