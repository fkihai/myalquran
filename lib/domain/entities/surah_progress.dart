import 'package:equatable/equatable.dart';

class SurahProgress extends Equatable {
  final int? id;
  final String surahNameLatin;
  final int surahNumber;
  final int verseIndex;
  final bool lastRead;

  const SurahProgress({
    this.id,
    required this.surahNameLatin,
    required this.surahNumber,
    required this.verseIndex,
    required this.lastRead,
  });

  @override
  List<Object?> get props => [id, surahNameLatin, surahNumber, verseIndex, lastRead];
}
