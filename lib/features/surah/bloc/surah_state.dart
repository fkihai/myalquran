import 'package:equatable/equatable.dart';
import 'package:myalquran/domain/entities/bookmark.dart';
import 'package:myalquran/domain/entities/surah.dart';
import 'package:myalquran/domain/entities/verses.dart';

class SurahState extends Equatable {
  final List<Surah> allSurah;
  final int? currentSurahNumber;
  final int? currentVerseNumber;
  final List<Verse>? verseList;
  final List<Bookmark> bookmarks;
  final bool isLoading;
  final String? errorMessage;

  const SurahState({
    this.allSurah = const [],
    this.currentSurahNumber,
    this.currentVerseNumber,
    this.verseList,
    this.bookmarks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  SurahState copyWith({
    List<Surah>? allSurah,
    List<Verse>? verseList,
    int? currentSurahNumber,
    int? currentVerseNumber,
    List<Bookmark>? bookmarks,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SurahState(
      allSurah: allSurah ?? this.allSurah,
      verseList: verseList ?? this.verseList,
      currentSurahNumber: currentSurahNumber ?? this.currentSurahNumber,
      currentVerseNumber: currentVerseNumber ?? this.currentVerseNumber,
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        allSurah,
        verseList,
        currentSurahNumber,
        currentVerseNumber,
        bookmarks,
        isLoading,
        errorMessage,
      ];
}
