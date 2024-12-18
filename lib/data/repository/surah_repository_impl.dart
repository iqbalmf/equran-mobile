import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_equran/core/error/failures.dart';
import 'package:my_equran/data/datasource/surah_remote_datasource.dart';
import 'package:my_equran/data/mapper/surah_mapper.dart';
import 'package:my_equran/data/model/surah_model.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';
import 'package:my_equran/domain/repository/surah_repository.dart';

class SurahRepositoryImpl extends SurahRepository {
  final SurahRemoteDatasource surahRemoteDatasource;

  SurahRepositoryImpl({required this.surahRemoteDatasource});

  @override
  Future<Either<Exception, List<SurahEntity>>> getAllSurah() async {
    try {
      List<SurahModel> surahModel;
      final result = await surahRemoteDatasource.getAllSurah();
      surahModel = List.from(
          result.data['data'].map((json) => SurahModel.fromJson(json)));
      final response =
          surahModel.map((item) => SurahMapper.toSurahEntity(item)).toList();
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: e.response?.statusMessage ?? '',
        httpStatus: e.response?.statusCode ?? -1,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Exception, SurahEntity>> getDetailSurah(int noSurah) async {
    try {
      final result = await surahRemoteDatasource.getSurah(noSurah);
      SurahModel surahModel = SurahModel.fromJson(result.data['data']);
      final response = SurahMapper.toDetailSurahEntity(surahModel);
      return Right(response);
    } on DioException catch (e) {
      print(e.message);
      return Left(ServerFailure(
        message: e.response?.statusMessage ?? '',
        httpStatus: e.response?.statusCode ?? -1,
      ));
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Exception, SurahEntity>> getTafsirFromSurah(int noSurah) async {
    try {
      final result = await surahRemoteDatasource.getTafsirFromSurah(noSurah);
      final response = SurahMapper.toTafsirSurahEntity(result.data['data']);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: e.response?.statusMessage ?? '',
        httpStatus: e.response?.statusCode ?? -1,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
