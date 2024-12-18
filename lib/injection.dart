import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_equran/core/app_config.dart';
import 'package:my_equran/data/datasource/surah_remote_datasource.dart';
import 'package:my_equran/data/repository/surah_repository_impl.dart';
import 'package:my_equran/domain/repository/surah_repository.dart';
import 'package:my_equran/domain/usecase/get_detail_surah_usecase.dart';
import 'package:my_equran/domain/usecase/get_surah_usecase.dart';
import 'package:my_equran/domain/usecase/get_tafsir_surah_usecase.dart';
import 'package:my_equran/presentation/detailsurahpage/bloc/detailsurah_bloc.dart';
import 'package:my_equran/presentation/surahpage/bloc/listsurahbloc.dart';
import 'package:my_equran/utils/api_helper.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton(
      () => ApiHelper(Dio(BaseOptions(baseUrl: ConstantsApp.baseUrl))));

  locator.registerLazySingleton<SurahRemoteDatasource>(
      () => SurahRemoteDataSourceImpl(locator()));

  locator.registerLazySingleton<SurahRepository>(
      () => SurahRepositoryImpl(surahRemoteDatasource: locator()));

  locator.registerLazySingleton(() => GetSurahUsecase(locator()));
  locator.registerLazySingleton(() => GetDetailSurahUsecase(locator()));
  locator.registerLazySingleton(() => GetTafsirSurahUsecase(locator()));

  locator.registerFactory(() => SurahBloc(locator()));
  locator.registerFactory(() => DetailsurahBloc(locator()));
}
