import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final String labelText;
  final void Function()? onPressed;
  const WidgetButton({Key? key, required this.labelText, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4)
        ]),
        child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            onPressed: onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              child: Text(
                labelText,
                style: TextStyle(fontSize: 16),
              ),
            )),
      ),
    );
  }
}
