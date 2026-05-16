import 'package:equatable/equatable.dart';

class LastRead extends Equatable {
  final int surahId;
  final int verseNumber;
  final int juzNumber;
  final String surahName;
  final DateTime updatedAt;

  const LastRead({
    required this.surahId,
    required this.verseNumber,
    required this.juzNumber,
    required this.surahName,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [
        surahId,
        verseNumber,
        juzNumber,
        surahName,
        updatedAt,
      ];
}
