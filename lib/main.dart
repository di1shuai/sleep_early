import 'package:flutter/material.dart';
import 'pages/home.dart';


void main() => runApp(SleepEarly());

class SleepEarly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleep Early',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }
}
