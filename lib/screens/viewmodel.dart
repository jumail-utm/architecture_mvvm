import 'package:flutter/foundation.dart';

class Viewmodel with ChangeNotifier {
  bool _busy = false;

  get busy => _busy;
  void turnToBusy() => _busy = true;
  void turnIdle() {
    _busy = false;
    notifyListeners();
  }
}
