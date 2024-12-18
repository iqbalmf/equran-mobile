import 'package:my_equran/data/model/surah_model.dart';
import 'package:my_equran/domain/entities/audio_entity.dart';

class AudioMapper {
  static AudioEntity toAudioEntity(Audio audioModel) {
    return AudioEntity(
      abdullah_al_juhany: audioModel.audio01,
      abdul_muhsin_al_qasim: audioModel.audio02,
      abdurrahman_as_sudais: audioModel.audio03,
      ibrahim_al_dossari: audioModel.audio04,
      misyari_rasyid_al_afasi: audioModel.audio05,
    );
  }
}
