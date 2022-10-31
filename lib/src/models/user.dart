import 'dart:convert';

class MDUser {
  String? name;
  String? surname;
  String? userName;
  String? email;
  String? password;
  String? gender;
  String? idNumber;
  String? fullName;
  String? birthDate;
  String? apartmentId;

  MDUser({
    this.name,
    this.userName,
    this.surname,
    this.email,
    this.password,
    this.gender,
    this.idNumber,
    this.fullName,
    this.birthDate,
    this.apartmentId
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "surname": surname,
      "userName": userName,
      "emailAddress": email,
      "password": password,
      "gender": gender,
      "idNumber": idNumber,
      "fullName": fullName,
      "birthDate": birthDate,
      "apartmentId": apartmentId
    };
  }

  factory MDUser.fromMap(Map<String, dynamic> map) {
    return MDUser(
      name: map['name'],
      surname: map['surname'],
      userName: map['userName'],
      email: map['emailAddress'],
      password: map['password'],
      gender: map['gender'],
      idNumber: map['idNumber'],
      fullName: map['fullName'],
      birthDate: map['birthDate'],
      apartmentId: map['apartmentId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MDUser.fromJson(String source) => MDUser.fromMap(json.decode(source));
}
