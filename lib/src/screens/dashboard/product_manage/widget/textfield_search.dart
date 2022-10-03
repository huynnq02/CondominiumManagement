import 'package:flutter/material.dart';
import '../../../../../utils/app_constant/app_colors.dart';

class TextFieldSearch extends StatefulWidget {
  final valueText;
  TextFieldSearch({Key? key, required this.valueText}) : super(key: key);

  @override
  State<TextFieldSearch> createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  final searchController = TextEditingController();

  String? valueText;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 45,
        child: TextField(
          onChanged: ((value) {
            setState(() {
              valueText = value;
              widget.valueText(valueText);
            });
          }),
          controller: searchController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.Blue,
                width: 1,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.Blue, width: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
