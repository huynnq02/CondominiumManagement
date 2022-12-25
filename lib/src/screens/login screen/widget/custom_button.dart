import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final void Function()? onPressed;
  final bool disabled;
  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      this.disabled = false})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            backgroundColor: AppColors.DarkPink,
            disabledBackgroundColor: Color(0xFF979A9C),
            shadowColor: Colors.transparent),
        onPressed: widget.disabled ? null : widget.onPressed,
        child: Text(
          widget.label,
          style: const TextStyle(
              color: AppColors.White,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
