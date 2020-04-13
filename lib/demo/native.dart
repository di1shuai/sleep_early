import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class NativeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
        fontFamily: 'Lato',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Doing Native Stuff!',
            style: TextStyle(
              color: Colors.teal,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: NativeStuff(),
      ),
    );
  }
}

class NativeStuff extends StatefulWidget {
  @override
  NativeStuffState createState() {
    return NativeStuffState();
  }
}

class NativeStuffState extends State<NativeStuff> {
  static const platformMethodChannel =
      const MethodChannel('heartbeat.fritz.ai/native');
  String nativeMessage = '';

  Future<Null> _managePower() async {
    String _message;
    try {
      final String result =
          await platformMethodChannel.invokeMethod('powerManage');
      _message = result;
    } on PlatformException catch (e) {
      _message = "Can't do native stuff ${e.message}.";
    }
    setState(() {
      nativeMessage = _message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 102.0),
            child: Center(
              child: FlatButton.icon(
                icon: Icon(
                  Icons.power_settings_new,
                  size: 100,
                ),
                label: Text(''),
                textColor: Colors.white,
                onPressed: _managePower,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 102.0),
            child: Center(
              child: Text(
                nativeMessage,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 23.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
