import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:advance_flutter_exam/screens/detail_screen.dart';
import '../provider/country_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<CountryProvider>(context, listen: false).fetchCountries(independentOnly: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Countries',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              Navigator.pushNamed(context, 'SavedCountriesPage');
            },
          ),
        ],
      ),
      body: countryProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : countryProvider.errorMessage != null
          ? Center(child: Text(countryProvider.errorMessage!))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: countryProvider.countries.length,
          itemBuilder: (context, index) {
            var country = countryProvider.countries[index];

            return Card(
              color: Colors.blueAccent.withOpacity(0.5),
              margin: EdgeInsets.only(bottom: 16.0),
              elevation: 2,
              shadowColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    country['flags']['png'],
                    width: 50,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  country['name']['common'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(country: country),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
