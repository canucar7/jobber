class LanguageIndex {
  String? languageName;
  String? languageLevel;
  int? id;
  int? userId;
  int? language;
  int? level;
  String? createdAt;
  String? updatedAt;

  LanguageIndex(
      {required this.languageName,
        required this.languageLevel,
        required this.id,
        required this.userId,
        required this.language,
        required this.level,
        required this.createdAt,
        required this.updatedAt});

  LanguageIndex.fromJson(Map<String, dynamic> json) {
    languageName = json['languageName'];
    languageLevel = json['languageLevel'];
    id = json['id'];
    userId = json['user_id'];
    language = json['language'];
    level = json['level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['languageName'] = this.languageName;
    data['languageLevel'] = this.languageLevel;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['language'] = this.language;
    data['level'] = this.level;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}