import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/data/datasources/local_datasource.dart';
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
}
