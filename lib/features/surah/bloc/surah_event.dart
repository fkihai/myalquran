abstract class SurahEvent {}

class LoadSurahEvent extends SurahEvent {
  final int surahNumber;
  LoadSurahEvent({required this.surahNumber});
}
