class CertificateShow {
  int id;
  int userId;
  String name;
  String institution;
  String issueDate;
  String createdAt;
  String updatedAt;

  CertificateShow({
    required this.id,
    required this.userId,
    required this.name,
    required this.institution,
    required this.issueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CertificateShow.fromJson(Map<String, dynamic> json) {
    return CertificateShow(
      id: json['data']['id'],
      userId: json['data']['user_id'],
      name: json['data']['name'],
      institution: json['data']['institution'],
      issueDate: json['data']['issue_date'],
      createdAt: json['data']['created_at'],
      updatedAt: json['data']['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'name': name,
    'institution': institution,
    'issue_date': issueDate,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}