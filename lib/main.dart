import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kawalkorona/HomePage.dart';

main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Kawal Covid-19',
      home: HomePage(),
    );
  }
}
