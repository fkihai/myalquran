import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/verses.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class GetVerseList implements UseCase<List<Verse>, SurahNumber> {
  final QuranRepository quranRepository;

  GetVerseList({required this.quranRepository});

  @override
  Future<Either<Failure, List<Verse>>> call(SurahNumber params) async {
    return await quranRepository.getVersesOfSurah(params.number);
  }
}


class SurahNumber {
  final int number;
  SurahNumber({required this.number});
}
