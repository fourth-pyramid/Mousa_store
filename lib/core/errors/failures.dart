import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.server([
    @Default('An error occurred on the server') String message,
    int? statusCode,
  ]) = ServerFailure;

  const factory Failure.network([
    @Default('No internet connection') String message,
  ]) = NetworkFailure;

  const factory Failure.cache([
    @Default('Local storage error occurred') String message,
  ]) = CacheFailure;

  const factory Failure.auth([
    @Default('Authentication failure') String message,
  ]) = AuthFailure;

  const factory Failure.validation([
    @Default('Validation error occurred') String message,
  ]) = ValidationFailure;

  const factory Failure.unknown([
    @Default('An unexpected error occurred') String message,
  ]) = UnknownFailure;

  String get errorMessage => when(
        server: (message, _) => message,
        network: (message) => message,
        cache: (message) => message,
        auth: (message) => message,
        validation: (message) => message,
        unknown: (message) => message,
      );
}
