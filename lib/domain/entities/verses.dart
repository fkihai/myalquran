import 'package:equatable/equatable.dart';

class Verses extends Equatable {
  final int id;
  final int surah;
  final int nomor;
  final String ar;
  final String tr;
  final String idn;

  const Verses({
    required this.id,
    required this.surah,
    required this.nomor,
    required this.ar,
    required this.tr,
    required this.idn,
  });

  @override
  List<Object> get props => [id];
}
