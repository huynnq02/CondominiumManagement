import 'dart:convert';

class MDUser {
  String? name;
  String? surname;
  String? userName;
  String? email;
  String? password;

  MDUser({
    this.name,
    this.userName,
    this.surname,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "surname": surname,
      "userName": userName,
      "emailAddress": email,
      "password": password,
    };
  }

  factory MDUser.fromMap(Map<String, dynamic> map) {
    return MDUser(
      name: map['name'],
      surname: map['surname'],
      userName: map['userName'],
      email: map['emailAddress'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MDUser.fromJson(String source) => MDUser.fromMap(json.decode(source));
}
