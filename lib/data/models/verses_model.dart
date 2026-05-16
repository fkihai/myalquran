import 'package:myalquran/domain/entities/verses.dart';

class VerseModel {
  int? number;
  int? numberInSurah;
  String? textUthmani;
  String? translation;
  int? juz;

  VerseModel({
    this.number,
    this.numberInSurah,
    this.textUthmani,
    this.translation,
    this.juz,
  });

  VerseModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    numberInSurah = json['number_in_surah'];
    textUthmani = json['text_uthmani'];
    translation = json['translation'];
    juz = json['juz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['number_in_surah'] = numberInSurah;
    data['text_uthmani'] = textUthmani;
    data['translation'] = translation;
    data['juz'] = juz;
    return data;
  }

  Verse toEntity() {
    return Verse(
      number: number ?? 0,
      numberInSurah: numberInSurah ?? 0,
      textUthmani: textUthmani ?? "",
      translation: translation ?? "",
      juz: juz ?? 0,
    );
  }
}
