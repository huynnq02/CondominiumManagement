import 'dart:convert';

class UserService {
  final int? id;
  final String billID;
  final String billName;
  final String serviceID;
  final String serviceName;
  final String ownerName;
  final String phoneNumber;
  final String emailAddress;
  final String cycle;
  final int price;
  final String note;
  final String state;
  final String startDate;
  final String endDate;
  final String? typeService;
  final String? urlPicture;

  UserService({
    this.id,
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
    required this.typeService,
    this.urlPicture,
  });

  UserService setId(int idService) {
    return UserService(
      id: idService,
      billID: billID,
      billName: billName,
      serviceID: serviceID,
      serviceName: serviceName,
      ownerName: ownerName,
      phoneNumber: phoneNumber,
      emailAddress: emailAddress,
      cycle: cycle,
      price: price,
      note: note,
      state: state,
      startDate: startDate,
      endDate: endDate,
      typeService: typeService,
      urlPicture: urlPicture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
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
      'typeService': typeService,
      'urlPicture': urlPicture,
    };
  }

  factory UserService.fromMap(Map<String, dynamic> map) {
    return UserService(
      id: map['id'] != null ? map['id'] as int : null,
      billID: map['billID'] as String,
      billName: map['billName'] as String,
      serviceID: map['serviceID'] as String,
      serviceName: map['serviceName'] as String,
      ownerName: map['ownerName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      emailAddress: map['emailAddress'] as String,
      cycle: map['cycle'] as String,
      price: map['price'] as int,
      note: map['note'] as String,
      state: map['state'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      typeService:
          map['typeService'] != null ? map['typeService'] as String : null,
      urlPicture:
          map['urlPicture'] != null ? map['urlPicture'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserService.fromJson(String source) =>
      UserService.fromMap(json.decode(source) as Map<String, dynamic>);
}
