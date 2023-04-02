class CertificateDestroy {
  final int id;
  final int userId;
  final String name;
  final String institution;
  final String issueDate;
  final String createdAt;
  final String updatedAt;

  CertificateDestroy({
    required this.id,
    required this.userId,
    required this.name,
    required this.institution,
    required this.issueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CertificateDestroy.fromJson(Map<String, dynamic> json) {
    return CertificateDestroy(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      institution: json['institution'],
      issueDate: json['issue_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'institution': institution,
      'issue_date': issueDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}