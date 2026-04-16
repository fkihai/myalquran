class Routes {
  static const home = '/';
  static const surah = '/surah/:index';

  // helper
  static String toDetailSurah(String id) => '/surah/$id';
}
