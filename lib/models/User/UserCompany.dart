class UserCompany {
  Address address;
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

  UserCompany({
    required this.address,
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

  UserCompany.fromJson(Map<String, dynamic> json) :
      address= Address.fromJson(json['address']),
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

class Address {
  int id;
  String modelType;
  int modelId;
  int countryId;
  int cityId;
  int districtId;
  String neighborhoodName;
  String remainingAddress;
  double? latitude;
  double? longitude;
  String? deletedAt;
  String createdAt;
  String updatedAt;

  Address({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.countryId,
    required this.cityId,
    required this.districtId,
    required this.neighborhoodName,
    required this.remainingAddress,
    this.latitude,
    this.longitude,
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
      latitude= double.tryParse(json['latitude'].toString()),
      longitude= double.tryParse(json['longitude'].toString()),
      deletedAt= json['deleted_at'],
      createdAt= json['created_at'],
      updatedAt= json['updated_at'];

}
