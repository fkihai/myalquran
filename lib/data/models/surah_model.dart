import '../../domain/entities/surah.dart';
import 'verses_model.dart';

class SurahModel {
  int? nomor;
  String? name;
  String? nameLatin;
  int? totalVerses;
  String? revalationPlace;
  String? meaning;
  String? description;
  String? audio;
  bool? status;
  List<VersesModel>? verses;

  SurahModel({
    this.nomor,
    this.name,
    this.nameLatin,
    this.totalVerses,
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
    nameLatin = json['nama_latin'];
    totalVerses = json['jumlah_ayat'];
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
    data['nama_latin'] = nameLatin;
    data['jumlah_ayat'] = totalVerses;
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
      nameLatin: nameLatin ?? "",
      totalVerses: totalVerses ?? 0,
      revalationPlace: revalationPlace ?? "",
      meaning: meaning ?? "",
      description: description ?? "",
      verses: verses != null ? verses!.map((e) => e.toEntity()).toList() : [],
    );
  }
}
