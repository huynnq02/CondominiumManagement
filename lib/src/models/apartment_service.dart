// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApartmentService {
  final String serviceName;
  final String? describe;
  final int serviceCharge;
  final String cycle;
  final String typeService;
  final int id;
  final String? responsibleUnit;

  ApartmentService({
    required this.serviceName,
    this.describe,
    required this.serviceCharge,
    required this.cycle,
    required this.typeService,
    required this.id,
    this.responsibleUnit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceName': serviceName,
      'describe': describe,
      'serviceCharge': serviceCharge,
      'cycle': cycle,
      'typeService': typeService,
      'id': id,
      'responsibleUnit': responsibleUnit,
    };
  }

  factory ApartmentService.fromMap(Map<String, dynamic> map) {
    return ApartmentService(
      serviceName: map['serviceName'] as String,
      describe: map['describe'] != null ? map['describe'] as String : null,
      serviceCharge: map['serviceCharge'] as int,
      cycle: map['cycle'] as String,
      typeService: map['typeService'] as String,
      id: map['id'] as int,
      responsibleUnit: map['responsibleUnit'] != null
          ? map['responsibleUnit'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApartmentService.fromJson(String source) =>
      ApartmentService.fromMap(json.decode(source) as Map<String, dynamic>);
}
