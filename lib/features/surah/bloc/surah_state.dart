import 'package:equatable/equatable.dart';

abstract class SurahState extends Equatable {}

class SurahInitial extends SurahState {
  SurahInitial();

  @override
  List<Object> get props => [];
}
