import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/bookmark.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class AddBookmark implements UseCase<Unit, Bookmark> {
  final QuranRepository quranRepository;

  AddBookmark({required this.quranRepository});

  @override
  Future<Either<Failure, Unit>> call(Bookmark bookmark) async {
    return await quranRepository.addBookmark(bookmark);
  }
}
