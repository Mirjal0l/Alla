part of '../splash_page.dart';

mixin SplashMixin on State<SplashPage> {

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    }
    Future.delayed(const Duration(seconds: 2), () async {
      nextToNavigation();
    });
  }

  Future<void> nextToNavigation() async {
    print('TOKEN: ${localSource.accessToken}');
    if (localSource.accessToken.isEmpty) {
      context.goNamed(Routes.onboarding);
    } else {
      context.goNamed(Routes.newHomePage);
    }
  }
}