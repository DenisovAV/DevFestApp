import 'package:devfest_flutter_app/material/navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'DevFest Georky 2018',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainNavigation()
    );
  }
}

