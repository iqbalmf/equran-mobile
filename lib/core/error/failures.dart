import 'package:equatable/equatable.dart';
import 'package:my_equran/core/error/exceptions.dart';

abstract class Failure extends Equatable implements Exception {
  final String message;

  Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure({String? message, int? httpStatus, final String? responseCode})
      : super(message ?? "An unexpected error occurred.");
}

class CacheFailure extends Failure {
  CacheFailure({
    String? message,
  }) : super(message ?? 'Cache Failure');
}

class NoConnectionFailure extends Failure {
  NoConnectionFailure({
    String? message,
  }) : super(message ?? "No Internet Connection!");
}
