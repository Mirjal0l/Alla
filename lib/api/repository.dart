
// Explanation: This abstract class defines a CONTRACT for what our API can do
// It doesn't implement HOW to do it, just WHAT can be done
// This is called "abstraction" - we hide implementation details


import 'package:alla/features/auth/data/models/requests/send_otp_request.dart';
import 'package:alla/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:alla/features/auth/data/models/responses/send_otp_response.dart';
import 'package:alla/features/auth/data/models/responses/verify_otp_response.dart';
import 'package:alla/features/home/data/model/category_response_old.dart';
import 'package:alla/features/home_new/models/category_response.dart';
import 'package:alla/features/profile/data/model/profile_response.dart';

import '../core/either/either.dart';
import '../core/error/failure.dart';
import '../features/home_new/models/category_content.dart';

abstract class Repository {
  // Send OTP to phone number
  // Explanation: Returns Future because API calls are asynchronous
  // We use AuthRequest and AuthResponse for all operations

const Repository();
  // All methods now return Either<Failure, AuthResponse>
  // This means: either we get a Failure OR we get AuthResponse
  Future<Either<Failure, SendOtpResponse>> sendOtp({required SendOtpRequest request});
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp({required VerifyOtpRequest request});
  Future<Either<Failure, CategoryResponseOld>> getApiCategories({required bool activeOnly});// eski
  Future<Either<Failure, ProfileResponse>> getProfileData();
  Future<Either<Failure, CategoryResponse>> getNewCategories({required bool activeOnly, String? id});
  Future<Either<Failure, CategoryContent>> getVideoById({required String categoryId});
  Future<Either<Failure, CategoryContent>> getLastSeen();
  Future<Either<Failure, CategoryContent>> getBookById({required String categoryId});
  Future<Either<Failure, CategoryContent>> getGameById({required String categoryId});
  Future<Either<Failure, CategoryContent>> getPremiere();

}