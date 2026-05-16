import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/last_read.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class GetLastRead implements UseCase {
  final QuranRepository quranRepository;

  GetLastRead({required this.quranRepository});
  @override
  Future<Either<Failure, LastRead>> call(params) {
    return quranRepository.getLastRead();
  }
}
