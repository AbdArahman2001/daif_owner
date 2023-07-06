class AddressModel {
  String lat;
  String long;
  String name;

  AddressModel({
    required this.lat,
    required this.long,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
      'name': name,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      lat: map['lat'] as String,
      long: map['long'] as String,
      name: map['name'] as String,
    );
  }
}
