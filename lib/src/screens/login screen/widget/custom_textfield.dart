import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

enum TextFieldType { email, password, number, date, name, autocomplete }

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? error;
  final bool? pwRule;
  final int? maxLength;
  final TextFieldType? type;
  final List<String>? items;
  final dynamic Function(String)? onSuggestionSelected;
  final void Function(BuildContext context)? onTap;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.type,
    this.error,
    this.pwRule,
    this.maxLength,
    this.items,
    this.onSuggestionSelected,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode unitCodeCtrlFocusNode = FocusNode();
  bool _obscureText = true;
  String errorText = '';

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool isEmail(String input) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);

  bool isPhone(String input) =>
      RegExp(r'(^(?:[+0]9)?[0-9]{10,11}$)').hasMatch(input);

  String? getValidator(String? value, TextFieldType? type) {
    if (value != null) {
      switch (type) {
        case TextFieldType.email:
          if (value.isEmpty) {
            errorText = 'Vui lòng nhập email hoặc số điện thoại';
            return '';
          }
          final isNum = num.tryParse(value) is num;
          if (!isNum) {
            if (!isEmail(value)) {
              errorText = 'Định dạng email không đúng, vui lòng nhập lại';
              return '';
            }
          } else {
            if (!isPhone(value) || !value.startsWith('0')) {
              errorText = 'Định dạng không hợp lệ, vui lòng nhập lại';
              return '';
            }
          }
          break;
        case TextFieldType.password:
          if (value.isEmpty) {
            errorText = 'Vui lòng nhập mật khẩu';
            return '';
          }
          if (widget.pwRule != null && widget.pwRule == false) {
            break;
          }
          if (value.length < 6) {
            errorText = 'Tối thiểu 6 ký tự';
            return '';
          }
          break;
        case TextFieldType.name:
          if (value.isEmpty) {
            errorText = 'Vui lòng nhập họ tên';
            return '';
          }
          RegExp exp = RegExp(r"[^a-z ]", caseSensitive: false);
          if (exp.allMatches(value).isNotEmpty) {
            errorText = 'Chỉ được bao gồm ký tự chữ';
            return '';
          } else if (value.split(' ').length < 2) {
            errorText = 'Họ tên phải có ít nhất 2 từ';
            return '';
          }
          break;
        case TextFieldType.number:
          if (value.isEmpty) {
            errorText = 'Vui lòng nhập thông tin';
            return '';
          } else if (value.length != 9 && value.length != 12) {
            errorText = 'Số CMND / CCCD không hợp lệ';
            return '';
          }
          break;
        case null:
          if (value.isEmpty) {
            errorText = 'Vui lòng nhập thông tin';
            return '';
          }
      }
    }
    errorText = '';
    return null;
  }

  String formatedName(String value) {
    var splitStr = value.split(' ');
    for (var i = 0; i < splitStr.length; i++) {
      if (splitStr[i].isNotEmpty) {
        splitStr[i] =
            '${splitStr[i][0].toUpperCase()}${splitStr[i].substring(1).toLowerCase()}';
      }
    }
    String result = splitStr.join(' ');
    return result;
  }

  void handleOnTap() {
    if (widget.onTap != null) widget.onTap!(context);
    unitCodeCtrlFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: handleOnTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
                border: (errorText != '' ||
                        (widget.error != null && widget.error != ''))
                    ? Border.all(color: AppColors.Red)
                    : Border.all(color: Colors.black.withOpacity(0.2)),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12)),
            child: Stack(alignment: Alignment.center, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.labelText,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: (errorText != '' ||
                                (widget.error != null && widget.error != ''))
                            ? AppColors.Red
                            : Colors.black),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  widget.type == TextFieldType.autocomplete
                      ? TypeAheadFormField(
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              errorText = 'Vui lòng chọn thông tin thích hợp';
                              return '';
                            }
                            errorText = '';
                            return null;
                          },
                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: widget.controller,
                              style: const TextStyle(fontSize: 18),
                              focusNode: unitCodeCtrlFocusNode,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 0))),
                          itemBuilder: (BuildContext context, String itemData) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Text(
                                itemData,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          },
                          onSuggestionSelected: (String suggestion) =>
                              widget.onSuggestionSelected?.call(suggestion),
                          suggestionsCallback: (pattern) async {
                            return widget.items!.where(
                                (element) => element.toLowerCase().contains(
                                      pattern.toLowerCase(),
                                    ));
                          },
                        )
                      : TextFormField(
                          controller: widget.controller,
                          focusNode: unitCodeCtrlFocusNode,
                          obscureText: widget.type == TextFieldType.password
                              ? _obscureText
                              : false,
                          obscuringCharacter: '*',
                          onChanged: (value) {
                            if (widget.type != TextFieldType.name) return;
                            final controller = widget.controller;
                            controller.value = TextEditingValue(
                                text: formatedName(value),
                                selection: controller.selection);
                          },
                          enabled: (widget.type != TextFieldType.date),
                          style: const TextStyle(fontSize: 18),
                          maxLength: widget.maxLength,
                          validator: ((value) =>
                              getValidator(value, widget.type)),
                          decoration: const InputDecoration(
                              isDense: true,
                              errorStyle: TextStyle(height: 0),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              counterText: ''),
                        ),
                ],
              ),
              if (widget.type == TextFieldType.password)
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
              else if (widget.type == TextFieldType.date ||
                  widget.type == TextFieldType.autocomplete)
                Positioned(
                    right: 0,
                    child: Image.asset(
                      'assets/dropdown.png',
                      width: 7.18,
                    ))
            ]),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        if ((widget.error != null && widget.error! != '') ||
            errorText.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: Text(
              (widget.error != null && widget.error! != '')
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
