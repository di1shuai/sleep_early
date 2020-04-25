import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShardPreferenceDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("ShardPreferenceDemo"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: _incrementCounter,
            child: Text('Increment Counter'),
          ),
          RaisedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
            },
            child: Text('clear ALL'),
          ),
          RaisedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              print(prefs.getString("profile"));
            },
            child: Text('get profile'),
          ),RaisedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
            },
            child: Text('clear ALL'),
          ),
        ],
      )),
    );
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  }



}
