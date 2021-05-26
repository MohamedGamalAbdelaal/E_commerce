import 'package:flutter/cupertino.dart';

class ModelProgress extends ChangeNotifier {
  bool isloading = false;
  changeloading(bool value) {
    isloading = value;
    notifyListeners();
  }
}
