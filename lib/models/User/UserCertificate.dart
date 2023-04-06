class UserCertificate {
  int id;
  int userId;
  String name;
  String institution;
  DateTime issueDate;
  DateTime createdAt;
  DateTime updatedAt;

  UserCertificate({
    required this.id,
    required this.userId,
    required this.name,
    required this.institution,
    required this.issueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  UserCertificate.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        name = json['name'],
        institution = json['institution'],
        issueDate = DateTime.parse(json['issue_date']),
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);
}