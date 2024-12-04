import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final dynamic country;

  DetailScreen({required this.country});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isSaved = false;

  Future<void> checkIfSaved() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedCountries = prefs.getStringList('savedCountries') ?? [];

    for (var countryJson in savedCountries) {
      var savedCountry = json.decode(countryJson);
      if (savedCountry['name']['common'] == widget.country['name']['common']) {
        setState(() {
          isSaved = true;
        });
        break;
      }
    }
  }


  Future<void> saveCountry() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedCountries = prefs.getStringList('savedCountries') ?? [];


    for (var countryJson in savedCountries) {
      var savedCountry = json.decode(countryJson);
      if (savedCountry['name']['common'] == widget.country['name']['common']) {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Country is already saved')));
        return;
      }
    }

    savedCountries.add(json.encode(widget.country));
    await prefs.setStringList('savedCountries', savedCountries);
    setState(() {
      isSaved = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Country Saved')));
  }

  Future<void> removeCountry() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedCountries = prefs.getStringList('savedCountries') ?? [];

    savedCountries.removeWhere((countryJson) => json.decode(countryJson)['name']['common'] == widget.country['name']['common']);
    await prefs.setStringList('savedCountries', savedCountries);
    setState(() {
      isSaved = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Country Removed')));
  }

  @override
  void initState() {
    super.initState();
    checkIfSaved();
  }

  @override
  Widget build(BuildContext context) {
    final country = widget.country;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          country['name']['common'],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(
              isSaved ? Icons.favorite : Icons.favorite_border,
              color: isSaved ? Colors.red : Colors.white,
            ),
            onPressed: () {
              if (isSaved) {
                removeCountry();
              } else {
                saveCountry();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  country['flags']['png'],
                  height: 150,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${country['name']['common']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Region: ${country['region']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            Text(
              'Population: ${country['population']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            Text(
              'Capital: ${country['capital']?.join(', ') ?? 'N/A'}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
