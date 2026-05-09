class Routes {
  static const home = '/';
  static const surah = '/surah/:nomor';

  // helper
  static String toDetailSurah(int nomor, {int? verseIndex}) {
    if (verseIndex != null) {
      return '/surah/$nomor?verseIndex=$verseIndex';
    }
    return '/surah/$nomor';
  }
}
