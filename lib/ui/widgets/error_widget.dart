import 'package:flutter/material.dart';
import 'package:foxfund_alpha/ui/styles/spacing.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';
import 'package:foxfund_alpha/ui/widgets/size_calculator.dart';

class ErrorOccurredWidget extends StatelessWidget {
  const ErrorOccurredWidget({Key key, this.error = 'An error occurred'}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
            Icon(Icons.error, size: screenAwareSize(40, context), color: Colors.red),
          verticalSpaceSmall,
          CustomText(error?? '',
            centerText: true,
             fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red)
        ],
      ),
    ));
  }
}
