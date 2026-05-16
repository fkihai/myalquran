import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final int? id;
  final int surahId;
  final int verseNumber;
  final int juzNumber;
  final String surahName;
  final DateTime? createdAt;

  const Bookmark({
    this.id,
    required this.surahId,
    required this.verseNumber,
    required this.juzNumber,
    required this.surahName,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        surahId,
        verseNumber,
        juzNumber,
        surahName,
        createdAt,
      ];
}
