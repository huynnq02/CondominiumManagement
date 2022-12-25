import 'dart:convert';

class Bill {
  String? billID;
  String billName;
  String emailAddress;
  String ownerName;
  String paymentTerm;
  String? state;
  String startDay;
  String endDay;
  int price;
  String? datePayment;
  Bill({
    this.billID,
    required this.billName,
    required this.emailAddress,
    required this.ownerName,
    required this.paymentTerm,
    this.state,
    required this.startDay,
    required this.endDay,
    required this.price,
    this.datePayment,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'billID': billID,
      'billName': billName,
      'emailAddress': emailAddress,
      'ownerName': ownerName,
      'paymentTerm': paymentTerm,
      'state': state,
      'startDay': startDay,
      'endDay': endDay,
      'price': price,
      'datePayment': datePayment,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      billID: map['billID'],
      billName: map['billName'],
      emailAddress: map['emailAddress'],
      ownerName: map['ownerName'],
      paymentTerm: map['paymentTerm'],
      state: map['state'],
      startDay: map['startDay'],
      endDay: map['endDay'],
      price: map['price'] as int,
      datePayment: map['datePayment']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bill.fromJson(String source) =>
      Bill.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ServiceBill extends Bill {
  String? serviceId;
  String createDay;
  String? createName;
  String? cycle;

  String? note;
  String serviceName;
  String? phoneNumber;
  ServiceBill({
    this.serviceId,
    required this.createDay,
    this.createName,
    this.cycle,
    this.note,
    String? billID,
    required String billName,
    required String emailAddress,
    required String ownerName,
    required String paymentTerm,
    required String state,
    required this.serviceName,
    required int price,
    required String startDay,
    required String endDay,
    String? datePayment,
    this.phoneNumber,
  }) : super(
          billID: billID,
          billName: billName,
          emailAddress: emailAddress,
          ownerName: ownerName,
          paymentTerm: paymentTerm,
          state: state,
          startDay: startDay,
          endDay: endDay,
          price: price,
          datePayment: datePayment,
        );

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceId': serviceId,
      'createDay': createDay,
      'createName': createName,
      'cycle': cycle,
      'startDay': startDay,
      'endDay': endDay,
      'note': note,
      'billID': billID,
      'billName': billName,
      'emailAddress': emailAddress,
      'ownerName': ownerName,
      'paymentTerm': paymentTerm,
      'price': price,
      'state': state,
      'serviceName': serviceName,
      'phoneNumber': phoneNumber,
      'datePayment': datePayment,
    };
  }

  factory ServiceBill.fromMap(Map<String, dynamic> map) {
    return ServiceBill(
      serviceId: map['serviceId'],
      createDay: map['createDay'],
      createName: map['createName'],
      cycle: map['cycle'],
      note: map['note'],
      billID: map['billID'],
      billName: map['billName'],
      emailAddress: map['emailAddress'],
      ownerName: map['ownerName'],
      paymentTerm: map['paymentTerm'],
      state: map['state'].toString(),
      serviceName: map['serviceName'],
      price: map['price'] as int,
      phoneNumber: map['phoneNumber']?.toString(),
      startDay: map['startDay'],
      endDay: map['endDay'],
      datePayment: map['datePayment']?.toString(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ServiceBill.fromJson(String source) =>
      ServiceBill.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ApartmentBill extends Bill {
  String billType;
  String apartmentID;
  int oldIndex;
  int newIndex;
  String? createName;
  String invoicePeriod;
  String createDay;
  double areaOfApartment;
  double priceOfApartment;
  ApartmentBill({
    required this.billType,
    required this.apartmentID,
    required this.oldIndex,
    required this.newIndex,
    this.createName,
    required this.invoicePeriod,
    required this.createDay,
    String? billID,
    required String billName,
    required String emailAddress,
    required String ownerName,
    required String paymentTerm,
    required String state,
    required int price,
    required String startDay,
    required String endDay,
    String? datePayment,
    required this.areaOfApartment,
    required this.priceOfApartment,
  }) : super(
          billID: billID,
          billName: billName,
          emailAddress: emailAddress,
          ownerName: ownerName,
          paymentTerm: paymentTerm,
          state: state,
          startDay: startDay,
          endDay: endDay,
          price: price,
          datePayment: datePayment,
        );

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'billType': billType,
      'apartmentID': apartmentID,
      'oldIndex': oldIndex,
      'newIndex': newIndex,
      'createName': createName,
      'invoicePeriod': invoicePeriod,
      'createDay': createDay,
      'billID': billID,
      'billName': billName,
      'emailAddress': emailAddress,
      'ownerName': ownerName,
      'paymentTerm': paymentTerm,
      'price': price,
      'state': state,
      'startDay': startDay,
      'endDay': endDay,
      'datePayment': datePayment,
      'areaOfApartment': areaOfApartment,
      'priceOfApartment': priceOfApartment,
    };
  }

  factory ApartmentBill.fromMap(Map<String, dynamic> map) {
    return ApartmentBill(
      billType: map['billType'],
      apartmentID: map['apartmentID'],
      oldIndex: map['oldIndex'] as int,
      newIndex: map['newIndex'] as int,
      createName: map['createName']?.toString(),
      invoicePeriod: map['invoicePeriod'],
      createDay: map['createDay'],
      billID: map['billID'],
      billName: map['billName'],
      emailAddress: map['emailAddress'],
      ownerName: map['ownerName'],
      paymentTerm: map['paymentTerm'],
      state: map['state'].toString(),
      price: map['price'] as int,
      startDay: map['startDay'],
      endDay: map['endDay'],
      datePayment: map['datePayment']?.toString(),
      areaOfApartment: map['areaOfApartment'] as double,
      priceOfApartment: map['priceOfApartment'] as double,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ApartmentBill.fromJson(String source) =>
      ApartmentBill.fromMap(json.decode(source) as Map<String, dynamic>);
}
