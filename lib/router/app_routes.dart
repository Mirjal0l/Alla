

import 'package:alla/features/home/home_page.dart';
import 'package:alla/features/main/main_page.dart';
import 'package:alla/features/profile/profile_page.dart';
import 'package:alla/router/name_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../features/downloaded/downloaded_page.dart';
import '../features/onboarding/onboarding.dart';
import '../features/splash/splash_page.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: Routes.initial,
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.initial,
      name: Routes.initial,
      builder: (_, __) => const SplashPage(),
    ),

    GoRoute(
      path: Routes.onboarding,
      name: Routes.onboarding,
      builder: (_, __) => const Onboarding(),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainPage(
        navigationShell: navigationShell,
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          initialLocation: Routes.home,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.home,
              name: Routes.home,
              builder: (_, __) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.downloaded,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.downloaded,
              name: Routes.downloaded,
              builder: (_, __) => const DownloadedPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.profile,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.profile,
              name: Routes.profile,
              builder: (_, __) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);