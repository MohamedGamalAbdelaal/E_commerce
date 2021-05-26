import 'package:flutter/foundation.dart';

class AdminMode extends ChangeNotifier {
  bool isadmin = false;
  changeAdmin(bool value) {
    isadmin = value;
    notifyListeners();
  }
}
