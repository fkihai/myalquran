import '../../domain/entities/bookmark.dart';

class BookmarkModel {
  final int? id;
  final int? surahId;
  final int? verseNumber;
  final int? juzNumber;
  final String? surahName;
  final String? createdAt;

  const BookmarkModel({
    this.id,
    this.surahId,
    this.verseNumber,
    this.juzNumber,
    this.surahName,
    this.createdAt,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'] as int?,
      surahId: json['surah_id'] as int?,
      verseNumber: json['verse_number'] as int?,
      juzNumber: json['juz_number'] as int?,
      surahName: json['surah_name'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'surah_id': surahId,
      'verse_number': verseNumber,
      'juz_number': juzNumber,
      'surah_name': surahName,
      'created_at': createdAt,
    };
    if (id != null && id != 0) {
      map['id'] = id;
    }
    return map;
  }

  Bookmark toEntity() {
    return Bookmark(
      id: id,
      surahId: surahId ?? 0,
      verseNumber: verseNumber ?? 0,
      juzNumber: juzNumber ?? 0,
      surahName: surahName ?? '',
      createdAt: DateTime.tryParse(createdAt ?? '') ?? DateTime.now(),
    );
  }

  factory BookmarkModel.fromEntity(Bookmark entity) {
    return BookmarkModel(
      id: entity.id,
      surahId: entity.surahId,
      verseNumber: entity.verseNumber,
      juzNumber: entity.juzNumber,
      surahName: entity.surahName,
      createdAt: entity.createdAt?.toIso8601String(),
    );
  }
}
