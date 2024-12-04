import 'package:advance_flutter_exam/model/country.dart';
import 'package:advance_flutter_exam/provider/country_provider.dart';
import 'package:advance_flutter_exam/screens/country_card.dart';
import 'package:advance_flutter_exam/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:advance_flutter_exam/screens/home_screen.dart';
import 'package:advance_flutter_exam/screens/saved_countries_page.dart';
import 'package:advance_flutter_exam/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CountryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'SplashScreen',
        routes: {
          '/': (context) => HomeScreen(),
          'SavedCountriesPage': (context) => SavedCountriesPage(),
          'SplashScreen': (context) => SplashScreen(),
          'DetailScreen': (context) => DetailScreen(country: ModalRoute.of(context)!.settings.arguments as Map,),
        },
      ),
    );
  }
}
