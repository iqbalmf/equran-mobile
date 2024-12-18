import 'package:dartz/dartz.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';
import 'package:my_equran/domain/repository/surah_repository.dart';

class GetDetailSurahUsecase {
  final SurahRepository surahRepository;

  GetDetailSurahUsecase(this.surahRepository);

  Future<Either<Exception, SurahEntity>> execute(int noSurah) async {
    return await surahRepository.getDetailSurah(noSurah);
  }
}
