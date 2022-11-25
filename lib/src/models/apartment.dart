import 'dart:convert';

class Apartment {
  String apartmentId;
  String buildingId;
  Apartment({required this.apartmentId, required this.buildingId});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'apartmentId': apartmentId,
      'buildingId': buildingId
    };
  }

  factory Apartment.fromMap(Map<String, dynamic> map) {
    return Apartment(
        apartmentId: map['apartmentId'] as String,
        buildingId: map['buildingId'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Apartment.fromJson(String source) =>
      Apartment.fromMap(json.decode(source) as Map<String, dynamic>);
}
