import 'package:dartz/dartz.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';
import 'package:my_equran/domain/repository/surah_repository.dart';

class GetSurahUsecase {
  final SurahRepository surahRepository;

  GetSurahUsecase(this.surahRepository);

  Future<Either<Exception, List<SurahEntity>>> execute() async {
    return await surahRepository.getAllSurah();
  }
}
