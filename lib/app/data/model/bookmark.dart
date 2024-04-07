class Bookmark {
  int? id;
  String? nameOfSurah;
  int? numberOfVerses;
  int? indexVersesOnSurah;
  bool? lastRead;

  Bookmark({
    this.id,
    this.nameOfSurah,
    this.numberOfVerses,
    this.indexVersesOnSurah,
  });

  Bookmark.toModel(Map<String, dynamic> data) {
    id = data['id'];
    nameOfSurah = data['nameOfSurah'];
    numberOfVerses = data['numberOfVerses'];
    indexVersesOnSurah = data['indexVersesOnSurah'];
    lastRead = data['lastRead'] == 1 ? true : false;
  }
}
