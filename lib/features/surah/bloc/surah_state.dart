import 'package:equatable/equatable.dart';
import 'package:myalquran/domain/entities/surah.dart';

class SurahState extends Equatable {
  final List<Surah> allSurah;
  final Surah? detailSurah;
  final bool isLoading;
  final String? errorMessage;

  const SurahState({
    this.allSurah = const [],
    this.detailSurah,
    this.isLoading = false,
    this.errorMessage,
  });

  SurahState copyWith({
    List<Surah>? allSurah,
    Surah? detailSurah,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SurahState(
      allSurah: allSurah ?? this.allSurah,
      detailSurah: detailSurah ?? this.detailSurah,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [allSurah, detailSurah, isLoading, errorMessage];
}
