import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../utils/app_constant/app_colors.dart';

enum TextFieldType { email, password, number, date }

class RegisterTextField extends StatefulWidget {
  final String labelText;
  final TextFieldType? type;

  const RegisterTextField({Key? key, required this.labelText, this.type})
      : super(key: key);

  @override
  State<RegisterTextField> createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  bool _obscureText = true;
  TextEditingController? controller;
  DateTime selectedDate = DateTime.now();
  final GlobalKey _textformfieldkey = GlobalKey();
  double? width;
  double? height;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSize());
    controller = TextEditingController(text: getDateString(selectedDate));
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
        controller?.text = getDateString(selectedDate);
      });
    }
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
            color:const Color(0xFFFAFAFA),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(56),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        TextFormField(
          key: _textformfieldkey,
          controller: widget.type == TextFieldType.date ? controller : null,
          enabled: !(widget.type == TextFieldType.date),
          keyboardType: widget.type == TextFieldType.email
              ? TextInputType.emailAddress
              : widget.type == TextFieldType.number
                  ? TextInputType.number
                  : TextInputType.text,
          obscureText:
              widget.type == TextFieldType.password ? _obscureText : false,
          obscuringCharacter: '*',
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.56))),
            labelText: widget.labelText,
            labelStyle: const TextStyle(
              color: Color.fromRGBO(99, 99, 99, 1),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.5, horizontal: 24),
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
