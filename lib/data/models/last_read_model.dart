import '../../domain/entities/last_read.dart';

class LastReadModel {
  final int? surahId;
  final int? verseNumber;
  final int? juzNumber;
  final String? surahName;
  final String? updatedAt;

  const LastReadModel({
    this.surahId,
    this.verseNumber,
    this.juzNumber,
    this.surahName,
    this.updatedAt,
  });

  factory LastReadModel.fromJson(Map<String, dynamic> json) {
    return LastReadModel(
      surahId: json['surah_id'] as int?,
      verseNumber: json['verse_number'] as int?,
      juzNumber: json['juz_number'] as int?,
      surahName: json['surah_name'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': 1,
      'surah_id': surahId,
      'verse_number': verseNumber,
      'juz_number': juzNumber,
      'surah_name': surahName,
      'updated_at': updatedAt,
    };
  }

  LastRead toEntity() {
    return LastRead(
      surahId: surahId ?? 0,
      verseNumber: verseNumber ?? 0,
      juzNumber: juzNumber ?? 0,
      surahName: surahName ?? '',
      updatedAt: DateTime.tryParse(updatedAt ?? '') ?? DateTime.now(),
    );
  }

  factory LastReadModel.fromEntity(LastRead entity) {
    return LastReadModel(
      surahId: entity.surahId,
      verseNumber: entity.verseNumber,
      juzNumber: entity.juzNumber,
      surahName: entity.surahName,
      updatedAt: entity.updatedAt.toIso8601String(),
    );
  }
}
