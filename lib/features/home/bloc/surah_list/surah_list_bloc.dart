import 'package:bloc/bloc.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/surah_progress.dart';
import 'package:myalquran/domain/usecase/get_all_surah.dart';
import 'package:myalquran/domain/usecase/get_last_read.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_event.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_state.dart';

class SurahListBloc extends Bloc<SurahListEvent, SurahListState> {
  final GetAllSurah getAllSurah;
  final GetLastRead getLastRead;

  SurahListBloc(this.getAllSurah, this.getLastRead)
      : super(SurahListInitial()) {
    on<FetchSurahEvent>((event, emit) async {
      emit(SurahListLoading());
      await Future.delayed(const Duration(seconds: 2));

      final surahListResult = await getAllSurah(NoParams());
      final lastReadResult = await getLastRead(NoParams());

      final SurahProgress? lastRead =
          lastReadResult.fold((l) => null, (r) => r);

      surahListResult.fold(
        (l) => emit(SurahListError(l.message)),
        (r) => emit(SurahListLoaded(
          allSurah: r,
          lastRead: lastRead,
        )),
      );
    });
  }
}
