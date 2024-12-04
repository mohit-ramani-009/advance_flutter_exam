import 'package:flutter/material.dart';
import 'package:advance_flutter_exam/screens/detail_screen.dart';
import '../model/country.dart';

class CountryCard extends StatefulWidget {
  final Country country;

  CountryCard({required this.country});

  @override
  _CountryCardState createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
  @override
  Widget build(BuildContext context) {
    final country = widget.country;

    return ListTile(
      leading: Image.network(country.flagUrl),
      title: Text(country.name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(country: country),
          ),
        );
      },
    );
  }
}
