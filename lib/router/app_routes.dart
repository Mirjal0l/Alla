

import 'package:alla/features/audio_player/audio_player_page.dart';
import 'package:alla/features/auth/presentation/pages/info.dart';
import 'package:alla/features/home/home_page.dart';
import 'package:alla/features/home/presentation/bloc/home_bloc.dart';
import 'package:alla/features/home/presentation/pages/educational_content_page/edu_content_details.dart';
import 'package:alla/features/home/presentation/pages/educational_content_page/educational_content_page.dart';
import 'package:alla/features/home/presentation/pages/game_page/game_page.dart';
import 'package:alla/features/home/presentation/pages/home_page_content.dart';
import 'package:alla/features/home_new/blocs/new_home_bloc.dart';
import 'package:alla/features/home_new/new_home_page.dart';
import 'package:alla/features/home_new/presentation/pages/new_home_page_details.dart';
import 'package:alla/features/main/main_page.dart';
import 'package:alla/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:alla/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:alla/features/profile/profile_page.dart';
import 'package:alla/features/video_player/video_player_page.dart';
import 'package:alla/router/name_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/local_source/local_source.dart';
import '../features/auth/login_page.dart';
import '../features/favorites/favorites_page.dart';
import '../features/home/presentation/pages/game_page/game_page_details.dart';
import '../features/otp/otp_page.dart';
import '../features/downloaded/downloaded_page.dart';
import '../features/onboarding/onboarding.dart';
import '../features/others/presentation/pages/internet_connection/internet_connection.dart';
import '../features/others/presentation/pages/splash/splash_page.dart';
import '../features/search/search_page.dart';
import '../injector_container.dart';


final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

// final LocalSource localSource = sl<LocalSource>();

LocalSource get localSource => sl<LocalSource>();

//Before: final LocalSource localSource = sl<LocalSource>(); runs immediately when the file is imported, before init() is called
// After: LocalSource get localSource => sl<LocalSource>(); only runs when the getter is actually called, which happens after init() has completed

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

    GoRoute(
      path: Routes.login,
      name: Routes.login,
      builder: (_, __) => const LoginPage(),
    ),

    GoRoute(
      path: Routes.info,
      name: Routes.info,
      builder: (_, __) => const Info(),
    ),


    GoRoute(
      path: Routes.noInternet,
      name: Routes.noInternet,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const InternetConnectionPage()
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainPage(
        navigationShell: navigationShell,
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          initialLocation: Routes.newHomePage,
          routes: <RouteBase>[

            // previous home page
            //
            // GoRoute(
            //   path: Routes.home,
            //   name: Routes.home,
            //   // parentNavigatorKey: rootNavigatorKey,
            //   pageBuilder: (context, state)  => buildPageWithDefaultTransition<void>(
            //       context: context,
            //       state: state,
            //       child: BlocProvider<HomeBloc>(
            //         create: (_) => sl<HomeBloc>(),
            //         child: const HomePage(),
            //       )),
            // ),


            // NEW HOME PAGE
            GoRoute(
              path: Routes.newHomePage,
              name: Routes.newHomePage,
              builder: (context, state) =>
                BlocProvider<NewHomeBloc>(
                  create: (context) => sl<NewHomeBloc>(),
                  child: const NewHomePage(),
                ),
            ),

            // NEW HOME PAGE DETAILS
            GoRoute(
              path: '/new-home-details/:index1/:index2',
              name: Routes.newHomeDetails,
              builder: (context, state) {
                final index1 = int.tryParse(state.pathParameters['index1'] ?? '0') ?? 0;
                final index2 = int.tryParse(state.pathParameters['index2'] ?? '0') ?? 0;

                final imagePath = state.extra as String?;
                return NewHomePageDetails(imagePath: imagePath, index1: index1, index2: index2,);
              }
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
          initialLocation: Routes.search,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.search,
              name: Routes.search,
              builder: (_, __) => const SearchPage(),
            )
          ]
        ),

        StatefulShellBranch(
          initialLocation: Routes.favorites,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.favorites,
              name: Routes.favorites,
              builder: (_, __) => const FavoritesPage(),
            )
          ]
        ),

        StatefulShellBranch(
          initialLocation: Routes.profile,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.profile,
              name: Routes.profile,
              pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                  context: context,
                  state: state,
                  child: BlocProvider<ProfileBloc>(
                      create: (_) => sl<ProfileBloc>(),
                    child: const ProfilePage(),
                  )
              )
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: Routes.otp_page,
      name: Routes.otp_page,
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: BlocProvider<OtpBloc>(
            create: (_) => sl<OtpBloc>(),
            // child: OtpPage(otp: state.extra! as String),
            child: const OtpPage(),
          )
      ),
    ),

    GoRoute(
      path: '/edu-content/:index',
      name: Routes.eduContentDetails,
      builder: (context, state) {
        final index = int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
        return EduContentDetails(index: index);
      }
    ),

    // Fix the eduContentPage route - add a builder or remove if not needed
    GoRoute(
      path: '/educational-content',
      name: Routes.eduContentPage,
      builder: (_, __) => const EducationalContentPage(),
    ),

// Fix the homePageContent route
    GoRoute(
      path: '/home-content-page/:index',
      name: Routes.homePageContent,
      pageBuilder: (context, state) {
        final index = int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
        return buildPageWithDefaultTransition(context: context, state: state, child: const NewHomePage());
      },
    ),

// Game page route is fine
    GoRoute(
      path: '/game',
      name: Routes.gamePage,
      builder: (_, __) => const GamePage(),
    ),

    GoRoute(
      path: '/game-page-details/:index',
      name: Routes.gamePageDetails,
      builder: (context, state) {
        final index = int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
        return GamePageDetails(index: index);
      }
    ),

    GoRoute(
      path: Routes.videoPlayer,
      name: Routes.videoPlayer,
      builder: (context, state) {
        return VideoPlayerPage(url: 'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8');
      }
    ),

    GoRoute(
      path: Routes.audioPlayer,
      name: Routes.audioPlayer,
      builder: (context, state) {
        return AudioPlayerPage();
      }
    )



    // GoRoute(
    //   path: Routes.otp_page,
    //   name: Routes.otp_page,
    //   pageBuilder: (context, state) {
    //     // ✅ Debug the incoming data
    //     print('🔄 APP ROUTES - OTP Page Data:');
    //     print('   State extra: ${state.extra}');
    //     print('   State pathParameters: ${state.pathParameters}');
    //
    //     final Map<String, dynamic> extra = state.extra as Map<String, dynamic>? ?? {};
    //     final String phone = extra['phone']?.toString() ?? '';
    //     final String otpCode = extra['otp']?.toString() ?? '';
    //
    //     print('   Extracted phone: $phone');
    //     print('   Extracted OTP: $otpCode');
    //
    //     return buildPageWithDefaultTransition<void>(
    //         context: context,
    //         state: state,
    //         child: BlocProvider<OtpBloc>(
    //           create: (_) => sl<OtpBloc>(),
    //           child: const OtpPage(),
    //         )
    //     );
    //   },
    // ),
  ],
);



CustomTransitionPage buildPageWithDefaultTransition<T>({required BuildContext context, required GoRouterState state, required Widget child}) => CustomTransitionPage<T>(
  key: state.pageKey,
  child: child,
  transitionDuration: const Duration(milliseconds: 350),
  reverseTransitionDuration: const Duration(milliseconds: 350),
  transitionsBuilder: (_, a1, a2, child) => SlideTransition(
    position: t1.animate(a1),
    child: child,
  ),
);

Tween<Offset> t1 = Tween<Offset>(
  begin: const Offset(1, 0),
  end: Offset.zero,
);