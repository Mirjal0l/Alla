import 'dart:ffi';

import 'package:alla/router/name_routes.dart';
import 'package:alla/widgets/custom_blue_button.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:ui';

import '../../core/utils/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController1 = TextEditingController();
  final  _phoneController2 = TextEditingController();
  var phoneMask1 = MaskTextInputFormatter(
    mask: '+###',
    filter: {'#': RegExp(r'[0-9]')},
  );

  var phoneMask2 = MaskTextInputFormatter(
    mask: '## ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    _phoneController1.dispose();
    _phoneController2.dispose();
    super.dispose();
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
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30, left: 4),
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
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: CustomBoldText(
                            text: 'Boshlash uchun tizimga kiring',
                            size: 28,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.start,
                          ),
                        ),

                        SizedBox(height: 16),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                height: 22 / 15,
                                color: AppColors.white.withOpacity(0.8),
                              ),
                              children: [
                                TextSpan(text: 'Davom etish orqali siz '),
                                WidgetSpan(
                                  child: InkWell(
                                    onTap: () {
                                      context.push(Routes.info);
                                    },
                                    child: Text(
                                      'Foydalanish shartlariga',
                                      style: GoogleFonts.nunito(
                                        color: AppColors.green2,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),

                                ),
                                TextSpan(text: 'rozilik bildirishingiz hamda '),
                                TextSpan(
                                  text: 'Maxfiylik siyosati ',
                                  style: GoogleFonts.nunito(
                                    color: AppColors.green2,
                                  ),
                                ),
                                TextSpan(
                                  text: 'bilan tanishganingizni tasdiqlaysiz.',
                                ),
                              ],
                            ),
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
                                text: 'Telefon raqamingizni kiriting',
                                size: 14,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // phone code text field
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.gray_darker3,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: TextField(
                                      controller: _phoneController1,
                                      inputFormatters: [phoneMask1],
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: AppColors.white
                                      ),
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        fillColor: AppColors.gray_darker3,
                                        hintText: '+998',
                                        hintStyle: GoogleFonts.nunito(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.white.withOpacity(0.75),
                                        ),
                                        prefixIconConstraints: BoxConstraints(maxWidth: 24, maxHeight: 24, minHeight: 24, minWidth: 24),
                                        prefixIcon: SvgPicture.asset(
                                          'assets/icons/flag_uz.svg',
                                          width: 24,
                                          height: 24,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 8,),

                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.gray_darker3,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextField(
                                    controller: _phoneController2,
                                    style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: AppColors.white
                                    ),
                                    inputFormatters: [phoneMask2],
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.gray_darker3,
                                        hintText: '91 123 45 67',
                                        hintStyle: GoogleFonts.nunito(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.white.withOpacity(0.75),
                                        ),
                                        border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 12)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                      child: CustomBlueButton(
                          title: 'Davom etish',
                          onPressed: () {
                            final unmasked1 = _phoneController1.text.replaceAll(RegExp(r'[^\d]'), '');
                            final unmasked2 = _phoneController2.text.replaceAll(RegExp(r'[^\d]'), '');

                            if (unmasked1.length == 3 && unmasked2.length == 9) {
                              // Remove spaces and mask characters from phone number
                              final phone = (_phoneController1.text + _phoneController2.text).replaceAll(' ', '');

                              GoRouter.of(context).pushNamed(
                                  Routes.otp_page,
                                  pathParameters: {
                                    "phone": phone,
                                  }
                              );
                              return;
                            } else {

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Iltimos telefon raqamingizni to'g'ri kiriting!"),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return;
                            }
                          }
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
