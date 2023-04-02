class CertificateUpdate {
  int id;
  int userId;
  String name;
  String institution;
  DateTime issueDate;
  DateTime createdAt;
  DateTime updatedAt;

  CertificateUpdate({
    required this.id,
    required this.userId,
    required this.name,
    required this.institution,
    required this.issueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CertificateUpdate.fromJson(Map<String, dynamic> json) {
    return CertificateUpdate(
      id: json['data']['id'],
      userId: json['data']['user_id'],
      name: json['data']['name'],
      institution: json['data']['institution'],
      issueDate: DateTime.parse(json['data']['issue_date']),
      createdAt: DateTime.parse(json['data']['created_at']),
      updatedAt: DateTime.parse(json['data']['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['institution'] = this.institution;
    data['issue_date'] = this.issueDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return {'data': data};
  }



}