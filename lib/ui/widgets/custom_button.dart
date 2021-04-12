import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';

import 'custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key key,
      this.height,
      this.width,
      this.onPressed,
      this.busy = false,
      this.textColor = Colors.white,
      this.buttonColor = const Color(0xff00156B),
      this.title,
      this.fontSize})
      : super(key: key);
  final double height;
  final double width;
  final Function() onPressed;
  final bool busy;
  final Color textColor;

  final Color buttonColor;
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: busy ? null : onPressed,
      child: Container(
        height: screenAwareSize(height, context),
        width: width,
        decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 5.0,
              color: Color(0x20000000),
              spreadRadius: 0.0,
              offset: Offset(3.5, 5.0),
            ),
          ],
          color: busy ? buttonColor.withOpacity(0.5) : buttonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (busy)
              Platform.isIOS
                  ? const CupertinoActivityIndicator(radius: 12)
                  : const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
            else
              CustomText(title,
                  letterSpacing: 0.5,
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700),
          ],
        ),
      ),
    );
  }
}
