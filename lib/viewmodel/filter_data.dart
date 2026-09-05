import 'package:flutter/material.dart';

class FilterData extends ChangeNotifier {
  int _genderOption = 3;
  final Map<String, bool> _nationalities = {
    'AU': true,
    'BR': true,
    'CA': true,
    'CH': true,
    'DE': true,
    'DK': true,
    'ES': true,
    'FI': true,
    'FR': true,
    'GB': true,
    'IE': true,
    'IN': true,
    'IR': false,
    'MX': true,
    'NL': true,
    'NO': true,
    'NZ': true,
    'RS': true,
    'TR': true,
    'UA': true,
    'US': true,
  };

  int get genderOption => _genderOption;
  Map<String, bool> get nationalities => _nationalities;
  bool get allChecked {
    for (var nationality in _nationalities.entries) {
      if (nationality.value == false) {
        return false;
      }
    }
    return true;
  }

  void setGender(int? value) {
    if (value == null) {
      _genderOption = 3;
    } else {
      _genderOption = value;
      notifyListeners();
    }
  }

  void toggleAllChecked() {
    if (allChecked) {
      _nationalities.updateAll((_, _) => false);
    } else {
      _nationalities.updateAll((_, _) => true);
    }
  }

  String queryParams() {
    String params = '?';

    if (genderOption == 1) {
      params += 'gender=male&';
    } else if (genderOption == 2) {
      params += 'gender=female&';
    }

    List<String> checked = [];

    _nationalities.forEach((name, value) {
      if (value) {
        checked.add(name);
      }
    });

    if (checked.isNotEmpty) {
      params += 'nat=';
      for (String nat in checked) {
        params += '$nat,';
      }
    }

    return params;
  }
}
