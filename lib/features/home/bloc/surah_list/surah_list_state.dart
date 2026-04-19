import 'package:equatable/equatable.dart';
import 'package:myalquran/domain/entities/surah_progress.dart';

import '../../../../domain/entities/surah.dart';

abstract class SurahListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SurahListInitial extends SurahListState {
  SurahListInitial();
}

class SurahListLoading extends SurahListState {
  SurahListLoading();
}

class SurahListLoaded extends SurahListState {
  final List<Surah> allSurah;
  final SurahProgress? lastRead;

  SurahListLoaded({this.lastRead, required this.allSurah});

  @override
  List<Object?> get props => [allSurah, lastRead];
}

class SurahListError extends SurahListState {
  final String message;
  SurahListError(this.message);

  @override
  List<Object> get props => [message];
}
