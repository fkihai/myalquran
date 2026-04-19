import 'package:myalquran/domain/entities/surah_progress.dart';

class SurahProgressModel {
  final int? id;
  final String? surahNameLatin;
  final int? surahNumber;
  final int? verseIndex;
  final bool lastRead;

  SurahProgressModel({
    this.id,
    required this.surahNameLatin,
    required this.surahNumber,
    required this.verseIndex,
    this.lastRead = false,
  });

  factory SurahProgressModel.fromjson(Map<String, dynamic> json) {
    return SurahProgressModel(
      id: json['id'],
      surahNameLatin: json['surah_name'],
      surahNumber: json['surah_name_latih'],
      verseIndex: json['verse_index'],
      lastRead: json['lastRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surah_name_latin': surahNameLatin,
      'surah_number': surahNumber,
      'verse_index': verseIndex,
      'lastRead': lastRead == true ? 1 : 0,
    };
  }

  SurahProgress toEntity() {
    return SurahProgress(
      id: id ?? 0,
      surahNameLatin: surahNameLatin ?? "",
      surahNumber: surahNumber ?? 0,
      verseIndex: verseIndex ?? 0,
      lastRead: lastRead,
    );
  }

  factory SurahProgressModel.fromEntity(SurahProgress entity) {
    return SurahProgressModel(
      surahNameLatin: entity.surahNameLatin,
      surahNumber: entity.surahNumber,
      verseIndex: entity.verseIndex,
      lastRead: entity.lastRead,
    );
  }
}
