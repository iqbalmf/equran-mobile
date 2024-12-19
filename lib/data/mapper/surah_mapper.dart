import 'package:my_equran/data/mapper/audio_mapper.dart';
import 'package:my_equran/data/mapper/ayat_mapper.dart';
import 'package:my_equran/data/model/surah_model.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';

class SurahMapper {
  static SurahEntity toSurahEntity(SurahModel surahModel) {
    return SurahEntity(
      id: surahModel.nomor ?? -1,
      nama: surahModel.nama ?? '',
      namaLatin: surahModel.namaLatin ?? '',
      tempatTurun: surahModel.tempatTurun ?? '',
      arti: surahModel.arti ?? '',
      jumlahAyat: surahModel.jumlahAyat ?? 0,
      deskripsi: surahModel.deskripsi ?? '',
    );
  }

  static SurahEntity toDetailSurahEntity(SurahModel surahModel) {
    return SurahEntity(
        id: surahModel.nomor ?? -1,
        nama: surahModel.nama ?? '',
        namaLatin: surahModel.namaLatin ?? '',
        tempatTurun: surahModel.tempatTurun ?? '',
        arti: surahModel.arti ?? '',
        jumlahAyat: surahModel.jumlahAyat ?? 0,
        deskripsi: surahModel.deskripsi ?? '',
        audioFullSurah: surahModel.audioFull != null ? AudioMapper.toAudioEntity(surahModel.audioFull!) : null,
        ayatEntity: List.from((surahModel.ayat ?? [])
            .map((item) => AyatMapper.toAyatEntity(item, item.audio!))
            .toList()));
  }

  static SurahEntity toTafsirSurahEntity(SurahModel surahModel) {
    return SurahEntity(
      id: surahModel.nomor ?? -1,
      nama: surahModel.nama ?? '',
      namaLatin: surahModel.namaLatin ?? '',
      tempatTurun: surahModel.tempatTurun ?? '',
      arti: surahModel.arti ?? '',
      jumlahAyat: surahModel.jumlahAyat ?? 0,
      deskripsi: surahModel.deskripsi ?? '',
      tafsirEntity: List.from((surahModel.tafsir ?? [])
          .map((item) => TafsirMapper.toTafsirEntity(item))
          .toList()),
    );
  }
}
