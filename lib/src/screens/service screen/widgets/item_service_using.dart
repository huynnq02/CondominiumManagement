import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:untitled/src/models/apartment_service.dart';
import 'package:untitled/src/models/user_service.dart';
import 'package:untitled/src/screens/service%20screen/service_detail_cancel_screen.dart';
import 'package:untitled/src/screens/service%20screen/service_detail_screen.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class ItemServiceUsing extends StatelessWidget {
  final UserService service;
  final int index;

  const ItemServiceUsing({
    Key? key,
    required this.service,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ServiceDetailCancelScreen(
              service: service,
              index: index,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFFFFDFD),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/service.png'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  service.serviceName,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Loại dịch vụ:    ',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      service.typeService!,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFDB2F68),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Chi phí:            ',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      service.price.round().toVND(),
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.lato.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFDB2F68),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
