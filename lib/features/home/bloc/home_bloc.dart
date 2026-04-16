import 'package:bloc/bloc.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/usecase/get_all_surah.dart';
import 'package:myalquran/features/home/bloc/home_event.dart';
import 'package:myalquran/features/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllSurah getAllSurah;

  HomeBloc(this.getAllSurah) : super(HomeInitial()) {
    on<FetchSurahEvent>((event, emit) async {
      emit(QuranLoading());
      await Future.delayed(const Duration(seconds: 2));

      final result = await getAllSurah(NoParams());
      result.fold(
        (failure) => emit(QuranError(failure.message)),
        (surahs) => emit(QuranLoaded(allSurah: surahs)),
      );
    });
  }
}
