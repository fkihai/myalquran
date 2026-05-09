import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/data/datasources/local_datasource.dart';
import 'package:myalquran/data/models/surah_progress_model.dart';
import 'package:myalquran/domain/entities/surah_progress.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

import '../../domain/entities/surah.dart';

class QuranRepositoryImpl implements QuranRepository {
  final LocalDatasource localDatasource;

  QuranRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<Surah>>> getAllSurah() async {
    try {
      final result = await localDatasource.getAllSurah();
      final surahs = result.map((e) => e.toEntity()).toList();
      return right(surahs);
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Surah>> getDetailSurah(int surahNumber) async {
    try {
      final result = await localDatasource.getDetailSurah(
        surahNumber: surahNumber,
      );
      final surah = result.toEntity();
      return right(surah);
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addBookmark(SurahProgress verses) async {
    try {
      final surahModel = SurahProgressModel.fromEntity(verses);
      await localDatasource.addBookmark(surahModel);
      return const Right(unit);
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addLastRead(SurahProgress verses) async {
    try {
      final surahModel = SurahProgressModel.fromEntity(verses);
      await localDatasource.addLastRead(surahModel);
      return right(unit);
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SurahProgress>>> getAllBookmark() async {
    try {
      final result = await localDatasource.getAllBookmark();
      final surahProgresses = result.map((e) => e.toEntity()).toList();
      return right(surahProgresses);
    } catch (e) {
      return left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SurahProgress>> getLastRead() async {
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
}
