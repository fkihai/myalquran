import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/entities/bookmark.dart';
import 'package:myalquran/domain/entities/last_read.dart';
import 'package:myalquran/domain/usecase/add_bookmark.dart';
import 'package:myalquran/domain/usecase/add_lastread.dart';
import 'package:myalquran/domain/usecase/get_all_bookmark.dart';
import 'package:myalquran/domain/usecase/get_surah_list.dart';
import 'package:myalquran/domain/usecase/get_verse_list.dart';
import 'package:myalquran/features/surah/bloc/surah_event.dart';
import 'package:myalquran/features/surah/bloc/surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final GetVerseList getDetailSurah;
  final GetSurahList getAllSurah;
  final AddBookmark addBookmark;
  final AddLastRead addLastRead;
  final GetAllBookmark getAllBookmark;

  SurahBloc({
    required this.getDetailSurah,
    required this.getAllSurah,
    required this.addBookmark,
    required this.addLastRead,
    required this.getAllBookmark,
  }) : super(const SurahState()) {
    on<LoadSurahEvent>(_loadSurah);
    on<AddBookmarkEvent>(_onAddBookmark);
    on<AddLastReadEvent>(_onAddLastRead);
    on<ClearVerseNumberEvent>((event, emit) => emit(state.copyWith(currentVerseNumber: null)));
  }

  void _onAddBookmark(AddBookmarkEvent event, Emitter<SurahState> emit) async {
    final bookmark = Bookmark(
      surahId: event.surahId,
      verseNumber: event.verseNumber,
      juzNumber: event.juzNumber,
      surahName: event.surahName,
      createdAt: DateTime.now(),
    );

    final result = await addBookmark(bookmark);
    await result.fold(
      (l) async => emit(state.copyWith(errorMessage: l.message)),
      (r) async {
        final bookmarks = await getAllBookmark(NoParams());
        bookmarks.fold(
          (l) => emit(state.copyWith(errorMessage: l.message)),
          (r) => emit(state.copyWith(bookmarks: r)),
        );
      },
    );
  }

  void _onAddLastRead(AddLastReadEvent event, Emitter<SurahState> emit) async {
    final lastRead = LastRead(
      surahId: event.surahId,
      verseNumber: event.verseNumber,
      juzNumber: event.juzNumber,
      surahName: event.surahName,
      updatedAt: DateTime.now(),
    );

    final result = await addLastRead(lastRead);
    await result.fold(
      (l) async => emit(state.copyWith(errorMessage: l.message)),
      (r) async {
        // Refresh bookmarks to keep state consistent
        final bookmarks = await getAllBookmark(NoParams());
        bookmarks.fold(
          (l) => emit(state.copyWith(errorMessage: l.message)),
          (r) => emit(state.copyWith(bookmarks: r)),
        );
      },
    );
  }

  void _loadSurah(LoadSurahEvent event, Emitter<SurahState> emit) async {
    emit(
      state.copyWith(
        currentSurahNumber: event.surahNumber,
        currentVerseNumber: event.verseNumber,
        isLoading: true,
        errorMessage: null,
      ),
    );

    // 1. Fetch Tab List if empty
    if (state.allSurah.isEmpty) {
      final allSurah = await getAllSurah(NoParams());
      allSurah.fold(
        (l) => emit(state.copyWith(isLoading: false, errorMessage: l.message)),
        (r) => emit(state.copyWith(allSurah: r)),
      );
    }

    if (state.errorMessage != null && state.allSurah.isEmpty) return;

    // 2. Fetch Bookmarks
    final bookmarkResult = await getAllBookmark(NoParams());
    bookmarkResult.fold(
      (l) => null, // Silently ignore or handle
      (r) => emit(state.copyWith(bookmarks: r)),
    );

    // 3. Fetch Detail Surah
    final surah = await getDetailSurah(SurahNumber(number: event.surahNumber));

    surah.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.message)),
      (r) => emit(state.copyWith(isLoading: false, verseList: r)),
    );
  }
}
