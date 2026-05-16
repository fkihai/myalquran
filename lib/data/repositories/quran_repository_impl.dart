import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/network/api_exception.dart';
import 'package:myalquran/data/datasources/local_datasource.dart';
import 'package:myalquran/data/datasources/remote_datasource.dart';
import 'package:myalquran/data/models/bookmark_model.dart';
import 'package:myalquran/data/models/juz_model.dart';
import 'package:myalquran/data/models/last_read_model.dart';
import 'package:myalquran/data/models/verses_model.dart';
import 'package:myalquran/domain/entities/bookmark.dart';
import 'package:myalquran/domain/entities/last_read.dart';
import 'package:myalquran/domain/entities/verses.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

import '../../domain/entities/surah.dart';

class QuranRepositoryImpl implements QuranRepository {
  final LocalDatasource localDatasource;
  final RemoteDatasource remoteDatasource;

  QuranRepositoryImpl(this.localDatasource, this.remoteDatasource);

  @override
  Future<Either<Failure, List<Surah>>> getSurahList() async {
    try {
      final result = await remoteDatasource.getSurahList();
      final surahs = result.map((e) => e.toEntity()).toList();
      return right(surahs);
    } on ApiException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Verse>>> getVersesOfSurah(int surahNumber) async {
    try {
      final List<VerseModel> result =
          await remoteDatasource.getVersesOfSurah(surahNumber);
      final verseList = result.map((e) => e.toEntity()).toList();
      return right(verseList);
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addBookmark(Bookmark bookmark) async {
    try {
      final bookmarkModel = BookmarkModel.fromEntity(bookmark);
      await localDatasource.addBookmark(bookmarkModel);
      return const Right(unit);
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addLastRead(LastRead lastRead) async {
    try {
      final lastReadModel = LastReadModel.fromEntity(lastRead);
      await localDatasource.addLastRead(lastReadModel);
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Bookmark>>> getAllBookmark() async {
    try {
      final result = await localDatasource.getAllBookmark();
      final bookmark = result.map((e) => e.toEntity()).toList();
      return right(bookmark);
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LastRead>> getLastRead() async {
    try {
      final result = await localDatasource.getLastRead();
      if (result == null) {
        return left(const DatabaseFailure('No last read data'));
      }
      return right(result.toEntity());
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBookmark(int id) async {
    try {
      await localDatasource.deleteBookmark(id);
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<void> watchDatabase() {
    return localDatasource.databaseStream;
  }

  @override
  Future<Either<Failure, List<Juz>>> getJuzList(int surahNumber) async {
    try {
      return right([] as List<Juz>);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
