class UserForeignLanguage {
  int id;
  int userId;
  int? language;
  int? level;
  String languageName;
  String languageLevel;
  String createdAt;
  String updatedAt;

  UserForeignLanguage({
    required this.id,
    required this.userId,
    required this.language,
    required this.level,
    required this.languageName,
    required this.languageLevel,
    required this.createdAt,
    required this.updatedAt,
  });

  UserForeignLanguage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        language = int.tryParse(json['language']),
        level = int.tryParse(json['level']),
        languageName = json['languageName'],
        languageLevel = json['languageLevel'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];
}