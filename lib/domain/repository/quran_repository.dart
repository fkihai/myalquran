import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/domain/entities/surah_progress.dart';

import '../entities/surah.dart';

abstract class QuranRepository {
  Future<Either<Failure, List<Surah>>> getAllSurah();
  Future<Either<Failure, Surah>> getDetailSurah(int surahNumber);
  Future<Either<Failure, List<SurahProgress>>> getAllBookmark();
  Future<Either<Failure, SurahProgress>> getLastRead();
  Future<Either<Failure, Unit>> addBookmark(SurahProgress verses);
  Future<Either<Failure, Unit>> addLastRead(SurahProgress verses);
}
