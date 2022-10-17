import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../../utils/app_constant/app_colors.dart';

enum TextFieldType { email, password, number, date, name }

class RegisterTextField extends StatefulWidget {
  final String labelText;
  final TextFieldType? type;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final AutovalidateMode? autovalidateMode;
  final bool? isCenter;
  final BorderRadiusGeometry? border;

  const RegisterTextField(
      {Key? key,
      required this.labelText,
      this.type,
      this.validator,
      this.controller,
      this.maxLength,
      this.autovalidateMode,
      this.isCenter,
      this.border})
      : super(key: key);

  @override
  State<RegisterTextField> createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  bool _obscureText = true;
  DateTime selectedDate = DateTime.now();
  final GlobalKey _textformfieldkey = GlobalKey();
  double? width;
  double? height;

  @override
  void initState() {
    super.initState();
  }

  String getDateString(DateTime date) => DateFormat('d/M/yyyy').format(date);

  Future<void> _selectDate(BuildContext context) async {
    if (!(widget.type == TextFieldType.date)) {
      return;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.controller?.text = getDateString(selectedDate);
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8), borderRadius: widget.border),
        child: Stack(alignment: Alignment.center, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.yellow,
                child: Text(
                  widget.labelText,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                // color: Colors.red,
                child: TextFormField(
                  key: _textformfieldkey,
                  autovalidateMode: widget.autovalidateMode ??
                      AutovalidateMode.onUserInteraction,
                  validator: widget.validator != null
                      ? (value) => widget.validator!(value)
                      : null,
                  controller: widget.controller,
                  enabled: !(widget.type == TextFieldType.date),
                  textAlign:
                      (widget.isCenter != null && widget.isCenter == true)
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
                    floatingLabelAlignment:
                        (widget.isCenter != null && widget.isCenter == true)
                            ? FloatingLabelAlignment.center
                            : FloatingLabelAlignment.start,
                    contentPadding: widget.type != TextFieldType.date
                        ? const EdgeInsets.symmetric(horizontal: 10)
                        : EdgeInsets.zero,
                    // suffixIcon: widget.type == TextFieldType.password
                    //     ? GestureDetector(
                    //       onTap: _toggle,
                    //       child: _obscureText == true
                    //           ? SvgPicture.asset(
                    //               'assets/eye.svg',
                    //               width: 17,
                    //               height: 17,
                    //             )
                    //           : const Icon(
                    //               Icons.visibility_off,
                    //               size: 20,
                    //               color: AppColors.Black,
                    //             ),
                    //     )
                    //     : null,
                  ),
                ),
              ),
            ],
          ),
          if (widget.type == TextFieldType.date)
            Positioned(
                right: 0,
                child: Image.asset(
                  'assets/dropdown.png',
                  width: 7.18,
                ))
          else if (widget.type == TextFieldType.password)
            Positioned(
              right: 0,
              bottom: 0,
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
        ]),
      ),
    );
  }
}
