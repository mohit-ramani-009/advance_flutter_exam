import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedCountriesPage extends StatefulWidget {
  @override
  _SavedCountriesPageState createState() => _SavedCountriesPageState();
}

class _SavedCountriesPageState extends State<SavedCountriesPage> {
  Future<List<dynamic>> fetchSavedCountries() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedCountries = prefs.getStringList('savedCountries') ?? [];
    return savedCountries.map((countryJson) => json.decode(countryJson)).toList();
  }

  Future<void> removeCountry(dynamic country) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedCountries = prefs.getStringList('savedCountries') ?? [];
    savedCountries.removeWhere((item) => json.encode(country) == item);
    await prefs.setStringList('savedCountries', savedCountries);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text('Saved Countries'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchSavedCountries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var countries = snapshot.data ?? [];
          return countries.isEmpty
              ? Center(child: Text('No countries saved yet.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)))
              : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              var country = countries[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'DetailScreen', arguments: country);
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  elevation: 4.0,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        country['flags']['png'],
                        height: 40,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      country['name']['common'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await removeCountry(country);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Country Removed')));
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
