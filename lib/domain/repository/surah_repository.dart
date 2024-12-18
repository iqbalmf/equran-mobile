import 'package:dartz/dartz.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';

abstract class SurahRepository {
  Future<Either<Exception, List<SurahEntity>>> getAllSurah();

  Future<Either<Exception, SurahEntity>> getDetailSurah(int noSurah);

  Future<Either<Exception, SurahEntity>> getTafsirFromSurah(int noSurah);
}
