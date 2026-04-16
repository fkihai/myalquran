import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/surah.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class GetDetailSurah implements UseCase<Surah, SurahNumber> {
  final QuranRepository quranRepository;

  GetDetailSurah({required this.quranRepository});

  @override
  Future<Either<Failure, Surah>> call(SurahNumber params) async {
    return await quranRepository.getDetailSurah(params.number);
  }
}

class SurahNumber {
  final int number;
  SurahNumber({required this.number});
}
