import 'package:alla/core/local_source/local_source.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/otp/otp_page.dart';
import 'package:alla/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alla/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:alla/features/auth/presentation/mixin/auth_mixin.dart';
import 'package:alla/router/name_routes.dart';
import 'package:alla/widgets/custom_blue_button.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../core/utils/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AuthMixin {
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
    super.initState(); // This calls initControllers from mixin
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose(); // This calls disposeControllers from mixin
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
    listener: (BuildContext context, AuthState state) async {
      await pageMovement(state); // Handle navigation and errors

      if (state.sendOtpStatus == ApiStatus.success) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('OTP code sent successfully'),
        //     duration: Duration(seconds: 2),
        //   ),
        // );
      } else {
        if (state.sendOtpStatus == ApiStatus.loading) {
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.white),
            ),
          );
        }
      }
    },
    listenWhen: (AuthState previous, AuthState current) =>
        previous.sendOtpStatus != current.sendOtpStatus ||
        previous.sendOtpResponse != current.sendOtpResponse,
    child: BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.sendOtpStatus != current.sendOtpStatus,
      builder: (context, state) => Scaffold(
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

                          Padding(
                            padding: AppUtils.kPaddingHor16,
                            child: CustomBoldText(
                              text: 'Boshlash uchun tizimga kiring',
                              size: 28,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.start,
                            ),
                          ),

                          AppUtils.kGap16,

                          Padding(
                            padding: AppUtils.kPaddingHor16,
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
                                  TextSpan(
                                    text: 'rozilik bildirishingiz hamda ',
                                  ),
                                  TextSpan(
                                    text: 'Maxfiylik siyosati ',
                                    style: GoogleFonts.nunito(
                                      color: AppColors.green2,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'bilan tanishganingizni tasdiqlaysiz.',
                                  ),
                                ],
                              ),
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
                                  text: 'Telefon raqamingizni kiriting',
                                  size: 14,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          AppUtils.kGap10,

                          Padding(
                            padding: AppUtils.kPaddingHor16,
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
                                      borderRadius: AppUtils.kBorderRadius12,
                                    ),
                                    child: Padding(
                                      padding: AppUtils.kPaddingHor4,
                                      child: TextField(
                                        controller: phoneCode,
                                        // FROM MIXIN
                                        inputFormatters: [phoneMask1],
                                        style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: AppColors.white,
                                        ),
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          fillColor: AppColors.gray_darker3,
                                          hintText: '+998',
                                          hintStyle: GoogleFonts.nunito(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.white.withOpacity(
                                              0.75,
                                            ),
                                          ),
                                          prefixIconConstraints: AppUtils.kBoxConstraints24,
                                          prefixIcon: SvgPicture.asset(
                                            'assets/icons/flag_uz.svg',
                                            width: 24,
                                            height: 24,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: AppUtils.kPaddingHor12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                AppUtils.kGap8,

                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppColors.gray_darker3,
                                      borderRadius: AppUtils.kBorderRadius12,
                                    ),
                                    child: TextField(
                                      controller: phoneNumber,
                                      // FROM MIXIN
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: AppColors.white,
                                      ),
                                      inputFormatters: [phoneMask2],
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        fillColor: AppColors.gray_darker3,
                                        hintText: '91 123 45 67',
                                        hintStyle: GoogleFonts.nunito(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.white.withOpacity(
                                            0.75,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: AppUtils.kPaddingHor12
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
                        padding: AppUtils.kPaddingHor16Ver40,
                        child: CustomBlueButton(
                          title: state.sendOtpStatus == ApiStatus.loading
                              ? 'Yuborilmoqda...'
                              : 'Davom etish',
                          onPressed:
                              state.sendOtpStatus ==
                                  ApiStatus
                                      .loading // previous was state.sendOtpStatus
                              ? () {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(content: Text('phone: ${localSource.phoneNumber()}'
                                  //       ' state.sendOtpResponse.data: ${state.sendOtpResponse?.data}'),
                                  //   duration: Duration(seconds: 5)),
                                  // );
                                } // Disable button when loading
                              : () {
                                  final String phone = getPhoneNumber();
                                  if (getPhoneNumber().isNotEmpty &&
                                      phone.length > 5) {
                                    // localSource.setPhoneNumber(phone);

                                    // Only call the bloc event, navigation will happen in listener
                                    context.read<AuthBloc>().add(
                                      AuthSendOtpEvent(phoneNumber: phone),
                                    );

                                    // localSource.setAccessToken('eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6Iis5OTgwMDAwMDAwMDAiLCJ0b2tlblR5cGUiOiJBQ0NPVU5UIiwidXNlcklkIjozLCJzdWIiOiIrOTk4MDAwMDAwMDAwIiwiaWF0IjoxNzY2NzM0MDIzLCJleHAiOjE3NjcxNjYwMjN9.zAM2SmuReq1khuAMUbRlH5pvMUHFq-YN_zLDG8otcbw');

                                    // Don't navigate here - let the listener handle it
                                    // Don't show multiple snackbars
                                    // Don't access localSource directly here

                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text(
                                    //       'Otp code: ${state.sendOtpResponse?.data}',
                                    //     ),
                                    //     duration: Duration(seconds: 10),
                                    //   ),
                                    // );
                                  } else {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text(
                                    //       "Iltimos telefon raqamingizni to'g'ri kiriting!",
                                    //     ),
                                    //     duration: Duration(seconds: 3),
                                    //   ),
                                    // );
                                  }
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // LOADING OVERLAY
              if (state.sendOtpStatus == ApiStatus.loading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
