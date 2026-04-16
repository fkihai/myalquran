import 'package:myalquran/domain/entities/verses.dart';

class VersesModel {
  int? id;
  int? surah;
  int? nomor;
  String? ar;
  String? tr;
  String? idn;

  VersesModel({this.id, this.surah, this.nomor, this.ar, this.tr, this.idn});

  VersesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surah = json['surah'];
    nomor = json['nomor'];
    ar = json['ar'];
    tr = json['tr'];
    idn = json['idn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['surah'] = surah;
    data['nomor'] = nomor;
    data['ar'] = ar;
    data['tr'] = tr;
    data['idn'] = idn;
    return data;
  }

  Verses toEntity() {
    return Verses(
      id: id ?? 0,
      surah: surah ?? 0,
      nomor: nomor ?? 0,
      ar: ar ?? "",
      tr: tr ?? "",
      idn: idn ?? "",
    );
  }
}
