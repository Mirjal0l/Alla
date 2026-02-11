
sealed class Routes {

  Routes._(); // prevent instantiation

  static const String initial = '/';
  static const String onboarding = '/onboarding';
  // static const String home = '/home';
  static const String downloaded = '/downloaded';
  // new
  static const String search = '/search';
  static const String favorites = '/favorites';
  //
  static const String profile = '/profile';
  static const String login = '/login';
  static const String info = '/info';
  static const String otp_page = '/otp/:phone';

  static const String noInternet = '/no-internet';
  static const String eduContentDetails = '/edu-content-details';
  static const String eduContentPage = '/edu-content-page';
  static const String gamePage = '/game-page';
  static const String gamePageDetails = '/game-page-details';
  static const String homePageContent = '/home-page-content';
  static const String videoPlayer = '/video-player';
  static const String audioPlayer = '/audio-player';

  // new
  static const String newHomePage = '/new-home-page';
  static const String newHomeDetails = '/new-home-details';

}