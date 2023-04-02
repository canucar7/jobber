class LanguageShow {
  final int id;
  final int userId;
  final int language;
  final int level;
  final String languageName;
  final String languageLevel;
  final DateTime createdAt;
  final DateTime updatedAt;

  LanguageShow({
    required this.id,
    required this.userId,
    required this.language,
    required this.level,
    required this.languageName,
    required this.languageLevel,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LanguageShow.fromJson(Map<String, dynamic> json) {
    return LanguageShow(
      id: json['id'],
      userId: json['user_id'],
      language: json['language'],
      level: json['level'],
      languageName: json['languageName'],
      languageLevel: json['languageLevel'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['language'] = this.language;
    data['level'] = this.level;
    data['languageName'] = this.languageName;
    data['languageLevel'] = this.languageLevel;
    data['created_at'] = this.createdAt.toIso8601String();
    data['updated_at'] = this.updatedAt.toIso8601String();
    return data;
  }
}
