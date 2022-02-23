import 'package:flutter/material.dart';

import 'helpers/app_constants.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kSecondaryColor,
        primaryColor: kPrimaryColor,
        fontFamily: 'Quicksand-Variable',
      ),
      home: const HomePage(),
    );
  }
}
