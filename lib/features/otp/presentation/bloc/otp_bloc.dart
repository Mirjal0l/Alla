import 'package:alla/core/error/failure.dart';
import 'package:alla/features/auth/data/models/requests/send_otp_request.dart';
import 'package:alla/features/auth/data/models/responses/send_otp_response.dart';
import 'package:alla/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alla/api/repository.dart';

import '../../../auth/data/models/requests/verify_otp_request.dart';
import '../../../auth/data/models/responses/verify_otp_response.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc({this.repository}) : super(OtpState(status: ApiStatus.initial)) {
    on<OtpVerifyOtpEvent>(_otpVerifyOtpEventHandler);
    on<OtpSendOtpEvent>(_otpSendOtpEventHandler);
  }

  final Repository? repository;

  // Verify OTP event handler
  Future<void> _otpVerifyOtpEventHandler(
    OtpVerifyOtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(status: ApiStatus.loading));

    final result = await repository?.verifyOtp(
      request: VerifyOtpRequest(
        phoneNumber: event.phoneNumber,
        otpCode: event.otpCode,
      ),
    );

    await result?.fold(
      (Failure left) {
        emit(OtpState(status: ApiStatus.error, message: left.message));
      },
      (VerifyOtpResponse right) async {
        emit(OtpState(status: ApiStatus.success, verifyOtpResponse: right));
      },
    );
  }

  Future<void> _otpSendOtpEventHandler(
    OtpSendOtpEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(status: ApiStatus.loading));

    final result = await repository?.sendOtp(
      request: SendOtpRequest(phoneNumber: event.phoneNumber),
    );

    await result?.fold(
      (Failure left) {
        emit(OtpState(status: ApiStatus.error, message: left.message));
      },
      (SendOtpResponse right) async {
        emit(OtpState(status: ApiStatus.success, sendOtpResponse: right));
      },
    );
  }
}
