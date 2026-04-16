import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myalquran/features/surah/bloc/surah_event.dart';
import 'package:myalquran/features/surah/bloc/surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  SurahBloc() : super(SurahInitial()) {
    on<LoadData>((event, emit) => null);
  }
}
