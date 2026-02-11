

import 'dart:developer';
import 'dart:io';

import 'package:alla/api/repository.dart';
import 'package:alla/api/repository_impl.dart';
import 'package:alla/core/local_source/local_source.dart';
import 'package:alla/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:alla/features/home/presentation/bloc/home_bloc.dart';
import 'package:alla/features/home_new/blocs/new_home_bloc.dart';
import 'package:alla/router/app_routes.dart';
import 'package:alla/router/name_routes.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_retry_plus/dio_retry_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'core/connectivity/network_info.dart';
import 'features/otp/presentation/bloc/otp_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

final GetIt sl = GetIt.instance;
late Box<dynamic> _box;

Future<void> init() async {
  /// External
  await _initHive();

  /// Dio - Basic setup without interceptors that depend on other services
  sl.registerLazySingleton(
        () => Dio()
      ..options = BaseOptions(
        contentType: 'application/json',
        headers: <String, String>{},
      )
      ..httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient()
            ..badCertificateCallback = (X509Certificate cert, String host, __) {
              log('host: $host');
              return true;
            };
          return client;
        },
        validateCertificate: (X509Certificate? cert, String host, __) {
          log('host: $host');
          if (cert == null) {
            return true;
          }
          return true;
        },
      )
      ..interceptors.add(
        LogInterceptor(
          error: kDebugMode,
          request: kDebugMode,
          requestBody: kDebugMode,
          responseBody: kDebugMode,
          requestHeader: kDebugMode,
          responseHeader: kDebugMode,
          logPrint: (Object object) {
            if (kDebugMode) {
              log('dio: $object');
            }
          },
        ),
      ),
  );

  /// Core - Register ALL dependencies first
  sl
    ..registerSingleton<LocalSource>(LocalSource(_box))
    ..registerLazySingleton(
          () => InternetConnectionChecker.createInstance(
        checkTimeout: const Duration(seconds: 3),
      ),
    )
    ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform)
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// features
  _authFeature();

  /// ✅ ONLY ONE Interceptor setup - AFTER all dependencies are registered
  sl<Dio>().interceptors.addAll(
      <Interceptor>[
        RetryInterceptor(
          dio: sl<Dio>(),
          retries: 1,
          toNoInternetPageNavigator: () async {
            final RouteMatch lastMatch =
                router.routerDelegate.currentConfiguration.last;
            final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
                ? lastMatch.matches
                : router.routerDelegate.currentConfiguration;
            final String location = matchList.uri.toString();

            if (location.contains(Routes.noInternet)) {
              return;
            }
            await router.pushNamed(Routes.noInternet);
          },
          accessTokenGetter: () => "Bearer ${sl<LocalSource>().accessToken}", // ✅ Use GetIt here
          refreshTokenFunction: () async {
            await sl<LocalSource>().clear().then((_) { // ✅ Use GetIt here
              router.goNamed(Routes.initial);
            });
          },
          logPrint: (String message) {
            if (kDebugMode) {
              log('dio: $message');
            }
          },
        ),
      ]
  );
}

void _authFeature() {
  /// use cases
  sl

  /// repositories
    ..registerLazySingleton<Repository>(() => RepositoryImpl(dio: sl()));

  /// bloc
    sl.registerFactory(() => AuthBloc(repository: sl()));
    sl.registerFactory(() => OtpBloc(repository: sl()));
    sl.registerFactory(() => HomeBloc(repository: sl()));
    sl.registerFactory(() => ProfileBloc(repository: sl()));
    sl.registerFactory(() => NewHomeBloc(repository: sl()));
}

Future<void> _initHive() async {
  const String boxName = 'mentor_attendance_lms';
  final Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  _box = await Hive.openBox<dynamic>(boxName);
}

//
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:alla/api/repository.dart';
// import 'package:alla/api/repository_impl.dart';
// import 'package:alla/core/local_source/local_source.dart';
// import 'package:alla/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:alla/router/app_routes.dart';
// import 'package:alla/router/name_routes.dart';
// import 'package:dio/dio.dart';
// import 'package:dio/io.dart';
// import 'package:dio_retry_plus/dio_retry_plus.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:go_router/go_router.dart';
// import 'package:package_info_plus/package_info_plus.dart';
//
// import 'core/connectivity/network_info.dart';
//
// final GetIt sl = GetIt.instance;
// late Box<dynamic> _box;
//
// Future<void> init() async {
//   /// External
//   await _initHive();
//
//   /// Dio
//   sl.registerLazySingleton(
//       () => Dio()
//
//           ..options = BaseOptions(
//             contentType: 'application/json',
//             headers: <String, String>{},
//           )
//
//           ..httpClientAdapter = IOHttpClientAdapter(
//             createHttpClient: () {
//               final HttpClient client = HttpClient()
//                   ..badCertificateCallback = (X509Certificate cert, String host, __) {
//                     log('host: $host');
//                     return true;
//                   };
//               return client;
//             },
//
//             validateCertificate: (X509Certificate? cert, String host, __) {
//               log('host: $host');
//               if (cert == null) {
//                 return true;
//               }
//
//               return true;
//             },
//           )
//           ..interceptors.add(
//             LogInterceptor(
//               error: kDebugMode,
//               request: kDebugMode,
//               requestBody: kDebugMode,
//               responseBody: kDebugMode,
//               requestHeader: kDebugMode,
//               responseHeader: kDebugMode,
//               logPrint: (Object object) {
//                 if (kDebugMode) {
//                   log('dio: $object');
//                 }
//               },
//             ),
//           ),
//   );
//
//   sl<Dio>().interceptors.addAll(
//     <Interceptor> [
//       RetryInterceptor(
//           dio: sl<Dio>(),
//           retries: 1,
//           toNoInternetPageNavigator: () async {
//             final RouteMatch lastMatch =
//                 router.routerDelegate.currentConfiguration.last;
//             final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
//               ? lastMatch.matches
//               : router.routerDelegate.currentConfiguration;
//             final String location = matchList.uri.toString();
//
//             if (location.contains(Routes.noInternet)) {
//               return;
//             }
//             await router.pushNamed(Routes.noInternet);
//           },
//           accessTokenGetter: () => "Bearer ${localSource.accessToken}",
//           refreshTokenFunction: () async {
//             await localSource.clear().then(
//                 (_) {
//                   router.goNamed(Routes.initial);
//                 }
//             );
//           },
//           logPrint: (String message) {
//             if (kDebugMode) {
//               log('dio: $message');
//             }
//           },
//       ),
//     ]
//   );
//
//   /// Core
//   sl
//     ..registerSingleton<LocalSource>(LocalSource(_box))
//     ..registerLazySingleton(
//         () => InternetConnectionChecker.createInstance(
//           checkTimeout: const Duration(seconds: 3),
//         ),
//     )
//     ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform)
//     ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//
//
//     /// main
//     // ..registerFactory(MainBloc.new);
//
//   /// features
//   _authFeature();
//
// }
//
//
// void _authFeature() {
//   /// use cases
//   sl
//
//   /// repositories
//     ..registerLazySingleton<Repository>(() => RepositoryImpl(dio: sl()))
//
//   /// bloc
//     ..registerFactory(() => AuthBloc(repository: sl()));
// }
//
// Future<void> _initHive() async {
//   const String boxName = 'mentor_attendance_lms';
//   final Directory directory = await getApplicationDocumentsDirectory();
//   Hive.init(directory.path);
//   _box = await Hive.openBox<dynamic>(boxName);
// }