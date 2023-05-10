class Advertisement {
  int id;
  int userId;
  int? companyId;
  int purpose;
  int status;
  int? jobId;
  String? jobTitle;
  String employmentType;
  String? description;
  String period;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  Company? company;
  Address address;

  Advertisement({
    required this.id,
    required this.userId,
    this.companyId,
    required this.purpose,
    required this.status,
    this.jobId,
    this.jobTitle,
    required this.employmentType,
    this.description,
    required this.period,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    this.company,
    required this.address,
  });

  Advertisement.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      userId= json['user_id'],
      companyId= json['company_id'] != null ? int.parse(json['company_id']) : null,
      purpose= int.parse(json['purpose']),
      status= json['status'],
      jobId= json['job_id'] != null ? int.parse(json['job_id']) : null,
      jobTitle= json['job_title'] != null ? (json['job_title'].toString()) : null,
      employmentType= json['employment_type'],
      description= json['description'] != null ? (json['description'].toString()) : null,
      period= json['period'],
      createdAt= DateTime.parse(json['created_at']),
      updatedAt= DateTime.parse(json['updated_at']),
      user= User.fromJson(json['user']),
      company= json['company'] != null ? Company.fromJson(json['company']):null,
      address= Address.fromJson(json['address']);

}

class User {
  int id;
  String name;
  String email;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      name= json['name'],
      email= json['email'],
      emailVerifiedAt= json['email_verified_at'] != null ? DateTime.parse(json['email_verified_at']) : null,
      createdAt= DateTime.parse(json['created_at']),
      updatedAt= DateTime.parse(json['updated_at']);

}

class Address {
  int id;
  String modelType;
  int modelId;
  int countryId;
  int cityId;
  int districtId;
  String neighborhoodName;
  String? remainingAddress;
  String latitude;
  String longitude;
  DateTime? deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  Address({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.countryId,
    required this.cityId,
    required this.districtId,
    required this.neighborhoodName,
    this.remainingAddress,
    required this.latitude,
    required this.longitude,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Address.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      modelType= json['model_type'],
      modelId= json['model_id'],
      countryId= json['country_id'],
      cityId= json['city_id'],
      districtId= json['district_id'],
      neighborhoodName= json['neighborhood_name'],
      remainingAddress= json['remaining_address'],
      latitude= json['latitude'],
      longitude= json['longitude'],
      deletedAt= json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      createdAt= DateTime.parse(json['created_at']),
      updatedAt= DateTime.parse(json['updated_at']);

}

class Company {
  int id;
  int userId;
  String name;
  String description;
  String coverImageUrl;
  int phoneNumber;
  int status;
  DateTime? deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Address address;

  Company({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.coverImageUrl,
    required this.phoneNumber,
    required this.status,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
  });

  Company.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      userId= json['user_id'],
      name= json['name'],
      description= json['description'],
      coverImageUrl= json['cover_image_url'],
      phoneNumber= json['phone_number'],
      status= json['status'],
      deletedAt= json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      createdAt= DateTime.parse(json['created_at']),
      updatedAt= DateTime.parse(json['updated_at']),
      address= Address.fromJson(json['address']);

}
