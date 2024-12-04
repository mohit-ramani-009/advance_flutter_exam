
import 'dart:convert';

class Country {
  final String name;
  final String region;
  final int population;
  final String capital;
  final String flagUrl;

  Country({
    required this.name,
    required this.region,
    required this.population,
    required this.capital,
    required this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      region: json['region'],
      population: json['population'],
      capital: (json['capital'] != null && json['capital'].isNotEmpty)
          ? json['capital'][0]
          : 'N/A',
      flagUrl: json['flags']['png'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': {'common': name},
      'region': region,
      'population': population,
      'capital': capital,
      'flags': {'png': flagUrl},
    };
  }
}
