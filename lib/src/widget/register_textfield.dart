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

  const RegisterTextField(
      {Key? key,
      required this.labelText,
      this.type,
      this.validator,
      this.controller,
      this.maxLength,
      this.autovalidateMode,
      this.isCenter})
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
    WidgetsBinding.instance.addPostFrameCallback((_) => getSize());
  }

  getSize() {
    RenderBox _cardBox =
        _textformfieldkey.currentContext?.findRenderObject() as RenderBox;
    final inputSize = _cardBox.size;
    width = inputSize.width;
    height = inputSize.height;
    setState(() {});
  }

  String getDateString(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

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
      child: Stack(children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(56),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.black.withOpacity(0.56)),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        TextFormField(
          key: _textformfieldkey,
          autovalidateMode:
              widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
          validator: widget.validator != null
              ? (value) => widget.validator!(value)
              : null,
          controller: widget.controller,
          enabled: !(widget.type == TextFieldType.date),
          textAlign: (widget.isCenter != null && widget.isCenter == true)
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
          obscureText:
              widget.type == TextFieldType.password ? _obscureText : false,
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
                  text: formatedName(value), selection: controller.selection);
            }
          },
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: widget.labelText,
            labelStyle: const TextStyle(
              color: Color.fromRGBO(99, 99, 99, 1),
            ),
            floatingLabelAlignment:
                (widget.isCenter != null && widget.isCenter == true)
                    ? FloatingLabelAlignment.center
                    : FloatingLabelAlignment.start,
            contentPadding: widget.type == TextFieldType.date
                ? const EdgeInsets.only(top: 10.5,bottom: 10.5,left: 24)
                : const EdgeInsets.symmetric(vertical: 10.5, horizontal: 24),
            suffixIcon: widget.type == TextFieldType.password
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 14, bottom: 14, right: 17),
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
                : widget.type == TextFieldType.date
                    ? Image.asset(
                        'assets/dropdown.png',
                        width: 7.18,
                      )
                    : null,
          ),
        )
      ]),
    );
  }
}
