import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/bookmark.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class GetAllBookmark implements UseCase<List<Bookmark>, NoParams> {
  final QuranRepository quranRepository;

  GetAllBookmark({required this.quranRepository});

  @override
  Future<Either<Failure, List<Bookmark>>> call(NoParams params) async {
    return await quranRepository.getAllBookmark();
  }
}
