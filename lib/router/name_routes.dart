
sealed class Routes {

  Routes._(); // prevent instantiation

  static const String initial = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String downloaded = '/downloaded';
  static const String profile = '/profile';
  static const String login = '/login';
  static const String info = '/info';
  static const String otp_page = '/otp/:phone';
}