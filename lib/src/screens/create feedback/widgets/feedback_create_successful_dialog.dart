import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class SuccessfulFeedbackDialog extends StatefulWidget {
  SuccessfulFeedbackDialog({Key? key, required this.message}) : super(key: key);
  String message;
  @override
  State<SuccessfulFeedbackDialog> createState() =>
      _SuccessfulFeedbackDialogState();
}

class _SuccessfulFeedbackDialogState extends State<SuccessfulFeedbackDialog> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        height: height * 0.18,
        width: width * 0.8,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              image: DecorationImage(
                image:
                    AssetImage("assets/logout-confirm-dialog-background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  widget.message,
                  style: AppTextStyle.lato.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1400FF),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.04,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.Black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.White.withOpacity(0.3),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Đóng",
                        style: AppTextStyle.lato.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
