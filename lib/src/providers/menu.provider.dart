import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  bool _display = true;
  int _selectedItem = 0;
  Color _backgroundColor = Colors.white;
  Color _activeColor = Colors.black;
  Color _secondaryColor = Colors.blueGrey;

  // Getters
  bool get display => this._display;
  int get selectedItem => this._selectedItem;
  Color get backgroundColor => this._backgroundColor;
  Color get activeColor => this._activeColor;
  Color get secondaryColor => this._secondaryColor;

  // Setters
  set display(bool display) {
    this._display = display;
    notifyListeners();
  }

  set selectedItem(int index) {
    this._selectedItem = index;
    notifyListeners();
  }

  set backgroundColor(Color color) {
    this._backgroundColor = color;
    notifyListeners();
  }

  set activeColor(Color color) {
    this._activeColor = color;
    notifyListeners();
  }

  set secondaryColor(Color color) {
    this._secondaryColor = color;
    notifyListeners();
  }
}
