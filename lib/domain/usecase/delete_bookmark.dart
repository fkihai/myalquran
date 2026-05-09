import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class DeleteBookmark implements UseCase<Unit, int> {
  final QuranRepository quranRepository;

  DeleteBookmark({required this.quranRepository});

  @override
  Future<Either<Failure, Unit>> call(int id) async {
    return await quranRepository.deleteBookmark(id);
  }
}
