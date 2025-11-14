import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../router/name_routes.dart';
import '../../../../widgets/custom_blue_button.dart';
import '../../../../widgets/custom_bold_text.dart';
import '../../../../widgets/custom_sub_text.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;

  const OtpPage({super.key, required this.phoneNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _pinController = TextEditingController();
  String current_pin = '';
  bool isSuccessful = false;

  bool showError = false;
  late String hidedNumber =
      "${widget.phoneNumber!.substring(0, 4)} ** *** ${widget.phoneNumber!.substring(widget.phoneNumber!.length, -4)}";

  int seconds_remaining = 120;
  Timer? _timer;


  void startTimer() {
    _timer = Timer.periodic(
        Duration(seconds: 1), (timer) {
          if (seconds_remaining != 0) {
            setState(() {
              seconds_remaining--;
            });
          } else {
            timer.cancel();
            context.go(Routes.login);
          }
        }
    );
  }

  String formatTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return "$m:${s.toString().padLeft(2, '0')}";
  }


  @override
  void initState() {
    super.initState();
    hidedNumber = formatPhoneNumber(widget.phoneNumber);
    _pinController.addListener(_onPinChanged);
    startTimer();
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
    if (current_pin.length == 6) {
      _handleOtpComplete(current_pin);
    }
  }

  void _handleOtpComplete(current_pin) {
    if (current_pin.length == 6 && current_pin == '000000') {
      isSuccessful = true;
      context.push(Routes.home);
    }
  }

  String formatPhoneNumber(String? phone) {
    if (phone == null || phone.length < 8) return phone ?? '';

    String firstPart = phone.substring(0, 4); // +998
    String lastPart = phone.substring(phone.length - 4); // last 4 digits

    return '$firstPart ** *** $lastPart';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      // BACKGROUND
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28),
            topLeft: Radius.circular(28),
          ),
          gradient: RadialGradient(
            center: Alignment.bottomRight,
            colors: [
              // Color(0xFF35070D),
              AppColors.reddish.withOpacity(0.3),
              AppColors.transparent,
            ],
            radius: 1.5,
            stops: [0, 1],
          ),
        ),
        child: Stack(
          children: [
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

            // MAIN CONTETNS
            !showError
                ? Align(
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
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 30,
                                    left: 4,
                                  ),
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

                              Padding(
                                padding: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 20,
                                ),
                                child: CustomBoldText(
                                  text: 'Tasdiqlash kodini kiriting',
                                  size: 28,
                                  fontWeight: FontWeight.w700,
                                  textAlign: TextAlign.start,
                                ),
                              ),

                              SizedBox(height: 16),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: CustomSubText(
                                  text: 'Kod $hidedNumber raqamiga yuborildi',
                                  size: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              SizedBox(height: 30),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomSubText(
                                      text: 'Tasdiqlash kodi',
                                      size: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [SizedBox(width: 8)],
                                ),
                              ),

                              SizedBox(height: 10),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 48,
                                width: double.infinity,
                                child: PinInputTextField(
                                  pinLength: 6,
                                  controller: _pinController,
                                  autoFocus: true,
                                  keyboardType: TextInputType.phone,
                                  decoration: _buildCustomDecoration(showError),
                                  onSubmit: _handleOtpComplete,
                                ),
                              ),

                              SizedBox(height: 16,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomSubText(text: 'Kod amal qiladi: ', size: 14, fontWeight: FontWeight.w400),
                                    CustomSubText(text: formatTime(seconds_remaining), size: 14, fontWeight: FontWeight.w800,
                                      color: (seconds_remaining == 0) ? AppColors.error : AppColors.green2
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 40,
                            ),
                            child: CustomBlueButton(
                              title: 'Davom etish',
                              onPressed: () {
                                setState(() {
                                  if (!isSuccessful) {
                                    showError = true;
                                  } else {
                                    context.go(Routes.home);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Align(
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
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: double.infinity,
                                  height: 137,
                                  decoration: BoxDecoration(
                                    color: AppColors.error,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomBoldText(
                                          text: 'Yaroqsiz kod',
                                          size: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        SizedBox(height: 4),
                                        CustomSubText(
                                          text:
                                              "Tasdiqlash kodi yaroqsiz.\n Iltimos, qayta urinib koʻring",
                                          size: 15,
                                          fontWeight: FontWeight.w400,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 16),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: CustomSubText(
                                  text: 'Kod $hidedNumber raqamiga yuborildi',
                                  size: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              SizedBox(height: 30),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomSubText(
                                      text: 'Tasdiqlash kodi',
                                      size: 14,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [SizedBox(width: 8)],
                                ),
                              ),

                              SizedBox(height: 10),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 48,
                                width: double.infinity,
                                child: PinInputTextField(
                                  pinLength: 6,
                                  controller: _pinController,
                                  autoFocus: true,
                                  keyboardType: TextInputType.phone,
                                  decoration: _buildCustomDecoration(showError),
                                  onSubmit: _handleOtpComplete,
                                ),
                              ),

                              SizedBox(height: 16,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomSubText(text: 'Kod amal qiladi: ', size: 14, fontWeight: FontWeight.w400),
                                    CustomSubText(text: formatTime(seconds_remaining), size: 14, fontWeight: FontWeight.w800,
                                        color: (seconds_remaining == 0) ? AppColors.error : AppColors.green2
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 40,
                            ),
                            child: CustomBlueButton(
                              title: 'Davom etish',
                              onPressed: () {
                                setState(() {
                                  if (!isSuccessful) {
                                    showError = true;
                                  } else {
                                    context.pushReplacement(Routes.home);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  PinDecoration _buildCustomDecoration(bool isError) {
    return BoxLooseDecoration(
      strokeColorBuilder: !isError ? PinListenColorBuilder(
        AppColors.gray_darker3,
        AppColors.gray_darker3,
      ) : PinListenColorBuilder(AppColors.error, AppColors.error),
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
