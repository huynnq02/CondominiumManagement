import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/screens/service%20screen/service_detail_screen.dart';
import 'package:untitled/src/screens/service%20screen/widgets/item_service.dart';
import 'package:untitled/src/screens/service%20screen/widgets/item_service_detail.dart';
import 'package:untitled/src/screens/service%20screen/widgets/item_service_using.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class CategoryDetailServiceScreen extends StatelessWidget {
  const CategoryDetailServiceScreen({
    Key? key,
    required this.services,
    required this.category,
  }) : super(key: key);
  final List<ApartmentService> services;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A3072),
        elevation: 0,
        title: Text(
          category,
          style: AppTextStyle.lato.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                final bool? result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ServiceDetailScreen(
                      service: services[index],
                    ),
                  ),
                );
                if (result == true) {
                  Navigator.of(context).pop();
                }
              },
              child: ItemServiceDetail(
                service: services[index],
              ),
            );
          },
          itemCount: services.length,
        ),
      ),
    );
  }
}
