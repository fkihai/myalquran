import 'package:bloc/bloc.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/surah.dart';
import 'package:myalquran/domain/entities/surah_progress.dart';
import 'package:myalquran/domain/usecase/get_all_surah.dart';
import 'package:myalquran/domain/usecase/get_last_read.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_event.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_state.dart';

class SurahListBloc extends Bloc<SurahListEvent, SurahListState> {
  final GetAllSurah getAllSurah;
  final GetLastRead getLastRead;

  List<Surah>? allSurah = [];
  SurahProgress? lastRead;

  SurahListBloc(
    this.getAllSurah,
    this.getLastRead,
  ) : super(SurahListInitial()) {
    on<FetchSurahEvent>(_onFetchSurah);
    on<FilterSurahEvent>(_onFilterSurah);
  }

  void _onFetchSurah(
    FetchSurahEvent event,
    Emitter<SurahListState> emit,
  ) async {
    emit(SurahListLoading());
    await Future.delayed(const Duration(seconds: 2));

    final surahListResult = await getAllSurah(NoParams());
    final lastReadResult = await getLastRead(NoParams());

    lastRead = lastReadResult.fold((failure) => null, (result) => result);

    surahListResult.fold(
      (l) => emit(SurahListError(l.message)),
      (r) {
        allSurah = r;
        emit(
          SurahListLoaded(
            allSurah: r,
            lastRead: lastRead,
          ),
        );
      },
    );
  }

  void _onFilterSurah(
    FilterSurahEvent event,
    Emitter<SurahListState> emit,
  ) {
    List<Surah>? result = [];

    if (event.value!.isEmpty) {
      result = allSurah;
      emit(SurahListLoaded(allSurah: result ?? [], lastRead: lastRead));
    } else {
      result = allSurah
          ?.where((element) => element.nameLatin
              .toLowerCase()
              .contains(event.value!.toLowerCase()))
          .toList();
      emit(SurahListLoaded(allSurah: result ?? [], lastRead: lastRead));
    }
  }
}
