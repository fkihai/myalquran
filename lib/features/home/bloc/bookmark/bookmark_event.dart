import 'package:equatable/equatable.dart';

class BookmarkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAllBookmark extends BookmarkEvent {}

class DeleteBookmarkEvent extends BookmarkEvent {
  final int id;
  DeleteBookmarkEvent(this.id);

  @override
  List<Object> get props => [id];
}
