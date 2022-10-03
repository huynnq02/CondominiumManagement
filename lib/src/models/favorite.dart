import 'dart:convert';

class Favorite {
  int? id;
  String? idUser;
  String? idPhone;

  Favorite({this.id, this.idUser, this.idPhone});

  Map<String, dynamic> toMap() {
    return {
      'userId': idUser,
      'id': id,
      'productId': idPhone
      //  'totalNegative': phone?.toMap(),
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
        idUser: map['userId'], id: map['id'], idPhone: map['productId']
        // phone: map['aspectsScore'] != null
        //     ? Phone.fromMap(map['aspectsScore'])
        //     : null,
        );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) =>
      Favorite.fromMap(json.decode(source));
}
