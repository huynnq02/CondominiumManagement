import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String content) {
  final size = MediaQuery.of(context).size;

  Flushbar(
    maxWidth: size.width * .8,
    borderRadius: BorderRadius.circular(10),
    backgroundColor: const Color(0xFFDB2F68),
    flushbarPosition: FlushbarPosition.BOTTOM,
    messageColor: Colors.white,
    messageSize: 16,
    message: content,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    duration: const Duration(seconds: 3),
  ).show(context);
}
