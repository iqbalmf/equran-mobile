import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:my_equran/data/datasource/surah_remote_datasource.dart';
import 'package:my_equran/domain/repository/surah_repository.dart';
import 'package:my_equran/utils/api_helper.dart';

@GenerateMocks(
  [ApiHelper, SurahRepository, SurahRemoteDatasource],
  customMocks: [MockSpec<Dio>(as: #MockDioClient)],
)
void main() {}
