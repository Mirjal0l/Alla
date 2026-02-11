

import 'dart:ffi';
import 'dart:io';

import 'package:alla/constants/constants.dart';
import 'package:alla/core/utils/utils.dart';
import 'package:hive/hive.dart';

final class LocalSource {
  LocalSource(this.box);
  final Box<dynamic> box;

  bool get hasProfile => box.get(AppKeys.hasProfile, defaultValue: false);

  Future<void> setHasProfile({required bool value}) async {
    await box.put(AppKeys.hasProfile, value);
  }

  Future<void> setLocale(String locale) async {
    await box.put(AppKeys.locale, locale);
  }

  String get locale => box.get(AppKeys.locale, defaultValue: defaultLocale);

  Future<void> setAccessToken(String accessToken) async {
    await box.put(AppKeys.accessToken, accessToken);
  }

  String get accessToken => box.get(AppKeys.accessToken, defaultValue: '');

  Future<void> setRefreshToken(String refreshToken) async {
    await box.put(AppKeys.refreshToken, refreshToken);
  }
  String get refreshToken => box.get(AppKeys.refreshToken, defaultValue: '');

  Future<void> setFirstName(String firstName) async {
    await box.put(AppKeys.firstname, firstName);
  }

  String getfirstName() => box.get(AppKeys.firstname, defaultValue: '');

  Future<void> setPhoneNumber(String phoneNumber) async {
    await box.put(AppKeys.phoneNumber, phoneNumber);
  }

  String phoneNumber() => box.get(AppKeys.phoneNumber, defaultValue: '');

  Future<void> setLastName(String lastName) async {
    await box.put(AppKeys.lastname, lastName);
  }

  String getlastName() => box.get(AppKeys.lastname, defaultValue: '');


  Future<void> setPassword(String password) async {
    await box.put(AppKeys.password, password);
  }

  String? get password => box.get(AppKeys.password);

  // hasOnBoarding
  Future<void> setHasOnboarding({required bool value}) async {
    await box.put(AppKeys.hasOnboarding, value);
  }

  bool get hasOnboarding => box.get(AppKeys.hasOnboarding, defaultValue: true);

  // Profile image
  Future<void> setProfileImagePath(File imagePath) async {
    await box.put(AppKeys.profileImage, imagePath);
  }

  File? get profileImagePath => box.get(AppKeys.profileImage);

  Future<void> setAge(String age) async {
    await box.put(AppKeys.age, age);
  }

  String get age => box.get(AppKeys.age) ?? '1';

  Future<void> clear() async {
    await box.clear();
  }

}