import 'package:bloc/bloc.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/repository/quran_repository.dart';
import 'package:myalquran/domain/usecase/delete_bookmark.dart';
import 'package:myalquran/domain/usecase/get_all_bookmark.dart';
import 'package:myalquran/domain/usecase/get_last_read.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_event.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final GetAllBookmark getAllBookmark;
  final GetLastRead getLastRead;
  final DeleteBookmark deleteBookmark;
  final QuranRepository repository;

  BookmarkBloc(this.getAllBookmark, this.getLastRead, this.deleteBookmark, this.repository)
      : super(BookmarkInitial()) {
    repository.watchDatabase().listen((_) {
      add(LoadAllBookmark());
    });

    on<LoadAllBookmark>((event, emit) async {
      emit(BookmarkLoading());
      final allBookMark = await getAllBookmark(NoParams());

      allBookMark.fold(
        (l) => emit(BookmarkError(l.message)),
        (r) => emit(BookmarkLoaded(allBookmark: r)),
      );
    });

    on<DeleteBookmarkEvent>((event, emit) async {
      final result = await deleteBookmark(event.id);

      result.fold(
        (l) => emit(BookmarkError(l.message)),
        (r) => add(LoadAllBookmark()),
      );
    });
  }
}
