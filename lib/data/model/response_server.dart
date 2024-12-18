class ResponseServer {
  final dynamic data;
  final int? code;
  final String? message;

  ResponseServer({this.code, this.message, this.data});

  @override
  String toString() {
    return 'code: $code\nmessage: $message\ndata: $data';
  }
}