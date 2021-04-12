import 'package:flutter/material.dart';
import 'package:foxfund_alpha/utils/dialog_service.dart';
import 'package:foxfund_alpha/utils/navigator.dart';

import '../../locator.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  DialogService dialog = locator<DialogService>();
  NavigationService navigate = locator<NavigationService>();

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
