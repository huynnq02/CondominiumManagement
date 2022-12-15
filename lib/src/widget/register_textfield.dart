import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../utils/app_constant/app_colors.dart';

enum TextFieldType { email, password, number, date, name, autocomplete }

class RegisterTextField extends StatefulWidget {
  final String labelText;
  final TextFieldType? type;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final AutovalidateMode? autovalidateMode;
  final bool? isCenter;
  final BorderRadiusGeometry? border;
  final bool isDisabled;
  final void Function(BuildContext context)? onTap;
  final bool? pwRule;
  final bool? showPw;
  final String? error;
  final List<String>? items;
  final dynamic Function(String)? onSuggestionSelected;
  final bool? borderColor;

  const RegisterTextField(
      {Key? key,
      required this.labelText,
      this.type,
      this.validator,
      this.controller,
      this.maxLength,
      this.autovalidateMode,
      this.isCenter,
      this.border = BorderRadius.zero,
      this.isDisabled = false,
      this.onTap,
      this.pwRule,
      this.showPw,
      this.error,
      this.items,
      this.onSuggestionSelected,
      this.borderColor})
      : super(key: key);

  @override
  State<RegisterTextField> createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  bool _obscureText = true;
  final GlobalKey _textformfieldkey = GlobalKey();
  double? width;
  double? height;
  String errorText = '';
  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
            errorText = 'Vui lòng nhập hờ tên';
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

  void handleOnTap() {
    if (widget.onTap != null) widget.onTap!(context);
    unitCodeCtrlFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap,
      child: Stack(alignment: Alignment.center, children: [
        ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(borderRadius: widget.border!)),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              border: (errorText != '' ||
                      (widget.error != null && widget.error != ''))
                  ? Border.all(color: const Color(0xFFFF0000))
                  : widget.borderColor != null
                      ? null
                      : Border(
                          top:
                              BorderSide(color: Colors.black.withOpacity(0.2))),
              borderRadius: (errorText != '' ||
                      (widget.error != null && widget.error != ''))
                  ? widget.border
                  : null,
              color: Colors.white.withOpacity(0.8),
            ),
            child: Stack(alignment: Alignment.center, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.labelText,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
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
                                      EdgeInsets.symmetric(horizontal: 10))),
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
                          key: _textformfieldkey,
                          validator: ((value) =>
                              getValidator(value, widget.type)),
                          controller: widget.controller,
                          focusNode: unitCodeCtrlFocusNode,
                          enabled: (widget.type == TextFieldType.date)
                              ? false
                              : !widget.isDisabled,
                          textAlign: (widget.isCenter != null &&
                                  widget.isCenter == true)
                              ? TextAlign.center
                              : TextAlign.start,
                          textCapitalization: widget.type == TextFieldType.name
                              ? TextCapitalization.words
                              : TextCapitalization.none,
                          keyboardType: widget.type == TextFieldType.email
                              ? TextInputType.emailAddress
                              : widget.type == TextFieldType.number
                                  ? TextInputType.number
                                  : TextInputType.text,
                          obscureText: widget.type == TextFieldType.password
                              ? _obscureText
                              : false,
                          obscuringCharacter: '*',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(widget.maxLength),
                            if (widget.type == TextFieldType.number)
                              FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (widget.type != TextFieldType.name) return;
                            final controller = widget.controller;
                            if (controller != null) {
                              controller.value = TextEditingValue(
                                  text: formatedName(value),
                                  selection: controller.selection);
                            }
                          },
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            errorStyle: const TextStyle(height: 0),
                            floatingLabelAlignment: (widget.isCenter != null &&
                                    widget.isCenter == true)
                                ? FloatingLabelAlignment.center
                                : FloatingLabelAlignment.start,
                            contentPadding: widget.type != TextFieldType.date
                                ? const EdgeInsets.symmetric(horizontal: 10)
                                : EdgeInsets.zero,
                          ),
                        ),
                ],
              ),
              if (widget.type == TextFieldType.date ||
                  widget.type == TextFieldType.autocomplete)
                Positioned(
                    right: 0,
                    child: Image.asset(
                      'assets/dropdown.png',
                      width: 7.18,
                    ))
              else if (widget.type == TextFieldType.password &&
                  !(widget.showPw != null && !widget.showPw!))
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: _toggle,
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      size: 17,
                      color: AppColors.Black,
                    ),
                  ),
                )
            ]),
          ),
        ),
        Positioned(
            top: 3,
            child: Text(
                (widget.error != null && widget.error!.isNotEmpty)
                    ? widget.error!
                    : errorText,
                style: GoogleFonts.inter(
                    color: const Color(0xFFFF0000), fontSize: 8))),
      ]),
    );
  }
}