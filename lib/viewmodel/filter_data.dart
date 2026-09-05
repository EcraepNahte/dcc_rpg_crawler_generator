import 'package:flutter/material.dart';

class FilterData extends ChangeNotifier {
  int _genderOption = 3;

  int get genderOption => _genderOption;

  void setGender(int? value) {
    if (value == null) {
      _genderOption = 3;
    } else {
      _genderOption = value;
      notifyListeners();
    }
  }

  String queryParams() {
    String params = '?';

    if (genderOption == 1) {
      params += 'gender=male&';
    } else if (genderOption == 2) {
      params += 'gender=female&';
    }

    return params;
  }
}
