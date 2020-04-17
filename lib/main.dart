import 'package:flutter/material.dart';
import 'views/home.dart';
import 'package:sleep_early/demo/native.dart';

void main() => runApp(SleepEarly());

class SleepEarly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleep Early',
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
    // return new Power();
    // return NativeApp();
  }
}
