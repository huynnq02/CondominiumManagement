import 'dart:convert';

class MDUser {
  String name;
  String surname;
  String userName;
  String email;
  // String password;
  String gender;
  String idNumber;
  // String fullName;
  String birthDate;
  String? phoneNumber;

  MDUser(
      {required this.name,
      required this.userName,
      required this.surname,
      required this.email,
      // required this.password,
      required this.gender,
      required this.idNumber,
      // required this.fullName,
      required this.birthDate,
      this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "surname": surname,
      "userName": userName,
      "emailAddress": email,
      // "password": password,
      "gender": gender,
      "idNumber": idNumber,
      // "fullName": fullName,
      "birthDate": birthDate
    };
  }

  factory MDUser.fromMap(Map<String, dynamic> map) {
    return MDUser(
      name: map['name'],
      surname: map['surname'],
      userName: map['userName'],
      email: map['emailAddress'],
      // password: map['password'],
      gender: map['gender'],
      idNumber: map['idNumber'],
      // fullName: map['fullName'],
      birthDate: map['birthDate'],
      phoneNumber: map['phoneNumber']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MDUser.fromJson(String source) => MDUser.fromMap(json.decode(source));
}
