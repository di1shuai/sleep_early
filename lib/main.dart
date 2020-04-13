import 'package:flutter/material.dart';
import 'package:sleep_early/demo/device_info.dart';
import 'package:sleep_early/demo/restart.dart';
import 'pages/home.dart';
import 'package:sleep_early/demo/native.dart';
import 'package:sleep_early/demo/power.dart';

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
    // return new Power();
    // return NativeApp();
  }
}
