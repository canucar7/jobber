class CompanyInformation {
  int id;
  int userId;
  String name;
  String description;
  String? coverImageUrl;
  int? phoneNumber;
  int? status;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;

  CompanyInformation({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.coverImageUrl,
    required this.phoneNumber,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  CompanyInformation.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      userId= json['user_id'],
      name= json['name'],
      description= json['description'],
      coverImageUrl= json['cover_image_url'],
      phoneNumber= int.tryParse(json['phone_number'].toString()),
      status= json['status'],
      deletedAt= json['deleted_at'],
      createdAt= json['created_at'],
      updatedAt= json['updated_at'];
}