import 'package:flutter/material.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/screens/service%20screen/service_detail_screen.dart';
import 'package:untitled/src/screens/service%20screen/widgets/item_service.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ItemServiceGroup extends StatelessWidget {
  final String name;
  final List<ApartmentService> services;

  const ItemServiceGroup({
    Key? key,
    required this.name,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Text(
                name,
                style: AppTextStyle.lato.copyWith(fontSize: 16),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              ApartmentService service = services[index];
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ServiceDetailScreen(service: service),
                      ),
                    );
                  },
                  child: ItemService(service: service),
                ),
              );
            },
            itemCount: services.length,
          ),
        ),
      ],
    );
  }
}
