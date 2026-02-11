import 'dart:io';
import 'dart:ui';

import 'package:alla/core/local_source/local_source.dart';
import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:alla/features/home/presentation/bloc/home_bloc.dart';
import 'package:alla/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:alla/features/profile/presentation/mixin/profile_mixin.dart';
import 'package:alla/features/profile/presentation/widgets/custom_field.dart';
import 'package:alla/router/app_routes.dart';
import 'package:alla/router/name_routes.dart';
import 'package:alla/widgets/custom_app_bar.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:alla/widgets/custom_sub_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alla/injector_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfileMixin {
  // Image File
  File? image;

  // Image Picker
  final picker = ImagePicker();


  String? userName = localSource.getfirstName();
  String? userPhone = localSource.phoneNumber();
  bool _isPickingImage = false; //

  // create controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  // Pick Image Method
  Future<void> pickImage(ImageSource source) async {
    if (_isPickingImage) return; // prevent multiple calls

    // Pick from camera or gallery
    final pickedFile = await picker.pickImage(source: source);

    // Update from camera or gallery
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        localSource.setProfileImagePath(image!);
      });
    }
  }

  // Getting first letter of name
  String _initialLetter(String user) {
    if (user == null || user!.isEmpty) return '?';
    return user![0].toUpperCase();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('Triggering get PROFILE API');
      context.read<ProfileBloc>().add(GetProfileDataEvent());
    });



    // load data



    // Add listeners to save when text changes
    firstNameController.addListener(() {
      // firstNameController.text = localSource.getfirstName() ?? '';
      localSource.setFirstName(firstNameController.text);
      setState(() {
        userName = firstNameController.text;
      });
    });

    phoneController.addListener(() {
      // phoneController.text = formatPhoneNumber(userPhone ?? '+998 00 123 45 67');
      localSource.setPhoneNumber(phoneController.text);
      setState(() {
        userPhone = phoneController.text;
      });
    });

    // Make navigation bar transparent & icons light
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (ProfileState previous, ProfileState current) =>
          previous.status != current.status ||
          previous.profileResponse != current.profileResponse,
      listener: (context, state) {
          print('PROFILE PAGE LISTENER: State changed to: ${state.status}');

          if (state.status == ApiStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message ?? "state.message javob bermadi error",
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }

          if (state.status == ApiStatus.success) {
            print('CATEGORY LISTENER: Success! STATE.STATUS: ${state.status}');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Muvaffaqiyatli CATOGORY API'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );

            localSource.setAge(state.profileResponse?.data?['age'] ?? '1');
          } else if (state.status == ApiStatus.loading) {
            print('CATEGORY LISTENER STATE LOADING');
          }

      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (p, n) => p.profileResponse != n.profileResponse,
          builder: (context, state) {
            return Scaffold(
              // appbar
              backgroundColor: AppColors.black,

              appBar: CustomAppBar(
                hasLeadingIcon: false,
                background: AppColors.black,
                title: 'Profil',
              ),

              // appBar: AppBar(
              //   backgroundColor: AppColors.black,
              //   title: CustomBoldText(
              //     text: 'Profil',
              //     size: 18,
              //     textAlign: TextAlign.center,
              //   ),
              //   centerTitle: true,
              // ),

              // card
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.black, AppColors.black2],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                  ),
                  borderRadius: AppUtils.kBorderRadiusTop28,
                ),

                // content of card
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppUtils.kGap16,
                      // rounded green icon
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: AppColors.gray,
                                      borderRadius: AppUtils.kBorderRadiusTop20,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: double.infinity,
                                            padding: AppUtils.kPaddingVer16Hor40,
                                            child: CustomBoldText(text: 'Rasm tanlang...', size: 18, textAlign: TextAlign.start,)
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () => {pickImage(ImageSource.camera), Navigator.pop(context)},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.blue,
                                              ),
                                              child: CustomBoldText(
                                                text: 'Kamera',
                                                size: 18,
                                                color: AppColors.white,
                                              ),
                                            ),
                  
                                            ElevatedButton(
                                              onPressed: () => {pickImage(ImageSource.gallery), Navigator.pop(context)},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.orange,
                                              ),
                                              child: CustomBoldText(
                                                text: 'Gallereya',
                                                size: 18,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                  
                                        AppUtils.kGap8
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: AppUtils.kBorderRadius64,
                                color: AppColors.green,
                              ),
                              child: Center(
                                  child: image != null
                                      ? ClipRRect(
                                    borderRadius: AppUtils.kBorderRadius64,
                                    child: Image.file(
                                      image!,
                                      width: 110,
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : Text(
                                    _initialLetter(localSource.getfirstName() ?? state.profileResponse?.data['firstName']),
                                    style: GoogleFonts.spaceMono(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.white,
                                    ),
                                  )
                              ),
                            ),
                          ),
                  
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/images/img16.png',
                              width: 36,
                              height: 36,
                            ),
                          ),
                        ],
                      ),
                  
                      AppUtils.kGap20,
                  
                      CustomField(title: 'Ism', hint: state.profileResponse?.data['firstName'] ?? localSource.getfirstName(),
                        controller: firstNameController, isPhoneNumber: false,),
                  
                      Container(decoration: BoxDecoration(color: AppColors.white)),
                      AppUtils.kGap16,
                  
                      CustomField(title: 'Telefon raqami', hint: formatPhoneNumber(state.profileResponse?.data['phoneNumber'] ?? localSource.phoneNumber())
                          , controller: phoneController, isPhoneNumber: true,),
                  
                      AppUtils.kGap32,
                  
                      TextButton(
                        onPressed: () {
                          showBlurredDialog(context);
                        },
                        child: CustomBoldText(
                          text: 'Akkountdan chiqish',
                          size: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );


  }
}

void showBlurredDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierColor: AppColors.transparent,
      builder: (context) {
        return SizedBox(
          height: 137,
          width: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 10,
              sigmaX: 10
            ),

            child: AlertDialog(
              backgroundColor: AppColors.black2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: CustomBoldText(text: 'Chiqish', size: 20),
              content: CustomSubText(text: 'Hisobdan chiqishni xohlaysizmi?', size: 13, color: AppColors.white.withOpacity(0.6),),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Center(
                          child: Container(
                            width: 141,
                            height: 44,
                            padding: AppUtils.kPaddingAll10,
                            decoration: BoxDecoration(
                              color: AppColors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: CustomSubText(text: 'Yo\'q', size: 16, fontWeight: FontWeight.w700, color: AppColors.green,),
                          ),
                        ),
                      ),
                    ),

                    AppUtils.kGap12,

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.go(Routes.login);
                        },
                        child: Center(
                          child: Container(
                            width: 141,
                            height: 44,
                            padding: AppUtils.kPaddingAll10,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/images/green_button.png'), fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: CustomSubText(text: 'Ha', size: 16, fontWeight: FontWeight.w700, color: AppColors.white,),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],

            ),
          ),
        );
      }
  );
}
