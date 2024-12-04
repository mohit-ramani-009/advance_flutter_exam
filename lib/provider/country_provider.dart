import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryProvider with ChangeNotifier {
  List<dynamic> countries = [];
  bool isLoading = true;
  String? errorMessage;

  Future<void> fetchCountries({bool independentOnly = false}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List<dynamic> allCountries = json.decode(response.body);
      countries = independentOnly
          ? allCountries.where((country) => country['independent'] == true).toList()
          : allCountries;
      isLoading = false;
      notifyListeners();
    } else {
      errorMessage = 'Failed to load countries';
      isLoading = false;
      notifyListeners();
    }
  }
}
