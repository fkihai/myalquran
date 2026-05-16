import '../../domain/entities/surah.dart';

class SurahModel {
  int? id;
  int? number;
  String? nameArabic;
  String? nameLatin;
  String? nameTransliteration;
  int? numberOfAyahs;
  String? revelationType;

  SurahModel({
    this.id,
    this.number,
    this.nameArabic,
    this.nameLatin,
    this.nameTransliteration,
    this.numberOfAyahs,
    this.revelationType,
  });

  SurahModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    nameArabic = json['name_arabic'];
    nameLatin = json['name_latin'];
    nameTransliteration = json['name_transliteration'];
    numberOfAyahs = json['number_of_ayahs'];
    revelationType = json['revelation_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['name_arabic'] = nameArabic;
    data['name_latin'] = nameLatin;
    data['name_transliteration'] = nameTransliteration;
    data['number_of_ayahs'] = numberOfAyahs;
    data['revelation_type'] = revelationType;
    return data;
  }

  Surah toEntity() {
    return Surah(
      id: id ?? 0,
      number: number ?? 0,
      nameArabic: nameArabic ?? "",
      nameLatin: nameLatin ?? "",
      nameTransliteration: nameTransliteration ?? "",
      numberOfAyahs: numberOfAyahs ?? 0,
      revelationType: revelationType ?? "",
    );
  }
}
