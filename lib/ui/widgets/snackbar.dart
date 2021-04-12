import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String title, String msg, {int duration = 6}) {
  Flushbar<void>(
    title: title,
    message: msg,
    margin: const EdgeInsets.all(8),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: duration),
    borderRadius: 8,
    backgroundColor: title == 'Error' ? Colors.red : Colors.blue,
  ).show(context);
}
