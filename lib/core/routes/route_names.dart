class Routes {
  static const home = '/';
  static const surah = '/surah/:nomor';

  // helper
  static String toDetailSurah(int nomor) => '/surah/$nomor';
}
