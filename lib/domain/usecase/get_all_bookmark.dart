import 'package:dartz/dartz.dart';
import 'package:myalquran/core/error/failure.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';

class GetAllBookmark implements UseCase {
  final QuranRepository quranRepository;

  GetAllBookmark({required this.quranRepository});

  @override
  Future<Either<Failure, dynamic>> call(params) async {
    return await quranRepository.getAllBookmark();
  }
}
