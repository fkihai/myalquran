import 'package:equatable/equatable.dart';

class Verse extends Equatable {
  final int number;
  final int numberInSurah;
  final String textUthmani;
  final String translation;
  final int juz;

  const Verse({
    required this.number,
    required this.numberInSurah,
    required this.textUthmani,
    required this.translation,
    required this.juz,
  });

  @override
  List<Object?> get props => [
        number,
        numberInSurah,
        textUthmani,
        translation,
        juz,
      ];
}
