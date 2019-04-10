import 'dart:convert';

List<Place> placesFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Place>.from(
      jsonData['d']['results'].map((x) => Place.fromJson(x)));
}

Place placeFromJson(String str) {
  final jsonData = json.decode(str);
  return Place.fromJson(jsonData);
}

class Place {
  String numid;
  String title;
  String address;
  String zipCode;
  String city;
  double latitude;
  double longitude;
  String description;
  List<String> pictures;

  Place({
    this.numid,
    this.title,
    this.address,
    this.zipCode,
    this.city,
    this.latitude,
    this.longitude,
    this.description,
    this.pictures,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        numid: json["NUMID"] == null ? null : json["NUMID"],
        title: json["TITRE"] == null ? '' : json["TITRE"],
        address: json["ADRESSE1S"] == null ? '' : json["ADRESSE1S"],
        zipCode: json["CODEPOSTAL"] == null ? '' : json["CODEPOSTAL"],
        city: json["COMMUNE"] == null ? '' : json["COMMUNE"],
        latitude:
            json["LATITUDE"] == null ? null : double.parse(json["LATITUDE"]),
        longitude:
            json["LONGITUDE"] == null ? null : double.parse(json["LONGITUDE"]),
        description: json["DESCRIPTIF"] == null ? '' : json["DESCRIPTIF"],
        pictures: json["PHOTOS"] == null ? null : json["PHOTOS"].split(' | '),
      );
}
