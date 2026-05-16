class Routes {
  static const home = '/';
  static const surah = '/surah/:surahNomor';

  // helper
  static String toDetailSurah(int surahNomor, [int? verseNumber]) {
    if (verseNumber != null) {
      return '/surah/$surahNomor?verseNumber=$verseNumber';
    }
    return '/surah/$surahNomor';
  }
}
