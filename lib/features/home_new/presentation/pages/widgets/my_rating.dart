import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../widgets/custom_bold_text.dart';
import '../../../../../widgets/custom_sub_text.dart';

class MyRating extends StatefulWidget {
  const MyRating({Key? key}) : super(key: key);

  @override
  State<MyRating> createState() => _MyRatingState();
}

class _MyRatingState extends State<MyRating> {

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppUtils.kPaddingAll16,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: AppUtils.kBorderRadius12,
        color: AppColors.blue3,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomBoldText(
                text: rating.toString(),
                size: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
              CustomSubText(
                text: 'Baholang',
                size: 14,
                fontWeight: FontWeight.w300,
                color: AppColors.white.withOpacity(0.4),
              ),
            ],
          ),

          AppUtils.kGap24,

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 34,
                width: double.infinity,
                child: Center(
                  child: RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: false,
                    itemCount: 10,
                    itemPadding: AppUtils.kPaddingHor2,
                    itemBuilder: (context, _) => SvgPicture.asset(
                      'assets/icons/new_star.svg',
                      width: 20,
                      height: 20,
                    ),
                    itemSize: 24,
                    onRatingUpdate: (newRating) {
                      setState(() {
                        rating = newRating;
                        print('RATING: $rating');
                        print('RATING1 : $newRating');
                      });
                    },
                    updateOnDrag: false,
                    glow: false,
                    glowColor: Colors.yellow,
                  ),
                ),
              ),

              CustomSubText(
                text:
                'Iltimos, baholash uchun yulduzchalarni tanlang',
                size: 14,
                fontWeight: FontWeight.w300,
                color: AppColors.white.withOpacity(0.4),
              ),
            ],
          ),

          AppUtils.kGap24,

          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Muvaffaqiyatli yuborildi!'), backgroundColor: AppColors.green,)
              );
            },
            child: Container(
              margin: AppUtils.kPaddingHor16,
              height: 46,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: AppUtils.kBorderRadius16,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/violet_button.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),

              child: Center(
                child: CustomBoldText(text: 'Yuborish', size: 16, fontWeight: FontWeight.w800, color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
