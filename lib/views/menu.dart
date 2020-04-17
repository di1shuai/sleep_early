import 'package:flutter/material.dart';
import 'package:shutdown_platform/shutdown_platform.dart';

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
          child: new Text('Shutdown'),
          onPressed: () async {
            // Navigator.pop(context);
            await ShutdownPlatform.shutdownNow;
          },
        ),
      ),
    );
  }
}
