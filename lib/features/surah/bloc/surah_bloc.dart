import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/usecase/get_all_surah.dart';
import 'package:myalquran/domain/usecase/get_detail_surah.dart';
import 'package:myalquran/features/surah/bloc/surah_event.dart';
import 'package:myalquran/features/surah/bloc/surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final GetDetailSurah getDetailSurah;
  final GetAllSurah getAllSurah;

  SurahBloc({
    required this.getDetailSurah,
    required this.getAllSurah,
  }) : super(const SurahState()) {
    on<LoadSurahEvent>(_loadSurah);
  }

  void _loadSurah(LoadSurahEvent event, Emitter<SurahState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    if (state.allSurah.isEmpty) {
      final allSurah = await getAllSurah(NoParams());
      allSurah.fold(
        (l) => emit(state.copyWith(isLoading: false, errorMessage: l.message)),
        (r) => emit(state.copyWith(allSurah: r)),
      );
    }

    if (state.errorMessage != null && state.allSurah.isEmpty) return;

    final surah = await getDetailSurah(SurahNumber(number: event.surahNumber));
    
    surah.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.message)),
      (r) => emit(state.copyWith(isLoading: false, detailSurah: r)),
    );
  }
}
