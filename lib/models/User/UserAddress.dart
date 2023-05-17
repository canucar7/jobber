class UserAddress {
  int id;
  String modelType;
  int modelId;
  int countryId;
  int cityId;
  int districtId;
  String neighborhoodName;
  String? remainingAddress;
  String? fullAddress;
  double? latitude;
  double? longitude;
  String? deletedAt;
  String createdAt;
  String updatedAt;

  UserAddress({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.countryId,
    required this.cityId,
    required this.districtId,
    required this.neighborhoodName,
    this.remainingAddress,
    this.fullAddress,
    this.latitude,
    this.longitude,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  UserAddress.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      modelType = json['model_type'],
      modelId = json['model_id'],
      countryId = json['country_id'],
      cityId = json['city_id'],
      districtId = json['district_id'],
      neighborhoodName = json['neighborhood_name'],
      remainingAddress = json['remaining_address'] != null ? json['remaining_address'] : null,
      fullAddress = json['full_address'] != null ? json['full_address'] : null,
      latitude = double.tryParse(json['latitude'].toString()),
      longitude = double.tryParse(json['longitude'].toString()),
      deletedAt = json['deleted_at'],
      createdAt = json['created_at'],
      updatedAt = json['updated_at'];
}
