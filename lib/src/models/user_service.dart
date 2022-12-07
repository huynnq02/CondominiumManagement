import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserService {
  final String billID;
  final String billName;
  final String serviceID;
  final String serviceName;
  final String ownerName;
  final String phoneNumber;
  final String emailAddress;
  final String cycle;
  final double price;
  final String note;
  final String state;
  final String startDate;
  final String endDate;

  UserService({
    required this.billID,
    required this.billName,
    required this.serviceID,
    required this.serviceName,
    required this.ownerName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.cycle,
    required this.price,
    required this.note,
    required this.state,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'billID': billID,
      'billName': billName,
      'serviceID': serviceID,
      'serviceName': serviceName,
      'ownerName': ownerName,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
      'cycle': cycle,
      'price': price,
      'note': note,
      'state': state,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory UserService.fromMap(Map<String, dynamic> map) {
    return UserService(
      billID: map['billID'] as String,
      billName: map['billName'] as String,
      serviceID: map['serviceID'] as String,
      serviceName: map['serviceName'] as String,
      ownerName: map['ownerName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      emailAddress: map['emailAddress'] as String,
      cycle: map['cycle'] as String,
      price: map['price'] as double,
      note: map['note'] as String,
      state: map['state'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserService.fromJson(String source) =>
      UserService.fromMap(json.decode(source) as Map<String, dynamic>);
}
