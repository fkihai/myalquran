class Juz {
  int? id;
  int? juzNumber;
  int? firstAyahId;
  int? lastAyahId;
  int? totalAyahs;

  Juz(
      {this.id,
      this.juzNumber,
      this.firstAyahId,
      this.lastAyahId,
      this.totalAyahs});

  Juz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    juzNumber = json['juz_number'];
    firstAyahId = json['first_ayah_id'];
    lastAyahId = json['last_ayah_id'];
    totalAyahs = json['total_ayahs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['juz_number'] = juzNumber;
    data['first_ayah_id'] = firstAyahId;
    data['last_ayah_id'] = lastAyahId;
    data['total_ayahs'] = totalAyahs;
    return data;
  }
}
