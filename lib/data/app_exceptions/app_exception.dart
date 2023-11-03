import '../../utils/app_helper/app_strings.dart';

class AppException implements Exception {
  final String? _message;
  final String? _prefix;
  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix $_message";
  }
}

class InternetException extends AppException {
  InternetException([String? message]) : super(message, AppStrings.noInternet);
}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message]) : super(message, AppStrings.requestTimeOut);
}

class ServerException extends AppException {
  ServerException([String? message]) : super(message, AppStrings.serverError);
}

class AppError extends AppException {
  AppError([String? message]) : super(message, AppStrings.apiCallError);
}

class DatabaseException extends AppException {
  DatabaseException([String? message])
      : super(message, AppStrings.databaseError);
}

class InvalidUrl extends AppException {
  InvalidUrl([String? message]) : super(message, AppStrings.invalidUrl);
}

class UnauthorizedAccessException extends AppException {
  UnauthorizedAccessException([String? message])
      : super(message, AppStrings.invalidUser);
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, AppStrings.errorOccured);
}

class UnableToConvert extends AppException {
  UnableToConvert([String? message]) : super(message, AppStrings.errorDataType);
}

class UnableToLogin extends AppException {
  UnableToLogin([String? message]) : super(message, AppStrings.errorLogin);
}

class InternalServerException extends AppException {
  InternalServerException([String? message])
      : super(message, AppStrings.errorLogin);
}

class AWSBucketException extends AppException {
  AWSBucketException([String? message]) : super(message, "AWS Bucket Error:");
}

class Uint8ListConvertException extends AppException {
  Uint8ListConvertException([String? message])
      : super(message, "Uint8ListConvertException conversion error:");
}

class ChutiyaException extends AppException {
  ChutiyaException([String? message])
      : super(message, "ChutiyaException error:");
}
