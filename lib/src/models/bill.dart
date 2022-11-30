import 'dart:convert';

class Bill {
  String? billID;
  String billName;
  String emailAddress;
  String ownerName;
  String paymentTerm;
  String? state;
  Bill({
    this.billID,
    required this.billName,
    required this.emailAddress,
    required this.ownerName,
    required this.paymentTerm,
    this.state,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'billID': billID,
      'billName': billName,
      'emailAddress': emailAddress,
      'ownerName': ownerName,
      'paymentTerm': paymentTerm,
      'state': state,
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
  String startDay;
  String endDay;
  String? note;
  String serviceName;
  int price;
  ServiceBill({
    this.serviceId,
    required this.createDay,
    this.createName,
    this.cycle,
    required this.startDay,
    required this.endDay,
    required this.price,
    this.note,
    String? billID,
    required String billName,
    required String emailAddress,
    required String ownerName,
    required String paymentTerm,
    required String state,
    required this.serviceName,
  }) : super(
          billID: billID,
          billName: billName,
          emailAddress: emailAddress,
          ownerName: ownerName,
          paymentTerm: paymentTerm,
          state: state,
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
    };
  }

  factory ServiceBill.fromMap(Map<String, dynamic> map) {
    return ServiceBill(
      serviceId: map['serviceId'],
      createDay: map['createDay'],
      createName: map['createName'],
      cycle: map['cycle'],
      startDay: map['startDay'],
      endDay: map['endDay'],
      note: map['note'],
      billID: map['billID'],
      billName: map['billName'],
      emailAddress: map['emailAddress'],
      ownerName: map['ownerName'],
      paymentTerm: map['paymentTerm'],
      price: map['price'] as int,
      state: map['state'].toString(),
      serviceName: map['serviceName'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ServiceBill.fromJson(String source) =>
      ServiceBill.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ManageBill extends Bill {
  String billType;
  String apartmentID;
  String createName;
  String invoicePeriod;
  int price;
  ManageBill({
    required this.billType,
    required this.apartmentID,
    required this.createName,
    required this.invoicePeriod,
    required this.price,
    String? billID,
    required String billName,
    required String emailAddress,
    required String ownerName,
    required String paymentTerm,
    required String state,
  }) : super(
          billID: billID,
          billName: billName,
          emailAddress: emailAddress,
          ownerName: ownerName,
          paymentTerm: paymentTerm,
          state: state,
        );

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'billType': billType,
      'apartmentID': apartmentID,
      'createName': createName,
      'invoicePeriod': invoicePeriod,
      'billID': billID,
      'billName': billName,
      'emailAddress': emailAddress,
      'ownerName': ownerName,
      'paymentTerm': paymentTerm,
      'price': price,
      'state': state,
    };
  }

  factory ManageBill.fromMap(Map<String, dynamic> map) {
    return ManageBill(
      billType: map['billType'],
      apartmentID: map['apartmentID'],
      createName: map['createName'],
      invoicePeriod: map['invoicePeriod'],
      billID: map['billID'],
      billName: map['billName'],
      emailAddress: map['emailAddress'],
      ownerName: map['ownerName'],
      paymentTerm: map['paymentTerm'],
      price: map['price'] as int,
      state: map['state'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ManageBill.fromJson(String source) =>
      ManageBill.fromMap(json.decode(source) as Map<String, dynamic>);
}

class EandWBill extends Bill {
  String billType;
  String apartmentID;
  String startDay;
  String endDay;
  String price;
  int oldIndex;
  int newIndex;

  EandWBill({
    required this.billType,
    required this.apartmentID,
    required this.startDay,
    required this.endDay,
    required this.oldIndex,
    required this.newIndex,
    required this.price,
    String? billID,
    required String billName,
    required String emailAddress,
    required String ownerName,
    required String paymentTerm,
    String? state,
  }) : super(
          billID: billID,
          billName: billName,
          emailAddress: emailAddress,
          ownerName: ownerName,
          paymentTerm: paymentTerm,
          state: state,
        );

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'billType': billType,
      'apartmentID': apartmentID,
      'startDay': startDay,
      'endDay': endDay,
      'oldIndex': oldIndex,
      'newIndex': newIndex,
      'billID': billID,
      'billName': billName,
      'emailAddress': emailAddress,
      'ownerName': ownerName,
      'paymentTerm': paymentTerm,
      'price': price,
      'state': state,
    };
  }

  factory EandWBill.fromMap(Map<String, dynamic> map) {
    return EandWBill(
      billType: map['billType'],
      apartmentID: map['apartmentID'],
      startDay: map['startDay'],
      endDay: map['endDay'],
      oldIndex: map['oldIndex'] as int,
      newIndex: map['newIndex'] as int,
      billID: map['billID'],
      billName: map['billName'],
      emailAddress: map['emailAddress'],
      ownerName: map['ownerName'],
      paymentTerm: map['paymentTerm'],
      price: map['price'],
      state: map['state'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory EandWBill.fromJson(String source) =>
      EandWBill.fromMap(json.decode(source) as Map<String, dynamic>);
}
