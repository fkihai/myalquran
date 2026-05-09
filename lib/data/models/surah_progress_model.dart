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
      surahNameLatin: json['surah_name_latin'],
      surahNumber: json['surah_number'],
      verseIndex: json['verse_index'],
      lastRead: json['last_read'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surah_name_latin': surahNameLatin,
      'surah_number': surahNumber,
      'verse_index': verseIndex,
      'last_read': lastRead ? 1 : 0,
    };
  }

  SurahProgress toEntity() {
    return SurahProgress(
      id: id,
      surahNameLatin: surahNameLatin ?? "",
      surahNumber: surahNumber ?? 0,
      verseIndex: verseIndex ?? 0,
      lastRead: lastRead,
    );
  }

  factory SurahProgressModel.fromEntity(SurahProgress entity) {
    return SurahProgressModel(
      id: entity.id,
      surahNameLatin: entity.surahNameLatin,
      surahNumber: entity.surahNumber,
      verseIndex: entity.verseIndex,
      lastRead: entity.lastRead,
    );
  }
}
