import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _Menu createState() => new _Menu();
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Second Screen'),
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('Go back!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
