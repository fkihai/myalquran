import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';

import '../entities/surah.dart';

abstract class QuranRepository {
  Future<Either<Failure, List<Surah>>> getAllSurah();
  Future<Either<Failure, Surah>> getDetailSurah(int surahNumber);
}
