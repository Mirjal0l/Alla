
import 'package:alla/core/error/failure.dart';
import 'package:dio/dio.dart';

final class ServerError implements Exception {
  ServerError.withDioError({required DioException error}) {
    _handleError(error);
  }

  ServerError.withError({
    required String message,
    int? code,
  }) {
    _errorMessage = message;
    _errorCode = code;
  }

  int? _errorCode;
  String _errorMessage = "";
  int get errorCode => _errorCode ?? 0;
  String get errorMessage => _errorMessage;

  void _handleError(DioException error) {
    _errorCode = error.response?.statusCode ?? 500;

    if (_errorCode == 500) {
      _errorMessage = "Server error";
      return;
    }
    if (_errorCode == 502) {
      _errorMessage = "Server down";
      return;
    }
    if (_errorCode == 404) {
      _errorMessage = "User didn't found";
      return;
    }
    if (_errorCode == 413) {
      _errorMessage = "Request Entity Too Large";
      return;
    }
    if (_errorCode == 401 || _errorCode == 403) {
      _errorMessage = "Token expired";
      return;
    }
    if (_errorCode == 400) {
      _errorMessage = "Incorrect password";
      return;
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        _errorMessage = "Connection timeout";
      case DioExceptionType.sendTimeout:
        _errorMessage = "Connection timeout";
      case DioExceptionType.receiveTimeout:
        _errorMessage = "Connection timeout";
      case DioExceptionType.badResponse:
        {
          _errorMessage = error.response!.data;
          break;
        }
      case DioExceptionType.cancel:
        _errorMessage = "Canceled";
      case DioExceptionType.unknown:
        _errorMessage = "Something wrong";
      case DioExceptionType.badCertificate:
        _errorMessage = "Bad certificate";
      case DioExceptionType.connectionError:
        _errorMessage = "Connection error";
    }
    return;
  }
}

extension ServerErrorExtension on ServerError {
  bool get isTokenExpired => errorCode == 401;

  ServerFailure get failure => ServerFailure(
    message: errorMessage,
    statusCode: errorCode
  );
}