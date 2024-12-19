class SurahModel {
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  Audio? audioFull;
  List<Ayat>? ayat;
  List<Tafsir>? tafsir;

  SurahModel({
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audioFull,
    this.ayat,
    this.tafsir,
  });

  SurahModel.fromJson(Map<String, dynamic> json) {
    nomor = json['nomor'];
    nama = json['nama'];
    namaLatin = json['namaLatin'];
    jumlahAyat = json['jumlahAyat'];
    tempatTurun = json['tempatTurun'];
    arti = json['arti'];
    deskripsi = json['deskripsi'];
    audioFull = json['audioFull'] != null
        ? new Audio.fromJson(json['audioFull'])
        : null;
    ayat = json['ayat'] != null
        ? List<Ayat>.from(json['ayat'].map((g) => Ayat.fromJson(g)))
        : null;
    tafsir = json['tafsir'] != null
        ? List<Tafsir>.from(json['tafsir'].map((t) => Tafsir.fromJson(t)))
        : null;
  }
}

class Audio {
  String? audio01;
  String? audio02;
  String? audio03;
  String? audio04;
  String? audio05;

  Audio({this.audio01, this.audio02, this.audio03, this.audio04, this.audio05});

  Audio.fromJson(Map<String, dynamic> json) {
    audio01 = json['01'];
    audio02 = json['02'];
    audio03 = json['03'];
    audio04 = json['04'];
    audio05 = json['05'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['01'] = audio01;
    data['02'] = audio02;
    data['03'] = audio03;
    data['04'] = audio04;
    data['05'] = audio05;
    return data;
  }
}

class Ayat {
  int? nomorAyat;
  String? teksArab;
  String? teksLatin;
  String? teksIndonesia;
  Audio? audio;

  Ayat(
      {this.nomorAyat,
      this.teksArab,
      this.teksLatin,
      this.teksIndonesia,
      this.audio});

  Ayat.fromJson(Map<String, dynamic> json) {
    nomorAyat = json['nomorAyat'];
    teksArab = json['teksArab'];
    teksLatin = json['teksLatin'];
    teksIndonesia = json['teksIndonesia'];
    audio = json['audio'] != null ? Audio.fromJson(json['audio']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomorAyat'] = this.nomorAyat;
    data['teksArab'] = this.teksArab;
    data['teksLatin'] = this.teksLatin;
    data['teksIndonesia'] = this.teksIndonesia;
    if (this.audio != null) {
      data['audio'] = this.audio!.toJson();
    }
    return data;
  }
}

class Tafsir {
  int? ayat;
  String? teks;

  Tafsir({
    this.ayat,
    this.teks,
  });

  Tafsir.fromJson(Map<String, dynamic> json) {
    ayat = json['ayat'];
    teks = json['teks'];
  }
}
