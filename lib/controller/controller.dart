import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RouteController with ChangeNotifier, DiagnosticableTreeMixin {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void changeRouteIndex(int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }
}
