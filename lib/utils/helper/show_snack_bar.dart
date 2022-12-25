import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String content) {
  final size = MediaQuery.of(context).size;

  Flushbar(
    maxWidth: size.width * .8,
    borderRadius: BorderRadius.circular(10),
    backgroundColor: const Color.fromARGB(225, 59, 56, 56),
    flushbarPosition: FlushbarPosition.BOTTOM,
    messageColor: Colors.white,
    messageSize: 16,
    message: content,
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    duration: const Duration(seconds: 5),
    margin: const EdgeInsets.only(bottom: 72),
    animationDuration: const Duration(milliseconds: 800),
  ).show(context);
}
