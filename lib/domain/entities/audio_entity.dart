import 'package:equatable/equatable.dart';

class AudioEntity extends Equatable {
  String? abdullah_al_juhany;
  String? abdul_muhsin_al_qasim;
  String? abdurrahman_as_sudais;
  String? ibrahim_al_dossari;
  String? misyari_rasyid_al_afasi;

  AudioEntity({
    this.abdullah_al_juhany,
    this.abdul_muhsin_al_qasim,
    this.abdurrahman_as_sudais,
    this.ibrahim_al_dossari,
    this.misyari_rasyid_al_afasi,
  });

  @override
  List<Object?> get props => [
        abdullah_al_juhany,
        abdul_muhsin_al_qasim,
        abdurrahman_as_sudais,
        ibrahim_al_dossari,
        misyari_rasyid_al_afasi,
      ];
}
