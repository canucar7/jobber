class CertificateStore {
  final String name;
  final String institution;
  final DateTime issueDate;
  final int userId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  CertificateStore({
    required this.name,
    required this.institution,
    required this.issueDate,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory CertificateStore.fromJson(Map<String, dynamic> json) {
    return CertificateStore(
      name: json['data']['name'],
      institution: json['data']['institution'],
      issueDate: DateTime.parse(json['data']['issue_date']),
      userId: json['data']['user_id'],
      updatedAt: DateTime.parse(json['data']['updated_at']),
      createdAt: DateTime.parse(json['data']['created_at']),
      id: json['data']['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'institution': institution,
      'issue_date': issueDate.toIso8601String(),
      'user_id': userId,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}