import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_shadows.dart';

class ChangePasswordInput extends StatefulWidget {
  final TextEditingController pwController;
  final String label;
  final String labelText;
  final String? error;
  final bool? pwRule;

  const ChangePasswordInput(
      {Key? key,
      required this.pwController,
      required this.label,
      required this.labelText,
      this.error,
      this.pwRule})
      : super(key: key);

  @override
  State<ChangePasswordInput> createState() => _ChangePasswordInputState();
}

class _ChangePasswordInputState extends State<ChangePasswordInput> {
  final FocusNode unitCodeCtrlFocusNode = FocusNode();
  bool _obscureText = true;
  String errorText = '';

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   widget.label,
        //   style: TextStyle(
        //       fontSize: 20,
        //       color: Colors.white,
        //       fontWeight: FontWeight.w300,
        //       shadows: AppShadows.defaultShadows),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        GestureDetector(
          onTap: () {
            unitCodeCtrlFocusNode.requestFocus();
          },
          child: Stack(alignment: Alignment.center, children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                  border: ((widget.error != null && widget.error!.isNotEmpty) ||
            errorText.isNotEmpty) ? Border.all(color: AppColors.Red) :Border.all(color: Colors.black.withOpacity(0.2)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)),
              child: Stack(alignment: Alignment.center, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.labelText,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      controller: widget.pwController,
                      focusNode: unitCodeCtrlFocusNode,
                      obscureText: _obscureText,
                      obscuringCharacter: '*',
                      style: const TextStyle(fontSize: 18),
                      maxLength: 20,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            errorText = 'Vui lòng nhập mật khẩu';
                          });
                          return '';
                        }
                        if (!(widget.pwRule != null &&
                            widget.pwRule == false)) {
                          if (value.length < 6) {
                            setState(() {
                              errorText = 'Tối thiểu 6 ký tự';
                            });
                            return '';
                          }
                        }
                        setState(() {
                          errorText = '';
                        });
                        return null;
                      },
                      decoration: const InputDecoration(
                          isDense: true,
                          errorStyle: TextStyle(height: 0),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          counterText: ''),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                      onTap: _toggle,
                      child: _obscureText == true
                          ? SvgPicture.asset(
                              'assets/visibility.svg',
                            )
                          : SvgPicture.asset(
                              'assets/visibility-off.svg',
                            )),
                )
              ]),
            ),
          ]),
        ),
        const SizedBox(
          height: 4,
        ),
        if ((widget.error != null && widget.error!.isNotEmpty) ||
            errorText.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: Text(
              (widget.error != null && widget.error!.isNotEmpty)
                  ? widget.error!
                  : errorText,
              style: GoogleFonts.inter(color: AppColors.Red, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          )
      ],
    );
  }
}
