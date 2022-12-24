import 'package:flutter/material.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/screens/service%20screen/category_detail_service_screen.dart';
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
                '$name (${services.length})',
                style: AppTextStyle.lato.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF979A9C),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CategoryDetailServiceScreen(
                          services: services,
                          category: name,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  'Xem tất cả',
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 16,
                    color: const Color(0xFFDB2F68),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        services.isEmpty
            ? Align(
                alignment: Alignment.center,
                child: Text(
                  'Không tìm thấy được dịch vụ nào',
                  style: AppTextStyle.lato.copyWith(
                    color: const Color(0xFF979A9C),
                  ),
                ),
              )
            : Wrap(
                children: services
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ServiceDetailScreen(service: e),
                            ),
                          );
                        },
                        child: ItemService(service: e),
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }
}
