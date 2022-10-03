import 'package:flutter/material.dart';
import 'package:untitled/src/screens/main%20screen/widgets/contact.dart';
import 'package:untitled/src/screens/main%20screen/widgets/temp_and_policy.dart';

import '../../../../utils/app_constant/app_text_style.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container(
          //   margin: const EdgeInsets.only(top: 12),
          //   child: Text(
          //     '■ AIReview là hệ thống đánh giá sản phẩm bằng công nghệ AI. Hệ thống phân tích và đánh giá chất lượng sản phẩm dựa trên các khía cạnh bình luận.',
          //     style: AppTextStyle.robotoSize14.copyWith(
          //         fontSize: 14, fontWeight: FontWeight.w400, height: 1.5),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          const TempAndPolicy(),
          const SizedBox(
            height: 10,
          ),
          // const Contact(),
          // const SizedBox(
          //   height: 15,
          // ),
          // RichText(
          //   text: TextSpan(
          //     text:
          //         'Tòa nhà GSOFT, 235 Lý Thường Kiệt\nP.6, Q.Tân Bình, Tp.HCM.\n',
          //     style: DefaultTextStyle.of(context).style,
          //     children: const <TextSpan>[
          //       TextSpan(
          //           text: 'Phone: ',
          //           style: TextStyle(fontWeight: FontWeight.bold)),
          //       TextSpan(text: '08 999 09179\n'),
          //       TextSpan(
          //           text: 'Hotline: ',
          //           style: TextStyle(fontWeight: FontWeight.bold)),
          //       TextSpan(text: '0913 509 979\n'),
          //       TextSpan(
          //           text: 'Email: ',
          //           style: TextStyle(fontWeight: FontWeight.bold)),
          //       TextSpan(text: 'contact@gsoft.com.vn'),
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 27,
          // ),
        ],
      ),
    );
  }
}
