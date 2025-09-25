import 'package:flutter/foundation.dart';

class ExpandableTextProvider extends ChangeNotifier {
  bool _expanded = false;
  bool get expanded => _expanded;

  void toggle() {
    _expanded = !_expanded;
    notifyListeners();
  }
}
