// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/src/screens/search%20screen/widget/csi_detail.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/phone.dart';
import '../../phone rating screen/phone_rating_screen.dart';

class SuggestedPhone extends StatelessWidget {
  Phone phone;
  SuggestedPhone({Key? key, required this.phone}) : super(key: key);
  Future<void>? _launched;

  Future<void> _launchInWebViewOrVC(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PhoneRatingScreen(phone: phone)),
          );
        },
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              phone.linkImage == ''
                  ? Image.asset(
                      'assets/logo.png',
                      // fit: BoxFit.fitWidth,
                      height: 150, width: 150,
                    )
                  : Image.network(
                      phone.linkImage.toString(),
                      height: 150, width: 150,
                      //fit: BoxFit.fitWidth,
                    ),
              SizedBox(
                height: 10,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 150),
                child: Text(
                  phone.name.toString(),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.nunitoSize13
                      .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    phone.statistical!.overallScore.toString(),
                    style: AppTextStyle.nunitoBoldSize14.copyWith(
                      color: AppColors.Blue,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '•',
                    style: AppTextStyle.nunitoBoldSize14.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    phone.statistical!.labelScore.toString(),
                    style: AppTextStyle.nunitoBoldSize14.copyWith(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 13,
              ),
              ConstrainedBox(
                child: CSIDetail(
                  statistical: phone.statistical,
                ),
                constraints: BoxConstraints(maxWidth: 150),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 160,
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.Orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _launched = _launchInWebViewOrVC(phone.link.toString());
                  },
                  child: Text(
                    'Tới nơi bán',
                    style: AppTextStyle.nunitoSize13.copyWith(
                        color: AppColors.White,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
