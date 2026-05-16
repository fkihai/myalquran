import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  final int id;
  final int number;
  final String nameArabic;
  final String nameLatin;
  final String nameTransliteration;
  final int numberOfAyahs;
  final String revelationType;

  const Surah({
    required this.id,
    required this.number,
    required this.nameArabic,
    required this.nameLatin,
    required this.nameTransliteration,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  @override
  List<Object> get props => [
        id,
        number,
        nameArabic,
        nameLatin,
        nameTransliteration,
        numberOfAyahs,
        revelationType,
      ];
}
