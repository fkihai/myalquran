import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/last_read.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class AddLastRead implements UseCase<Unit, LastRead> {
  final QuranRepository quranRepository;

  AddLastRead({required this.quranRepository});

  @override
  Future<Either<Failure, Unit>> call(LastRead lastRead) async {
    return await quranRepository.addLastRead(lastRead);
  }
}
