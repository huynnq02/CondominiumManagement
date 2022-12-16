import 'package:flutter/material.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/screens/service%20screen/widgets/item_service_group.dart';

class TabServicesAll extends StatelessWidget {
  final List<ApartmentService> services;

  const TabServicesAll({
    Key? key,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ApartmentService> anNinhServices = [];
    List<ApartmentService> anUongServices = [];
    List<ApartmentService> giaiTriServices = [];
    List<ApartmentService> khacServices = [];

    for (ApartmentService service in services) {
      if (service.typeService == 'Ăn uống') {
        anUongServices.add(service);
      } else if (service.typeService == 'Giải trí') {
        giaiTriServices.add(service);
      } else if (service.typeService == 'An ninh') {
        anNinhServices.add(service);
      } else {
        khacServices.add(service);
      }
    }
    return ListView(
      children: [
        ItemServiceGroup(
          name: 'Dịch vụ an ninh',
          services: anNinhServices,
        ),
        const SizedBox(height: 15),
        ItemServiceGroup(
          name: 'Dịch vụ ăn uống',
          services: anUongServices,
        ),
        const SizedBox(height: 15),
        ItemServiceGroup(
          name: 'Dịch vụ giải trí',
          services: giaiTriServices,
        ),
        const SizedBox(height: 15),
        ItemServiceGroup(
          name: 'Dịch vụ khác',
          services: khacServices,
        ),
        const SizedBox(height: 200)
      ],
    );
  }
}
