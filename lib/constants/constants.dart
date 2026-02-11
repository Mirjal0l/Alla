import 'dart:io';

// all fixed values
sealed class Constants {
  Constants._(); // private constructor cant e instatiated

  static const String baseUrl = "https://api.alla.itic.uz";

  // static final String appLink = Platform.isIOS ? "https://apps.apple.com..." : "";
}

class Validations {
  Validations._();
  static const String emailEmpty = "Email cannot be empty";
  static const String notEmail = "This is not email";
  static const String passwordEmpty = "Password cannot be empty";
  static const String passwordShort = "Password too short";
  static const String passwordLong = "Password too long";
  static const String firstnameEmpty = "Firstname cannot be empty";
  static const String firstnameShort = "Firstname too short";
  static const String firstnameLong = "Firstname too long";
  static const String lastnameEmpty = "Last name cannot be empty";
  static const String lastnameShort = "Lastname too short";
  static const String lastnameLong = "Lastname too long";
  static const String passwordNotMatch = "Passwords do not match";
  static const String internetFailure = "No Internet";
  static const String somethingWentWrong = "Something went wrong!";
}

sealed class AppKeys {
  AppKeys._();
  static const String locale = "locale";
  static const hasProfile = "has_profile";
  static const String accessToken = "access_token";
  static const String refreshToken = "refresh_token";
  static const String firstname = "firstname";
  static const String lastname = "lastname";
  static const String email = "email";
  static const String password = "password";
  static const String themeMode = "theme_mode";
  static const String hasOnboarding = "has_onboarding";
  static const String languageImage = "language";
  static const String phoneNumber = "phone_number";
  static const String profileImage = 'profile_image';
  static const String age = 'age';


}

sealed class Urls {
  Urls._();

  //All your API endpoints from Swagger
  static const String sendOtp = "/api/auth/send-otp";
  static const String verifyOtp = "/api/auth/verify-otp";
  static const String selectAccount = "/api/auth/select-account";
  static const String createAccount = "/api/auth/create-account";

  static const String getCategories = "/api/categories/tree"; // eski
  static const String getProfile = "/api/user/profile";

  static const String getApiCategoriesTree = '/api/categories/tree';
  static const String getVideoById = '/api/content/videos/category/';
  static const String getLastSeen = '/api/user/watch-history';
  static const String getBookById = '/api/content/books/category/';
  static const String getGameById = '/api/content/games/category/';
  static const String getPremiere = '/api/videos/premiere';
}