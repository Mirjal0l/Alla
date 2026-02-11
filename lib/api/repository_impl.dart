
import 'dart:convert'; // For JSON encoding/decoding
import 'dart:developer';

import 'dart:developer'; // for logging

//import 'package:http/http.dart' as http; // For Http request
import 'package:alla/core/either/either.dart';
import 'package:alla/core/error/server_error.dart';
import 'package:alla/features/auth/data/models/requests/send_otp_request.dart';
import 'package:alla/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:alla/features/auth/data/models/responses/send_otp_response.dart';
import 'package:alla/features/auth/data/models/responses/verify_otp_response.dart';
import 'package:alla/features/home/data/model/category_response_old.dart';
import 'package:alla/features/home/presentation/bloc/home_bloc.dart';
import 'package:alla/features/home_new/blocs/new_home_bloc.dart';
import 'package:alla/features/home_new/models/category_content.dart';
import 'package:dio/dio.dart';

import '../constants/constants.dart'; // For URLs
import '../core/error/failure.dart';
import '../features/home_new/models/category_response.dart';
import '../features/profile/data/model/profile_response.dart';
import '../router/app_routes.dart';
import 'repository.dart'; // The abstract interface

// Explanation: This class IMPLEMENTS the abstract repository
// Explanation: Either is a functional programming concept that represents
// either a Success (Right) or Failure (Left)
// This helps us handle errors in a type-safe way

class RepositoryImpl implements Repository {
  const RepositoryImpl({required this.dio});

  final Dio dio;


  @override
  Future<Either<Failure, SendOtpResponse>> sendOtp(
      {required SendOtpRequest request}) async {
    try {
      // Explanation: We use Dio instead of http package
      // Dio has better error handling, interceptors, and more features
      final Response response = await dio.post(
        Constants.baseUrl + Urls.sendOtp, // Combine base url + endpoint
        data: request.toJson(), // Dio automatically conversts to JSON
      );

      // LOG: What we're sending to API
      print('VERIFY OTP API CALL');
      print('URL: ${Constants.baseUrl + Urls.sendOtp}');
      print('Request Data: ${jsonEncode(request)}');

      // LOG: What we receive from API
      print('SEND OTP SUCCESS');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      print('!!!!!!!! SendOTP !!!!!! : ${response.data}');
      // success case - return Right with the response data
      return Right(SendOtpResponse.fromJson(response.data));
    } on DioException catch (error, stacktrace) {
      // Dio-specific errors (network errors, server errors, etc.)
      log("DioException occured: $error stacktrace: $stacktrace");
      return Left(ServerError
          .withDioError(error: error)
          .failure);
    } on Exception catch (error, stacktrace) {
      // Generic exceptions
      log("Exception occured: $error stacktrace: $stacktrace");
      return Left(ServerError
          .withError(message: error.toString())
          .failure);
    }
  }

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(
      {required VerifyOtpRequest request}) async {
    try {
      final Response response = await dio.post(
        Constants.baseUrl + Urls.verifyOtp,
        data: request.toJson(),
        options: Options(headers: {
          "Authorization": "Bearer ${localSource.accessToken}",
        }),

      );

      // LOG: What we're sending to API
      print('VERIFY OTP API CALL');
      print('URL: ${Constants.baseUrl + Urls.verifyOtp}');
      print('Request Data: ${jsonEncode(request)}');

      // LOG: What we received from API
      print('VERIFY OTP SUCCESS');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');


      print('!!!!!!!! VerifyOTP !!!!!! : ${response.data}');
      return Right(VerifyOtpResponse.fromJson(response.data));
    } on DioException catch (error, stacktrace) {
      log('Dio exception occured: $error stacktrace: $stacktrace');
      return Left(ServerError
          .withDioError(error: error)
          .failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occured: $error stacktrace: $stacktrace');
      return Left(ServerError
          .withError(message: error.toString())
          .failure);
    }
  }

   @override
  Future<Either<Failure, CategoryResponseOld>> getApiCategories({required bool activeOnly}) async {
    try {
      final Response response = await dio.get(
          Constants.baseUrl + Urls.getCategories,
          data: activeOnly,
          options: Options(headers: {
            "Authorization": "Bearer ${localSource.accessToken}",
          }),
          queryParameters: {
            "activeOnly": true
          }
      );

      print('GETCATEGORIES OTP API CALL');
      print('URL: ${Constants.baseUrl + Urls.getCategories}');

      return Right(CategoryResponseOld.fromJson(response.data));
    } on DioException catch(error, stacktrace) {
      log('Dio exception occured: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch(error, stacktrace) {
      log('Exception occured: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, ProfileResponse>> getProfileData() async {
    try {
      final Response response = await dio.get(
        Constants.baseUrl + Urls.getProfile,
        options: Options(headers: {
          'Authorization': 'Bearer ${localSource.accessToken}',
        }),
      );

      print("GET PROFILE API CALL");
      print("URL: ${Constants.baseUrl + Urls.getProfile}");

      return Right(ProfileResponse.fromJson(response.data));
    } on DioException catch (error, stacktrace) {
      log('Dio exeption occured: $error stactrace: $stacktrace');
      return Left(ServerError
          .withDioError(error: error)
          .failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occured: $error stacktrace: $stacktrace');
      return Left(ServerError
          .withError(message: error.toString())
          .failure);
    }
  }


  // above is not in use now (hozircha)


  @override
  Future<Either<Failure, CategoryResponse>> getNewCategories({required bool activeOnly, String? id}) async {
    try {
      final Response response = await dio.get(
          '${Constants.baseUrl}${Urls.getApiCategoriesTree}',
          options: Options(headers: {
            "Authorization": "Bearer ${localSource.accessToken}",
          }),
          queryParameters: {
            'activeOnly': true,
          }
      );
      return Right(CategoryResponse.fromJson(response.data));
    } on DioException catch (error, stacktrace) {
      log('Exception occured -: $error stacktrace: $stacktrace');
      return Left(ServerError
          .withDioError(error: error)
          .failure);
    } on Exception catch (error, stacktrace) {
      log("Exception occured --: $error stacktrace: $stacktrace");
      return Left(ServerError
          .withError(message: error.toString())
          .failure);
    }
  }

  @override
  Future<Either<Failure, CategoryContent>> getLastSeen() async {
    try {
      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.getLastSeen}',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${localSource.accessToken}',
          }
        ),
      );
      return Right(CategoryContent.fromJson(response.data));
    } on DioException catch (error, stacktrace) {
      log('Exception occured -: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occured --: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, CategoryContent>> getVideoById({required String categoryId}) async {
    try {
      final Response response = await dio.get(
          '${Constants.baseUrl}${Urls.getVideoById}${categoryId}/cards',
          options: Options(headers: {
            'Authorization': "Bearer ${localSource.accessToken}",
          })
      );
      return Right(CategoryContent.fromJson(response.data));
    } on DioException catch (error, stacktrace) {
      log('Exception occurced -: $error stacktrace: $stacktrace');
      return Left(ServerError
          .withDioError(error: error)
          .failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occured --: $error stacktrace: $stacktrace');
      return Left(ServerError
          .withError(message: error.toString())
          .failure);
    }
  }

  @override
  Future<Either<Failure, CategoryContent>> getBookById({required String categoryId}) async {
    try {
      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.getBookById}${categoryId}/cards',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${localSource.accessToken}',
          },
        ),
      );
      return Right(CategoryContent.fromJson(response.data));
    } on DioException catch (error, stacktrace) {
      log('Exception occured -: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occured --: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, CategoryContent>> getGameById({required String categoryId}) async {
    try {
      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.getGameById}${categoryId}/cards',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${localSource.accessToken}'
          }
        ),
      );

      return Right(CategoryContent.fromJson(response.data));
    } on DioException catch (error, stacktrace) {
      log('Exception occured -: $error stacktrace; $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occured --: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, CategoryContent>> getPremiere() async {
    try {
      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.getPremiere}',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${localSource.accessToken}'
          }
        )
      );

      return Right(CategoryContent.fromJson(response.data));
    } on DioException catch (error, stacktrace) {
      log('Exception occured -: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occured --: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

}