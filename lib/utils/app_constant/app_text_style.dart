import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

class AppTextStyle {
  static final nunitoSize13 = GoogleFonts.nunito(
    fontSize: 13,
    color: AppColors.DarkGrey,
  );

  static final robotoSize14 = GoogleFonts.roboto(
    fontSize: 14,
    color: AppColors.DarkGrey,
  );
  static final nunitoBoldSize14 = GoogleFonts.nunito(
      fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.DarkGrey);
}
