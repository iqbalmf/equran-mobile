import 'package:my_equran/data/mapper/audio_mapper.dart';
import 'package:my_equran/data/model/surah_model.dart';
import 'package:my_equran/domain/entities/ayat_entity.dart';
import 'package:my_equran/domain/entities/tafsir_entity.dart';

class AyatMapper {
  static AyatEntity toAyatEntity(Ayat ayatModel, Audio audioModel) {
    return AyatEntity(
        nomorAyat: ayatModel.nomorAyat ?? -1,
        textArab: ayatModel.teksArab ?? '',
        textLatin: ayatModel.teksLatin ?? '',
        textIndonesia: ayatModel.teksIndonesia ?? '',
        audioEntity: AudioMapper.toAudioEntity(audioModel));
  }
}

class TafsirMapper {
  static TafsirEntity toTafsirEntity(Tafsir tafsirModel) {
    return TafsirEntity(
      ayat: tafsirModel.ayat ?? -1,
      text: tafsirModel.teks ?? '',
    );
  }
}
