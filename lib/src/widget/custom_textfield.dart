import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_constant/app_colors.dart';
import '../../utils/app_constant/app_text_style.dart';

enum iconType {
  lock,
  mail,
  person,
  name,
}

class CustomTextField extends StatefulWidget {
  final iconType type;
  final String input;
  final valueString;
  const CustomTextField(
      {Key? key, required this.input, required this.type, this.valueString})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  final controller = TextEditingController();
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: ((value) {
        setState(() {
          widget.valueString(value);
        });
      }),
      validator: (value) {
        // Check if this field is empty
        if (value == null || value.isEmpty) {
          return 'Vui lòng điền thông tin';
        }
      },
      obscureText: widget.type == iconType.lock ? _obscureText : false,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.MidGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.MidGrey,
            width: 1,
          ),
        ),
        hintText: widget.input,
        hintStyle: AppTextStyle.nunitoSize13.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.MidGrey,
        ),
        prefixIcon: widget.type != iconType.name
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 17,
                  right: 10,
                ),
                child: widget.type == iconType.lock
                    ? const Icon(
                        Icons.lock,
                      )
                    : widget.type == iconType.mail
                        ? const Icon(
                            Icons.email,
                          )
                        : const Icon(
                            Icons.person,
                          ),
              )
            : null,
        suffixIcon: widget.type == iconType.lock
            ? Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 14, right: 17),
                child: GestureDetector(
                  onTap: _toggle,
                  child: _obscureText == true
                      ? SvgPicture.asset(
                          'assets/eye.svg',
                          width: 17,
                          height: 17,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          size: 20,
                          color: AppColors.Black,
                        ),
                ),
              )
            : null,
      ),
    );
  }
}
