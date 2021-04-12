import 'package:flutter/cupertino.dart';
abstract class Util {
  static bool isValidPhone(String phone) {
    return phone != null && phone.length == 11 && phone.startsWith('0');
  }

  static bool isValidOtp(String num) {
    return num != null && num.length == 6;
  }

  static String isValidPassword(String password) {
    final RegExp weakRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$');
    final RegExp strongRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final RegExp fairRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return 'Enter password';
    } else {
      if (!weakRegex.hasMatch(password)) {
        return 'Weak Password';
      }
      if (!fairRegex.hasMatch(password)) {
        return 'Fair Password';
      }
      if (!strongRegex.hasMatch(password)) {
        return 'Nearly there...';
      } else
        return null;
    }
  }

  static String isValidName(String value) {
    if (value.isEmpty) {
      return 'Field cannot be Empty!';
    }
    return null;
  }

  static String validateEmail(String value) {
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value)) {
      return 'Enter valid email';
    } else if (value.isEmpty) {
      return 'Enter your email!';
    } else
      return null;
  }

  static void offKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      return;
    }
    currentFocus.unfocus();
  }

}
