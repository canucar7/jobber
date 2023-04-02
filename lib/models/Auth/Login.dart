class LoginModel {
  bool success;
  String accessToken;
  String tokenType;
  int expiresIn;
  UserModel user;

  LoginModel({
    required this.success,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'] as bool,
      accessToken: json['data']['access_token'] as String,
      tokenType: json['data']['token_type'] as String,
      expiresIn: json['data']['expires_in'] as int,
      user: UserModel.fromJson(json['data']['user']),
    );
  }
}

class UserModel {
  int id;
  String name;
  String email;
  String? emailVerifiedAt;
  String createdAt;
  String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}