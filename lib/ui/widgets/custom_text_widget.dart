import 'package:flutter/material.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.text,
      {Key key,
      this.fontSize,
      this.fontWeight,
      this.centerText = false,
      this.color,
      this.leftMargin = 0.0,
      this.topMargin = 0.0,
      this.rightMargin = 0.0,
      this.bottomMargin = 0.0,
      this.letterSpacing,
      this.fontFamily,
      this.maxLines, this.textOverflow})
      : super(key: key);
  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double leftMargin;
  final double letterSpacing;
  final double topMargin;
  final double rightMargin;
  final int maxLines;
  final TextOverflow textOverflow;
  final double bottomMargin;
  final bool centerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(leftMargin, topMargin, rightMargin, bottomMargin),
      child: Text(
        text,
        maxLines: maxLines,
        overflow: textOverflow,
        textAlign: centerText ? TextAlign.center : null,
        style: GoogleFonts.nunito(
            letterSpacing: letterSpacing,
            fontSize: screenAwareSize(fontSize, context, width: true),
            fontWeight: fontWeight,
            color: color),
      ),
    );
  }
}
