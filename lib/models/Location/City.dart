class City {
  int id;
  int countryId;
  String plateCode;
  String phoneCode;
  String name;

  City({
    required this.id,
    required this.countryId,
    required this.plateCode,
    required this.phoneCode,
    required this.name,
  });

  City.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      countryId = json['country_id'],
      plateCode = json['plate_code'],
      phoneCode = json['phone_code'],
      name = json['name'];
}
