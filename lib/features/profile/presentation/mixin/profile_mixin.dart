

import 'package:alla/features/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

mixin ProfileMixin on State<ProfilePage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formatPhoneNumber(String phoneNumber) {
    // remove all non-digit characters
    String digitsOnly = phoneNumber.replaceAll(' ', '');

    // if it starts with +998, handle it like this
    if (phoneNumber.startsWith('+998')) {
      digitsOnly = digitsOnly.substring(4);
    }

    // ensure we have 9 digits
    if (digitsOnly.length == 9) {
      return '+998 ${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2, 5)} ${digitsOnly.substring(5, 7)} ${digitsOnly.substring(7)}';
    }

    // else return formatted
    return phoneNumber; // return original if invalid
  }


}