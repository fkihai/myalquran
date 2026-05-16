import 'package:bloc/bloc.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/last_read.dart';
import 'package:myalquran/domain/entities/surah.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';
import 'package:myalquran/domain/usecase/get_surah_list.dart';
import 'package:myalquran/domain/usecase/get_last_read.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_event.dart';
import 'package:myalquran/features/home/bloc/surah_list/surah_list_state.dart';

class SurahListBloc extends Bloc<SurahListEvent, SurahListState> {
  final GetSurahList getListSurah;
  final GetLastRead getLastRead;
  final QuranRepository repository;

  List<Surah>? allSurah = [];
  LastRead? lastRead;

  SurahListBloc(
    this.getListSurah,
    this.getLastRead,
    this.repository,
  ) : super(SurahListInitial()) {
    repository.watchDatabase().listen((_) {
      add(FetchSurahEvent());
    });

    on<FetchSurahEvent>(_onFetchSurah);
    on<FilterSurahEvent>(_onFilterSurah);
  }

  void _onFetchSurah(
    FetchSurahEvent event,
    Emitter<SurahListState> emit,
  ) async {
    emit(SurahListLoading());

    final surahListResult = await getListSurah(NoParams());
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
          ?.where((element) => element.nameTransliteration
              .toLowerCase()
              .contains(event.value!.toLowerCase()))
          .toList();
      emit(SurahListLoaded(allSurah: result ?? [], lastRead: lastRead));
    }
  }
}
