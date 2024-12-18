import 'package:my_equran/core/app_config.dart';
import 'package:my_equran/utils/api_helper.dart';

import '../model/response_server.dart';

abstract class SurahRemoteDatasource {
  Future<ResponseServer> getAllSurah();

  Future<ResponseServer> getSurah(int noSurah);

  Future<ResponseServer> getTafsirFromSurah(int noSurah);
}

class SurahRemoteDataSourceImpl extends SurahRemoteDatasource {
  final ApiHelper apiHelper;

  SurahRemoteDataSourceImpl(this.apiHelper);

  @override
  Future<ResponseServer> getAllSurah() async {
    var result = await apiHelper.request('GET', ConstantsApp.getSurah,
        contentType: ConstantsApp.contentType);
    return result;
  }

  @override
  Future<ResponseServer> getSurah(int noSurah) async {
    var result = await apiHelper.request(
        'GET', ConstantsApp.getSurah + noSurah.toString(),
        contentType: ConstantsApp.contentType);
    return result;
  }

  @override
  Future<ResponseServer> getTafsirFromSurah(int noSurah) async {
    var result = await apiHelper.request(
        'GET', ConstantsApp.getTafsir + noSurah.toString(),
        contentType: ConstantsApp.contentType);
    return result;
  }
}
