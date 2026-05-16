abstract class SurahEvent {}

class LoadSurahEvent extends SurahEvent {
  final int surahNumber;
  final int? verseNumber;
  LoadSurahEvent({this.verseNumber, required this.surahNumber});
}

class AddBookmarkEvent extends SurahEvent {
  final int surahId;
  final int verseNumber;
  final int juzNumber;
  final String surahName;
  AddBookmarkEvent({
    required this.surahId,
    required this.verseNumber,
    required this.juzNumber,
    required this.surahName,
  });
}

class AddLastReadEvent extends SurahEvent {
  final int surahId;
  final int verseNumber;
  final int juzNumber;
  final String surahName;
  AddLastReadEvent({
    required this.surahId,
    required this.verseNumber,
    required this.juzNumber,
    required this.surahName,
  });
}

class ClearVerseNumberEvent extends SurahEvent {}
