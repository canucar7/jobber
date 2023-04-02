class CertificateIndex {
  final int id;
  final int userId;
  final String name;
  final String institution;
  final String issueDate;
  final String createdAt;
  final String updatedAt;

  CertificateIndex({
    required this.id,
    required this.userId,
    required this.name,
    required this.institution,
    required this.issueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CertificateIndex.fromJson(Map<String, dynamic> json) {
    return CertificateIndex(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      institution: json['institution'],
      issueDate: json['issue_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}