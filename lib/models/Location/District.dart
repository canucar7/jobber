class District {
  int id;
  int cityId;
  String name;

  District({required this.id, required this.cityId, required this.name});

  District.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      cityId = json['city_id'],
      name = json['name'];
}
