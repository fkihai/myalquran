import 'package:equatable/equatable.dart';

class Juz extends Equatable {
  final int id;
  final int juzNumber;
  final int firstAyahId;
  final int lastAyahId;
  final int totalAyahs;

  const Juz({
    required this.id,
    required this.juzNumber,
    required this.firstAyahId,
    required this.lastAyahId,
    required this.totalAyahs,
  });

  @override
  List<Object> get props => [
        id,
        juzNumber,
        firstAyahId,
        lastAyahId,
        totalAyahs,
      ];
}
