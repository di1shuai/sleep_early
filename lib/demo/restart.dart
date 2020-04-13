import 'package:flutter/material.dart';


class RestartApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.white),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(child: RestartWidget()),
      ),
    );
  }
}

///这个组件用来重新加载整个child Widget的。当我们需要重启APP的时候，可以使用这个方案
///https://stackoverflow.com/questions/50115311/flutter-how-to-force-an-application-restart-in-production-mode
class RestartWidget extends StatefulWidget {
  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  void shatdown() {
    print('要关机辣');
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.access_alarm),
      onPressed: shatdown,
    );
  }
}


