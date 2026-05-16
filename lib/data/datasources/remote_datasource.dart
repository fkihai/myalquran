import 'package:myalquran/core/network/api_client.dart';
import 'package:myalquran/data/models/juz_model.dart';
import 'package:myalquran/data/models/surah_model.dart';
import 'package:myalquran/data/models/verses_model.dart';

class RemoteDatasource {
  final ApiClient apiClient;
  RemoteDatasource(this.apiClient);

  Future<List<SurahModel>> getSurahList() async {
    final result = await apiClient.get("/surah");
    return (result['data'] as List).map((e) => SurahModel.fromJson(e)).toList();
  }

  Future<List<VerseModel>> getVersesOfSurah(int surahNumber) async {
    final result = await apiClient.get("/surah/$surahNumber/ayah");
    return (result['data']['ayahs'] as List)
        .map((e) => VerseModel.fromJson(e))
        .toList();
  }

  Future<List<Juz>> getJuzList() async {
    final result = await apiClient.get("/Juz");
    return (result['data'] as List).map((e) => Juz.fromJson(e)).toList();
  }
}
