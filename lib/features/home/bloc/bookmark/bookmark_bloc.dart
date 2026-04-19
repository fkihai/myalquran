import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myalquran/core/usecase/usecase.dart';
import 'package:myalquran/domain/usecase/get_all_bookmark.dart';
import 'package:myalquran/domain/usecase/get_last_read.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_event.dart';
import 'package:myalquran/features/home/bloc/bookmark/bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final GetAllBookmark getAllBookmark;
  final GetLastRead getLastRead;

  BookmarkBloc(this.getAllBookmark, this.getLastRead)
      : super(BookmarkInitial()) {
    on<LoadAllBookmark>((event, emit) async {
      final allBookMark = await getAllBookmark(NoParams());

      allBookMark.fold(
        (l) => emit(BookmarkError(l.message)),
        (r) => emit(BookmarkLoaded(allBookmark: r)),
      );
    });
  }
}
