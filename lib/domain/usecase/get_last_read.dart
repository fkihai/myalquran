import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/surah_progress.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class GetLastRead implements UseCase {
  final QuranRepository quranRepository;

  GetLastRead({required this.quranRepository});
  @override
  Future<Either<Failure, SurahProgress>> call(params) {
    return quranRepository.getLastRead();
  }
}
