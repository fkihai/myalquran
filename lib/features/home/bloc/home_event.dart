import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class FetchSurahEvent extends HomeEvent {
  FetchSurahEvent();

  @override
  List<Object> get props => [];
}
