import 'package:equatable/equatable.dart';

abstract class SurahListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchSurahEvent extends SurahListEvent {}

class FilterSurahEvent extends SurahListEvent {
  final String? value;
  FilterSurahEvent(this.value);

  @override
  List<Object?> get props => [value];
}
