import 'package:equatable/equatable.dart';
import 'package:myalquran/domain/entities/surah.dart';

abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  HomeInitial();
  @override
  List<Object> get props => [];
}

class QuranLoading extends HomeState {
  QuranLoading();
  @override
  List<Object> get props => [];
}

class QuranLoaded extends HomeState {
  final List<Surah> allSurah;

  QuranLoaded({required this.allSurah});
  @override
  List<Object> get props => [allSurah];
}

class QuranError extends HomeState {
  final String message;
  QuranError(this.message);

  @override
  List<Object> get props => [];
}
