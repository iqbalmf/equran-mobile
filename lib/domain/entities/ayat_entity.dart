import 'package:equatable/equatable.dart';
import 'package:my_equran/domain/entities/audio_entity.dart';

class AyatEntity extends Equatable {
  int nomorAyat;
  String textArab;
  String textLatin;
  String textIndonesia;
  AudioEntity audioEntity;

  AyatEntity({
    required this.nomorAyat,
    required this.textArab,
    required this.textLatin,
    required this.textIndonesia,
    required this.audioEntity,
  });

  @override
  List<Object?> get props =>
      [nomorAyat, textArab, textLatin, textIndonesia, audioEntity];
}
