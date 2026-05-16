import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/surah.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class GetSurahList implements UseCase<List<Surah>, NoParams> {
  final QuranRepository quranRepository;

  GetSurahList({required this.quranRepository});

  @override
  Future<Either<Failure, List<Surah>>> call(params) async {
    return await quranRepository.getSurahList();
  }
}
