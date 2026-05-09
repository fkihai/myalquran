import 'package:myalquran/domain/entities/surah_progress.dart';

abstract class SurahEvent {}

class LoadSurahEvent extends SurahEvent {
  final int surahNumber;
  LoadSurahEvent({required this.surahNumber});
}

class AddBookmarkEvent extends SurahEvent {
  final SurahProgress surahProgress;
  AddBookmarkEvent({required this.surahProgress});
}

class AddLastReadEvent extends SurahEvent {
  final SurahProgress surahProgress;
  AddLastReadEvent({required this.surahProgress});
}
