import 'package:equatable/equatable.dart';
import 'package:my_equran/domain/entities/audio_entity.dart';
import 'package:my_equran/domain/entities/ayat_entity.dart';
import 'package:my_equran/domain/entities/tafsir_entity.dart';

class SurahEntity extends Equatable {
  int id;
  String nama;
  String namaLatin;
  String tempatTurun;
  String arti;
  int jumlahAyat;
  String deskripsi;
  AudioEntity? audioFullSurah;
  List<AyatEntity>? ayatEntity;
  List<TafsirEntity>? tafsirEntity;

  SurahEntity({
    required this.id,
    required this.nama,
    required this.namaLatin,
    required this.tempatTurun,
    required this.arti,
    required this.jumlahAyat,
    required this.deskripsi,
    this.audioFullSurah,
    this.ayatEntity,
    this.tafsirEntity,
  });

  @override
  List<Object?> get props => [
        id,
        nama,
        namaLatin,
        tempatTurun,
        arti,
        jumlahAyat,
        deskripsi,
        audioFullSurah,
        ayatEntity,
        tafsirEntity,
      ];
}
