import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/surah_progress.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class AddBookmark implements UseCase<Unit, SurahProgress> {
  final QuranRepository quranRepository;

  AddBookmark({required this.quranRepository});

  @override
  Future<Either<Failure, Unit>> call(SurahProgress verses) async {
    return await quranRepository.addBookmark(verses);
  }
}
