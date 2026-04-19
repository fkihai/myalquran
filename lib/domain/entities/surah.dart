import 'package:equatable/equatable.dart';
import 'package:myalquran/domain/entities/verses.dart';

class Surah extends Equatable {
  final int nomor;
  final String name;
  final String nameLatin;
  final int totalVerses;
  final String revalationPlace;
  final String meaning;
  final String description;
  final List<Verses> verses;
  const Surah({
    required this.verses,
    required this.nomor,
    required this.name,
    required this.nameLatin,
    required this.totalVerses,
    required this.revalationPlace,
    required this.meaning,
    required this.description,
  });

  @override
  List<Object> get props => [nomor];
}
