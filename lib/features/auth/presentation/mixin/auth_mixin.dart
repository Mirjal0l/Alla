
// lib/features/auth/presentation/mixin/auth_mixin.dart


import "package:alla/core/local_source/local_source.dart";
import "package:alla/features/auth/data/models/responses/send_otp_response.dart";
import "package:alla/features/auth/login_page.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:alla/features/auth/presentation/bloc/auth_bloc.dart";
import "package:alla/router/name_routes.dart";
import "package:top_snackbar_flutter/custom_snack_bar.dart";
import "package:top_snackbar_flutter/top_snack_bar.dart";

import "../../../../injector_container.dart";

mixin AuthMixin on State<LoginPage> {
  late TextEditingController phoneNumber;
  late TextEditingController phoneCode;

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  void initControllers() {
    phoneNumber = TextEditingController();
    phoneCode = TextEditingController(text: '+998');
  }

  Future<void> pageMovement(AuthState state) async {
    if (state.sendOtpStatus == ApiStatus.success) {
      // store phone number before navigation
      final String phone = getPhoneNumber();
      await sl<LocalSource>().setPhoneNumber(phone);

      // get OTP code from response
      final String otpCode = _extractOtpCode(state.sendOtpResponse);
      print('PAGE MOVEMENT: phone: $phone, otp: $otpCode');

      if (mounted) {
        context.goNamed(
          Routes.otp_page,
          pathParameters: {
            'phone': phone,
          },
          extra: {
            'phone': phone,
            'otp': otpCode,
          },
        );
      }

    } else if (state.sendOtpStatus == ApiStatus.error) {
      if (mounted) {
        showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: state.message ?? 'Failed to send OTP',
              icon: const Icon(Icons.close, color: Colors.red,),)
        );
      }
    }

    // if (state.status == ApiStatus.success) {
    //   // Check what type of success we have
    //   final response = state.response;
    //
    //   if (response?.parentToken != null && response?.accounts != null) {
    //     // OTP verified - navigate to account selection
    //     context.goNamed(
    //       Routes.otp_page, // I REPLACED OTP FROM SELECTEDACCOUNT
    //       extra: response, // Pass the response with accounts
    //     );
    //   } else if (response?.token != null) {
    //     // Login successful (account selected or created) - navigate to home
    //     context.goNamed(Routes.home);
    //   } else {
    //     // OTP sent successfully - navigate to OTP page
    //     final phone = _getPhoneNumber();
    //     context.goNamed(
    //       Routes.otp_page,
    //       pathParameters: {"phone": phone},
    //     );
    //
    //     // after navigating reset the BLoC state
    //     Future.delayed(Duration(milliseconds: 100), (){
    //       print('MIXIN: Resetting auth state to initial');
    //       context.read<AuthBloc>().add(ResetAuthStateEvent());
    // //     });
    //   }
    // } else if (state.status == ApiStatus.error) {
    //   // Show error snackbar
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(state.message ?? "Xatolik yuz berdi"),
    //       backgroundColor: Colors.red,
    //       duration: Duration(seconds: 3),
    //     ),
    //   );
    // }

  }

  String _extractOtpCode(SendOtpResponse? response) {
    return response?.data ?? '';
  }
  void disposeControllers() {
    phoneNumber.dispose();
    phoneCode.dispose();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  String getPhoneNumber() {
    String phone = '';
    // Extract and combine phone numbers from both controllers
    final unmasked1 = phoneCode.text.replaceAll(' ', '');
    final unmasked2 = phoneNumber.text.replaceAll(' ', '');
    phone += unmasked1 + unmasked2;

    return (phone.replaceAll(' ', ''));
  }
}