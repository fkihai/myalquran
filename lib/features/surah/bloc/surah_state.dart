import 'package:equatable/equatable.dart';
import 'package:myalquran/domain/entities/surah.dart';

import '../../../domain/entities/surah_progress.dart';

class SurahState extends Equatable {
  final List<Surah> allSurah;
  final Surah? detailSurah;
  final List<SurahProgress> bookmarks;
  final bool isLoading;
  final String? errorMessage;

  const SurahState({
    this.allSurah = const [],
    this.detailSurah,
    this.bookmarks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  SurahState copyWith({
    List<Surah>? allSurah,
    Surah? detailSurah,
    List<SurahProgress>? bookmarks,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SurahState(
      allSurah: allSurah ?? this.allSurah,
      detailSurah: detailSurah ?? this.detailSurah,
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [allSurah, detailSurah, bookmarks, isLoading, errorMessage];
}
