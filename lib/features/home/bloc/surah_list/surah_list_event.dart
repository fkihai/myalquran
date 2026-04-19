import 'package:equatable/equatable.dart';

abstract class SurahListEvent extends Equatable {}

class FetchSurahEvent extends SurahListEvent {
  FetchSurahEvent();

  @override
  List<Object> get props => [];
}
