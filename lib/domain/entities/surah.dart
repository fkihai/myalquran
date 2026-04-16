import 'package:equatable/equatable.dart';
import 'package:myalquran/domain/entities/verses.dart';

class Surah extends Equatable {
  final int nomor;
  final String name;
  final String latinName;
  final int numberOfVerses;
  final String revalationPlace;
  final String meaning;
  final String description;
  final List<Verses> verses;
  const Surah({
    required this.verses,
    required this.nomor,
    required this.name,
    required this.latinName,
    required this.numberOfVerses,
    required this.revalationPlace,
    required this.meaning,
    required this.description,
  });

  @override
  List<Object> get props => [nomor];
}
