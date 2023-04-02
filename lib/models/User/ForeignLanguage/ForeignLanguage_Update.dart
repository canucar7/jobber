class LanguageUpdate {
  String languageName;
  String languageLevel;
  int id;
  int userId;
  int language;
  int level;
  String createdAt;
  String updatedAt;

  LanguageUpdate({
    required this.languageName,
    required this.languageLevel,
    required this.id,
    required this.userId,
    required this.language,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LanguageUpdate.fromJson(Map<String, dynamic> json) {
    return LanguageUpdate(
      languageName: json['languageName'],
      languageLevel: json['languageLevel'],
      id: json['id'],
      userId: json['user_id'],
      language: json['language'],
      level: json['level'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'languageName': languageName,
    'languageLevel': languageLevel,
    'id': id,
    'user_id': userId,
    'language': language,
    'level': level,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
