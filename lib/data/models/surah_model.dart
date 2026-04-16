import '../../domain/entities/surah.dart';
import 'verses_model.dart';

class SurahModel {
  int? nomor;
  String? name;
  String? latinName;
  int? numberOfVerses;
  String? revalationPlace;
  String? meaning;
  String? description;
  String? audio;
  bool? status;
  List<VersesModel>? verses;

  SurahModel({
    this.nomor,
    this.name,
    this.latinName,
    this.numberOfVerses,
    this.revalationPlace,
    this.meaning,
    this.description,
    this.audio,
    this.status,
    this.verses,
  });

  SurahModel.fromJson(Map<String, dynamic> json) {
    nomor = json['nomor'];
    name = json['nama'];
    latinName = json['nama_latin'];
    numberOfVerses = json['jumlah_ayat'];
    revalationPlace = json['tempat_turun'];
    meaning = json['arti'];
    description = json['deskripsi'];
    audio = json['audio'];
    status = json['status'];
    if (json['ayat'] != null) {
      verses = <VersesModel>[];
      json['ayat'].forEach((v) {
        verses!.add(VersesModel.fromJson(v));
      });
    }
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
    data['status'] = status;
    if (verses != null) {
      data['ayat'] = verses!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Surah toEntity() {
    return Surah(
      nomor: nomor ?? 0,
      name: name ?? "",
      latinName: latinName ?? "",
      numberOfVerses: numberOfVerses ?? 0,
      revalationPlace: revalationPlace ?? "",
      meaning: meaning ?? "",
      description: description ?? "",
      verses: verses != null ? verses!.map((e) => e.toEntity()).toList() : [],
    );
  }
}
