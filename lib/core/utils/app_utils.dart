part of 'utils.dart';

sealed class AppUtils {
  AppUtils._();

  static const Gap kGap = Gap(0);
  static const Gap kGap2 = Gap(2);
  static const Gap kGap4 = Gap(4);
  static const Gap kGap6 = Gap(6);
  static const Gap kGap8 = Gap(8);
  static const Gap kGap10 = Gap(10);
  static const Gap kGap12 = Gap(12);
  static const Gap kGap16 = Gap(16);
  static const Gap kGap20 = Gap(20);
  static const Gap kGap24 = Gap(24);
  static const Gap kGap32 = Gap(32);
  static const Gap kGap48 = Gap(48);

  static const Divider divider = Divider();

  static const EdgeInsets kPaddingAll4 = EdgeInsets.all(4);
  static const EdgeInsets kPaddingAll6 = EdgeInsets.all(6);
  static const EdgeInsets kPaddingAll10 = EdgeInsets.all(10);
  static const EdgeInsets kPaddingAll8 = EdgeInsets.all(8);
  static const EdgeInsets kPaddingAll12 = EdgeInsets.all(12);
  static const EdgeInsets kPaddingAll16 = EdgeInsets.all(16);
  static const EdgeInsets kPaddingAll24 = EdgeInsets.all(24);
  static const EdgeInsets kPaddingHor2 = EdgeInsets.symmetric(horizontal: 2);
  static const EdgeInsets kPaddingHor4 = EdgeInsets.symmetric(horizontal: 4);
  static const EdgeInsets kPaddingHor5 = EdgeInsets.symmetric(horizontal: 5);
  static const EdgeInsets kPaddingHor6 = EdgeInsets.symmetric(horizontal: 6);
  static const EdgeInsets kPaddingHor8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets kPaddingHor10 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets kPaddingHor12 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets kPaddingHor16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets kPaddingHor24 = EdgeInsets.symmetric(horizontal: 24);

  static const EdgeInsets kPaddingVer2 = EdgeInsets.symmetric(vertical: 2);
  static const EdgeInsets kPaddingVer4 = EdgeInsets.symmetric(vertical: 4);
  static const EdgeInsets kPaddingVer6 = EdgeInsets.symmetric(vertical: 6);
  static const EdgeInsets kPaddingVer8 = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets kPaddingVer10 = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets kPaddingVer12 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets kPaddingVer16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets kPaddingTop30Left4 = EdgeInsets.only(top: 30, left: 4);
  static const EdgeInsets kPaddingHor16Ver40 = EdgeInsets.symmetric(horizontal: 16, vertical: 40);
  static const EdgeInsets kPaddingVer16Hor40 = EdgeInsets.symmetric(vertical: 16, horizontal: 40);
  static const EdgeInsets kPaddingHor8Ver4 = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  static const EdgeInsets kPaddingTop16 = EdgeInsets.only(top: 16);
  static const EdgeInsets kPaddingLeft12Bottom12 = EdgeInsets.only(left: 12, bottom: 12);
  static const EdgeInsets kPaddingLeft2Top2Bottom10 = EdgeInsets.only(left: 2, top: 2, bottom: 10);
  static const EdgeInsets kPaddingBottom30Left16Right16 = EdgeInsets.only(bottom: 30, left: 16, right: 16);
  static const EdgeInsets kPaddingTop20Left16Right16 = EdgeInsets.only(top: 20, left: 16, right: 16);
  static const EdgeInsets kPaddingRight8Bottom14 = EdgeInsets.only(right: 8, bottom: 14);
  static const EdgeInsets kPaddingTop8 = EdgeInsets.only(top: 8);
  static const EdgeInsets kPaddingRight8 = EdgeInsets.only(right: 8);
  static const EdgeInsets kPaddingBottom10 = EdgeInsets.only(bottom: 10);
  static const EdgeInsets kPaddingBottom40 = EdgeInsets.only(bottom: 40);
  static const EdgeInsets kPaddingBottom4 = EdgeInsets.only(bottom: 4);
  static const EdgeInsets kPaddingBottom8 = EdgeInsets.only(bottom: 8);
  static const EdgeInsets kPaddingRight16 = EdgeInsets.only(right: 16);
  static const EdgeInsets kPaddingLeftBottom12 = EdgeInsets.only(left: 12, bottom: 12);
  static const EdgeInsets kPaddingTop8Others4 = EdgeInsets.only(top: 8, left: 4, right: 4, bottom: 4);




  /// border radius

  static const Radius kRadius8 = Radius.circular(8);
  static const Radius kRadius20 = Radius.circular(20);
  static const BorderRadius kBorderRadius = BorderRadius.zero;
  static const BorderRadius kBorderRadius2 = BorderRadius.all(Radius.circular(2));
  static const BorderRadius kBorderRadius4 = BorderRadius.all(Radius.circular(4));
  static const BorderRadius kBorderRadius6 = BorderRadius.all(Radius.circular(6));
  static const BorderRadius kBorderRadius8 = BorderRadius.all(Radius.circular(8));
  static const BorderRadius kBorderRadius10 = BorderRadius.all(Radius.circular(10));
  static const BorderRadius kBorderRadius12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius kBorderRadius16 = BorderRadius.all(Radius.circular(16));
  static const BorderRadius kBorderRadius20 = BorderRadius.all(Radius.circular(20));
  static const BorderRadius kBorderRadius24 = BorderRadius.all(Radius.circular(24));
  static const BorderRadius kBorderRadius28 = BorderRadius.all(Radius.circular(28));
  static const BorderRadius kBorderRadiusTop28 = BorderRadius.only(topRight: Radius.circular(28), topLeft: Radius.circular(28));
  static const BorderRadius kBorderRadiusTop20 = BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20));
  static const BorderRadius kBorderRadius32 = BorderRadius.all(Radius.circular(32));
  static const BorderRadius kBorderRadius40 = BorderRadius.all(Radius.circular(40));
  static const BorderRadius kBorderRadius50 = BorderRadius.all(Radius.circular(50));
  static const BorderRadius kBorderRadius64 = BorderRadius.all(Radius.circular(64));
  static const BorderRadius kBorderRadiusTopRight64Others24 = BorderRadius.only(topRight: Radius.circular(64), topLeft: Radius.circular(24),
      bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24));
  static const BorderRadius kBorderRadiusTopRight48Others24 = BorderRadius.only(topRight: Radius.circular(48), topLeft: Radius.circular(24),
      bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24));
  static const BorderRadius kBorderRadiusTopRight24Others12 = BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(12),
      bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12));
  static const BorderRadius kBorderRadiusBottomRight20Others10 = BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(10),
  topLeft: Radius.circular(10), topRight: Radius.circular(10));






  static const BoxConstraints kBoxConstraints24 = BoxConstraints(
    minWidth: 24,
    minHeight: 24,
    maxHeight: 24,
    maxWidth: 24,
  );


}