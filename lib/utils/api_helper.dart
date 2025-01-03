import 'package:dio/dio.dart';
import 'package:my_equran/core/error/exceptions.dart';
import 'package:my_equran/core/flavors.dart';
import 'package:my_equran/data/model/response_server.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class ApiHelper {
  late Dio _dio;

  ApiHelper(Dio dio) {
    _dio = dio;

    _dio.interceptors.add(PrettyDioLogger(
      request: Flavor.dev.isDevelopment,
      requestBody: Flavor.dev.isDevelopment,
      requestHeader: Flavor.dev.isDevelopment,
      responseBody: Flavor.dev.isDevelopment,
    ));
  }

  Future<dynamic> request(String method, String path,
      {required String contentType,
        Map<String, dynamic>? queryParams,
        dynamic content}) async {
    late Response response;
    var _data = content;
    var headers = {
      "content-type": contentType,
    };
    _dio.options.headers = headers;
    _dio.options.connectTimeout = const Duration(seconds: 8000);
    _dio.options.receiveTimeout = const Duration(seconds: 8000);

    try {
      if (method == 'POST') {
        response =
        await _dio.post(path, data: _data, queryParameters: queryParams);
      } else {
        response = await _dio.get(path,
            queryParameters: queryParams,
            options: Options(contentType: contentType));
      }

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return ResponseServer(
            data: response.data,
            message: response.statusMessage,
            code: response.statusCode);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw InternetException(
            message: 'Connection timed out. Please check your network.',);
      } else if (e.type == DioExceptionType.connectionError) {
        throw InternetException(
          message: 'No Internet Connection!',);
      }
    }
    catch (e) {
      // Catch any other non-Dio errors
      throw InternetException(message: 'An unexpected error occurred.');
    }
  }
}
