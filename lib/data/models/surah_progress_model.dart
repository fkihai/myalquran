class SurahProgressModel {
  final int? id;
  final String? nameOfSurah;
  final int? numberOfVerse;
  final int? indexVersesOfSurah;
  final bool lastRead;

  SurahProgressModel({
    this.id,
    required this.nameOfSurah,
    required this.numberOfVerse,
    required this.indexVersesOfSurah,
    this.lastRead = false,
  });

  factory SurahProgressModel.fromjson(Map<String, dynamic> json) {
    return SurahProgressModel(
      id: json['id'],
      nameOfSurah: json['nameOfSurah'],
      numberOfVerse: json['numberOfVerses'],
      indexVersesOfSurah: json['indexVersesOnSurah'],
      lastRead: json['lastRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameOfSurah': nameOfSurah,
      'numberOfVerses': numberOfVerse,
      'indexVersesOnSurah': indexVersesOfSurah,
      'lastRead': lastRead == true ? 1 : 0,
    };
  }
}
