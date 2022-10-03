import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_text_style.dart';
import '../../../models/phone.dart';

class PlaceSale extends StatelessWidget {
  Phone phone;
  PlaceSale({Key? key, required this.phone}) : super(key: key);
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
    return SizedBox(
      width: 160,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: phone.link == null
              ? Color.fromARGB(124, 235, 160, 61).withOpacity(0.3)
              : AppColors.Orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
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
    );
  }
}
