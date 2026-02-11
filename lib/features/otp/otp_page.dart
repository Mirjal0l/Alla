import 'dart:async';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:alla/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:alla/features/auth/presentation/bloc/auth_bloc.dart' hide ApiStatus;
import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/router/name_routes.dart';
import 'package:alla/widgets/custom_blue_button.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';

class OtpPage extends StatefulWidget {

  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _pinController = TextEditingController();
  String current_pin = '';
  bool showError = false;
  late String hidenNumber;
  int seconds_remaining = 120;
  Timer? _timer;
  bool _isProcessing = false; // ADD THIS to prevent multiple submissions
  bool _hasSubmitted = false;

  // For extracted data
  late String phoneNumber;
  late String otpCode;
  bool _isDataExtracted = false;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds_remaining != 0) {
        setState(() {
          seconds_remaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String formatTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return "$m:${s.toString().padLeft(2, '0')}";
  }

  String formatPhoneNumber(String? phone) {
    if (phone == null || phone.length < 8) return phone ?? '';
    String firstPart = phone.substring(0, 4); // +998
    String lastPart = phone.substring(phone.length - 4); // last 4 digits
    return '$firstPart ** *** $lastPart';
  }



  @override
  void initState() {
    super.initState();
    _pinController.addListener(_onPinChanged);
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Extract data here instead of initState
    if (!_isDataExtracted) {
      _extractExtraData();
      _isDataExtracted = true;
    }
  }

  void _extractExtraData() {
    try {
      print('---EXTRACTING DATA---');

      final GoRouterState routerState = GoRouterState.of(context);

      if (routerState.extra is Map<String, dynamic>) {
        final Map<String, dynamic> extra = routerState.extra as Map<String, dynamic>;
        phoneNumber = extra['phone']?.toString() ?? '';
        otpCode = extra['otp']?.toString() ?? '';
      } else if (routerState.pathParameters.containsKey('phone')) {
        phoneNumber = routerState.pathParameters['otp'] ?? '';
        otpCode = routerState.uri.queryParameters['otp'] ?? '';
      }
      //  Get the extra data from route settings
      // final Map<String, dynamic> extra =
      //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
      //
      // phoneNumber = extra['phone']?.toString() ?? '';
      // otpCode = extra['otp']?.toString() ?? '';

      //  Initialize the hidden phone number
      hidenNumber = formatPhoneNumber(phoneNumber).toString();

      print('OTP Page - Phone: $phoneNumber, OTP: $otpCode');
    } catch (e) {
      print('Error extracting OTP page data: $e');
      phoneNumber = '';
      otpCode = '';
      hidenNumber = '';
    }
  }


  @override
  void dispose() {
    _pinController.removeListener(_onPinChanged);
    _pinController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _onPinChanged() {
    current_pin = _pinController.text;

    if (_hasSubmitted && current_pin.length < 6) {
      _hasSubmitted = false;
    }

    if (current_pin.length == 6 && !_isProcessing && !_hasSubmitted) {
      _handleOtpComplete(current_pin, context.read<OtpBloc>().state);
    }
  }

  void _handleOtpComplete(String current_pin, dynamic state) {
    if (_isProcessing && _hasSubmitted) return; // Prevent multiple calls

    setState(() {

      _isProcessing = true;
      _hasSubmitted = true;
      showError = false;
    });

    print('OTP PAGE: Calling verify OTP with PIN: $current_pin');
    print('PHONE NUMBER EXTRACTED: $phoneNumber');

    context.read<OtpBloc>().add(
      OtpVerifyOtpEvent(
        phoneNumber: localSource.phoneNumber(), // use extracted phoneNumber
        otpCode: current_pin,
      ),
    );


  }

  void _resendOtp() {

    context.read<OtpBloc>().add(
      OtpSendOtpEvent(phoneNumber: phoneNumber),
    );
    setState(() {
      seconds_remaining = 120;
      showError = false;
      _pinController.clear();
      current_pin = '';
      _isProcessing = false;
      _hasSubmitted = false;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listenWhen: (OtpState previous, OtpState current) => previous.status != current.status,
      listener: (context, state) {
        print('OTP LISTENER: State changed to: ${state.status}');

        // Clear any existing snackbars first
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        if (state.status == ApiStatus.error) {
          setState(() {
            showError = true;
            _isProcessing = false;
          });

          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(state.message ?? "state.message javob bermadi error"),
          //       backgroundColor: Colors.red,
          //       duration: Duration(seconds: 3),
          //       behavior: SnackBarBehavior.floating,
          //     ),
          //   );
          // }

        }


        if (state.status == ApiStatus.success) {
          print('OTP LISTENER: Success! Navigating to home... STATE.STATUS: ${state.status}');
          setState(() {
            _isProcessing = false;
          });

          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text('Muvaffaqiyatli tasdiqlandi'),
          //       backgroundColor: Colors.green,
          //       duration: Duration(seconds: 2),
          //     )
          // );

          // Navigate to home on success
          Future.delayed(Duration.zero, () {
            context.goNamed(Routes.newHomePage);
          });
        }

      },
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: AppUtils.kBorderRadiusTop28,
            gradient: RadialGradient(
              center: Alignment.bottomRight,
              colors: [
                AppColors.reddish.withOpacity(0.3),
                AppColors.transparent,
              ],
              radius: 1.5,
              stops: [0, 1],
            ),
          ),
          child: Stack(
            children: [
              // Your existing background widgets...
              Positioned(
                top: -84,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/img18.png",
                  width: 554,
                  height: 676,
                  fit: BoxFit.fitHeight,
                ),
              ),

              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.9), AppColors.black],
                    stops: [0, 0.25],
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomRight,
                    colors: [AppColors.dark_reddish, AppColors.transparent],
                    radius: 1.5,
                    stops: [0.0, 0.5],
                  ),
                ),
              ),

              // MAIN CONTENT
              BlocBuilder<OtpBloc, OtpState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Error header
                              if (showError)
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: double.infinity,
                                    height: 137,
                                    decoration: BoxDecoration(
                                      color: AppColors.error,
                                    ),
                                    child: Padding(
                                      padding: AppUtils.kPaddingAll16,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          CustomBoldText(
                                            text: 'Yaroqsiz kod',
                                            size: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          AppUtils.kGap4,
                                          CustomSubText(
                                            text: "Tasdiqlash kodi yaroqsiz.\n Iltimos, qayta urinib koʻring",
                                            size: 15,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: AppUtils.kPaddingTop30Left4,
                                    child: IconButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 20,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),

                              if (!showError) ...[
                                Padding(
                                  padding: AppUtils.kPaddingTop20Left16Right16,
                                  child: CustomBoldText(
                                    text: 'Tasdiqlash kodini kiriting',
                                    size: 28,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.start,
                                  ),
                                ),

                                AppUtils.kGap16,
                              ],

                              Padding(
                                padding: AppUtils.kPaddingHor16,
                                child: CustomSubText(
                                  text: 'Kod $hidenNumber raqamiga yuborildi',
                                  size: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              AppUtils.kGap32,

                              Padding(
                                padding: AppUtils.kPaddingHor16,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomSubText(
                                      text: 'Tasdiqlash kodi: ',
                                      size: 14,
                                      textAlign: TextAlign.center,
                                    ),

                                    CustomSubText(text: otpCode!, size: 20)
                                  ],
                                ),
                              ),

                              AppUtils.kGap10,

                              Container(
                                padding: AppUtils.kPaddingHor16,
                                height: 48,
                                width: double.infinity,
                                child: PinInputTextField(
                                  pinLength: 6,
                                  controller: _pinController,
                                  autoFocus: true,
                                  keyboardType: TextInputType.phone,
                                  decoration: _buildCustomDecoration(showError),
                                  onSubmit: (pin) {
                                    _handleOtpComplete(current_pin, state);
                                  },
                                ),
                              ),

                              AppUtils.kGap16,

                              Padding(
                                padding: AppUtils.kPaddingHor16,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomSubText(
                                        text: 'Kod amal qiladi: ',
                                        size: 14,
                                        fontWeight: FontWeight.w400
                                    ),
                                    CustomSubText(
                                        text: formatTime(seconds_remaining),
                                        size: 14,
                                        fontWeight: FontWeight.w800,
                                        color: (seconds_remaining == 0) ? AppColors.error : AppColors.green2
                                    )
                                  ],
                                ),
                              ),

                              // Resend OTP button
                              if (seconds_remaining == 0)
                                Padding(
                                  padding: AppUtils.kPaddingHor16,
                                  child: TextButton(
                                    onPressed: _resendOtp,
                                    child: Text(
                                      'Kodni qayta yuborish',
                                      style: TextStyle(color: AppColors.green2),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          Padding(
                            padding: AppUtils.kPaddingHor16Ver40,
                            child: CustomBlueButton(
                              title: _isProcessing || state.status == ApiStatus.loading
                                  ? 'Tekshirilmoqda...'
                                  : 'Davom etish',
                              onPressed: (_isProcessing || state.status == ApiStatus.loading)
                                  ? () {}
                                  : () {
                                if (current_pin.length == 6) {
                                  _handleOtpComplete(current_pin, state);
                                } else {
                                  setState(() {
                                    showError = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  PinDecoration _buildCustomDecoration(bool isError) {
    return BoxLooseDecoration(
      strokeColorBuilder: !isError
          ? PinListenColorBuilder(AppColors.gray_darker3, AppColors.gray_darker3)
          : PinListenColorBuilder(AppColors.error, AppColors.error),
      strokeWidth: 1,
      gapSpace: 10,
      bgColorBuilder: FixedColorBuilder(AppColors.gray_darker3),
      textStyle: GoogleFonts.nunito(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
    );
  }
}