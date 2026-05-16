import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/data/models/juz_model.dart';
import 'package:myalquran/domain/entities/bookmark.dart';
import 'package:myalquran/domain/entities/last_read.dart';
import 'package:myalquran/domain/entities/verses.dart';

import '../entities/surah.dart';

abstract class QuranRepository {
  Future<Either<Failure, List<Surah>>> getSurahList();
  Future<Either<Failure, List<Verse>>> getVersesOfSurah(int surahNumber);
  Future<Either<Failure, List<Juz>>> getJuzList(int surahNumber);

  Future<Either<Failure, Unit>> addBookmark(Bookmark bookmark);
  Future<Either<Failure, List<Bookmark>>> getAllBookmark();
  Future<Either<Failure, Unit>> deleteBookmark(int id);

  Future<Either<Failure, Unit>> addLastRead(LastRead lastRead);
  Future<Either<Failure, LastRead>> getLastRead();

  Stream<void> watchDatabase();
}
