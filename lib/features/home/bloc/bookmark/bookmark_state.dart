import 'package:equatable/equatable.dart';
import 'package:myalquran/domain/entities/surah_progress.dart';

class BookmarkState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<SurahProgress> allBookmark;
  BookmarkLoaded({required this.allBookmark});

  @override
  List<Object> get props => [allBookmark];
}

class BookmarkError extends BookmarkState {
  final String? message;
  BookmarkError(this.message);
}
