import 'package:flutter/foundation.dart';

class FavoriteProvider with ChangeNotifier {
  List<int> _selectedIndex = [];

  List<int> get selectedIndex => _selectedIndex;

  void addIndex(int value) {
    if (_selectedIndex.contains(value)) {
      _selectedIndex.remove(value);
      notifyListeners();
    } else {
      _selectedIndex.add(value);
      notifyListeners();
    }
  }
}
