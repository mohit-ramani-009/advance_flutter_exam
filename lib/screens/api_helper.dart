import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/country.dart';

class ApiHelper {
  static const String _url = 'https://restcountries.com/v3.1/all';

  static Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  static Future<List<Country>> fetchIndependentCountries() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .where((country) => country['independent'] == true)
          .map((json) => Country.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
