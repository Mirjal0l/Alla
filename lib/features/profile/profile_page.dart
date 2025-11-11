import 'package:alla/core/utils/app_colors.dart';
import 'package:alla/features/profile/presentation/widgets/custom_field.dart';
import 'package:alla/widgets/custom_bold_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: CustomBoldText(
          text: 'Profil',
          size: 18,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),

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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),

        // content of card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            // rounded green icon
            Stack(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(55),
                    color: AppColors.green,
                  ),
                  child: Center(
                    child: Text(
                      'A',
                      style: GoogleFonts.spaceMono(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: AppColors.white,
                      ),
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
                )
              ],
            ),

            SizedBox(height: 20),

            CustomField(title: 'Ism', hint: 'Akbarali'),

            SizedBox(height: 16),

            CustomField(title: 'Telefon raqami', hint: '+998 00 123 45 67'),

            SizedBox(height: 30),

            TextButton(
                onPressed: (){

                },
                child: CustomBoldText(
                    text: 'Akkountdan chiqish',
                    size: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blue,
                )
            )

          ],
        ),
      ),
    );
  }
}
