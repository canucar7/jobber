class LanguageStore {
  String? languageName;
  String? languageLevel;
  int? language;
  int? level;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  LanguageStore({
    required this.languageName,
    required this.languageLevel,
    required this.language,
    required this.level,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  LanguageStore.fromJson(Map<String, dynamic> json) {
    languageName = json['data']['languageName'];
    languageLevel = json['data']['languageLevel'];
    language = json['data']['language'];
    level = json['data']['level'];
    userId = json['data']['user_id'];
    updatedAt = json['data']['updated_at'];
    createdAt = json['data']['created_at'];
    id = json['data']['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data']['languageName'] = this.languageName;
    data['data']['languageLevel'] = this.languageLevel;
    data['data']['language'] = this.language;
    data['data']['level'] = this.level;
    data['data']['user_id'] = this.userId;
    data['data']['updated_at'] = this.updatedAt;
    data['data']['created_at'] = this.createdAt;
    data['data']['id'] = this.id;
    return data;
  }
}