import 'package:equatable/equatable.dart';
import 'package:myalquran/domain/entities/bookmark.dart';

class BookmarkState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<Bookmark> allBookmark;
  BookmarkLoaded({required this.allBookmark});

  @override
  List<Object> get props => [allBookmark];
}

class BookmarkError extends BookmarkState {
  final String? message;
  BookmarkError(this.message);
}
