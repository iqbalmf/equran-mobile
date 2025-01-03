class ServerException implements Exception {}

class CacheException implements Exception {}

class InternetException implements Exception{
  final String message;

  InternetException({required this.message});

  @override
  String toString() {
    return 'InternetException: $message)';
  }
}
