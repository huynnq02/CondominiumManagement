import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/models/user_service.dart';
import 'package:untitled/src/screens/service%20screen/widgets/item_service_using.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class TabServicesUsing extends StatefulWidget {
  final List<UserService> services;

  const TabServicesUsing({
    Key? key,
    required this.services,
  }) : super(key: key);

  @override
  State<TabServicesUsing> createState() => _TabServicesUsingState();
}

class _TabServicesUsingState extends State<TabServicesUsing> {
  final List<String> items = [
    'Tất cả',
    'An ninh',
    'Ăn uống',
    'Giải trí',
    'Khác',
  ];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = items[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                'Có ${widget.services.length} dịch vụ đang dùng',
                style: AppTextStyle.lato.copyWith(fontSize: 16),
              ),
              const Spacer(),
              // box filter
              Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.Black),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      selectedValue!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    buttonHeight: 35,
                    buttonWidth: 120,
                    itemHeight: 35,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: size.height,
            width: size.width,
            child: ListView.builder(
              itemBuilder: (context, index) {
                UserService service = widget.services[index];
                return ItemServiceUsing(service: service);
              },
              itemCount: widget.services.length,
            ),
          ),
        ],
      ),
    );
  }
}
