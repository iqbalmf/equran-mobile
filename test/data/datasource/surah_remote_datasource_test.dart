import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mockito/mockito.dart';
import 'package:my_equran/data/datasource/surah_remote_datasource.dart';
import 'package:my_equran/data/model/response_server.dart';

import '../../helper/helper.mocks.dart';
import '../../helper/json_reader.dart';

void main() {
  late MockApiHelper mockApiHelper;
  late SurahRemoteDataSourceImpl surahRemoteDataSourceImpl;
  setUp(() {
    mockApiHelper = MockApiHelper();
    surahRemoteDataSourceImpl = SurahRemoteDataSourceImpl(mockApiHelper);
  });
  final Map<String, dynamic> jsonMap = json.decode(jsonReader('surah.json'));
  final httpResponse = Future.value(ResponseServer(
      data: jsonReader('surah.json'),
      code: HttpStatus.ok,
      message: "Data retrieved successfully"));

  test('should return list SurahModel when response code 200', () async {
    when(mockApiHelper.request(
      "GET",
      '/surah/',
      contentType: anyNamed('contentType'),
      queryParams: anyNamed('queryParams'),
      content: anyNamed('content'),
    )).thenAnswer((_) async => httpResponse);
    final response = await surahRemoteDataSourceImpl.getAllSurah();
    expect(response.code, equals(HttpStatus.ok));
    expect(json.decode(response.data), equals(jsonMap));
  });

  test('should throw server failure when response code 404', () async {
    when(mockApiHelper.request(
      "GET",
      '/surah/',
      contentType: anyNamed('contentType'),
      queryParams: anyNamed('queryParams'),
      content: anyNamed('content'),
    )).thenAnswer((_) async => Future.value(ResponseServer(code: HttpStatus.notFound)));
    final response = await surahRemoteDataSourceImpl.getAllSurah();
    expect(response.code, equals(HttpStatus.notFound));
  });
}
