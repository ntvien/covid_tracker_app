import 'package:covid_tracker_app/datascore.dart';
import 'package:covid_tracker_app/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Circular", primaryColor: primaryBlack),
      home: HomePage(),
    );
  }
}
