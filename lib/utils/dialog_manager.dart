import 'package:flutter/material.dart';
import 'package:foxfund_alpha/core/model/dialog_model.dart';
import 'package:foxfund_alpha/ui/widgets/custom_text_widget.dart';

import '../locator.dart';
import '../ui/styles/styles.dart';
import 'dialog_service.dart';

class DialogManager extends StatefulWidget {
  const DialogManager({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) => widget.child;

  void _showDialog(DialogRequest request) {
    final bool isConfirmationDialog = request.cancelTitle != null;
    final bool isFunction = request.onOkayClicked != null;
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: CustomText(request.title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: request.title.contains('Error') ? Styles.redColor : Styles.colorBlack),
        content: CustomText(request.description,
            fontSize: 14, fontWeight: FontWeight.w600, color: Styles.colorGrey),
        actions: <Widget>[
          if (isConfirmationDialog)
            GestureDetector(
              onTap: () => _dialogService.dialogComplete(DialogResponse(confirmed: false)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: CustomText(request.cancelTitle,
                    fontSize: 12,
                    color: Styles.colorBlack,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500),
              ),
            ),
          GestureDetector(
            onTap: isFunction
                ? () => request.onOkayClicked()
                : () => _dialogService.dialogComplete(DialogResponse(confirmed: true)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Styles.colorPurple),
              child: CustomText(request.buttonTitle,
                  fontSize: 12, letterSpacing: 1, color: Colors.white60, fontWeight: FontWeight.w600),
            ),
          )
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
