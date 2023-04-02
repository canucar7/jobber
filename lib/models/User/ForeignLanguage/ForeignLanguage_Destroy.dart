class LanguageDestroy {
  String languageName;
  String languageLevel;
  int id;
  int userId;
  int language;
  int level;
  DateTime createdAt;
  DateTime updatedAt;

  LanguageDestroy({
    required this.languageName,
    required this.languageLevel,
    required this.id,
    required this.userId,
    required this.language,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LanguageDestroy.fromJson(Map<String, dynamic> json) {
    return LanguageDestroy(
      languageName: json['languageName'],
      languageLevel: json['languageLevel'],
      id: json['id'],
      userId: json['user_id'],
      language: json['language'],
      level: json['level'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'languageName': languageName,
    'languageLevel': languageLevel,
    'id': id,
    'user_id': userId,
    'language': language,
    'level': level,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
