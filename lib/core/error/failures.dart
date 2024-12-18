import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String message;

  Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure({String? message, int? httpStatus, final String? responseCode})
      : super(message ?? "Server Failure");
}

class CacheFailure extends Failure {
  CacheFailure({
    String? message,
  }) : super(message ?? 'Cache Failure');
}
