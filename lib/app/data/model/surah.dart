class Surah {
  int? nomor;
  String? name;
  String? latinName;
  int? numberOfVerses;
  String? revalationPlace;
  String? meaning;
  String? description;
  String? audio;

  Surah(
      {this.nomor,
      this.name,
      this.latinName,
      this.numberOfVerses,
      this.revalationPlace,
      this.meaning,
      this.description,
      this.audio});

  Surah.fromJson(Map<String, dynamic> json) {
    nomor = json['nomor'];
    name = json['nama'];
    latinName = json['nama_latin'];
    numberOfVerses = json['jumlah_ayat'];
    revalationPlace = json['tempat_turun'];
    meaning = json['arti'];
    description = json['deskripsi'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nomor'] = nomor;
    data['nama'] = name;
    data['nama_latin'] = latinName;
    data['jumlah_ayat'] = numberOfVerses;
    data['tempat_turun'] = revalationPlace;
    data['arti'] = meaning;
    data['deskripsi'] = description;
    data['audio'] = audio;
    return data;
  }
}
