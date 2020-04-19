import 'package:flutter/material.dart';
import 'package:shutdown_platform/shutdown_platform.dart';
import 'package:sleep_early/demo/device_id.dart';
import 'package:sleep_early/demo/device_info.dart';
import 'package:sleep_early/demo/permission_demo.dart';

class Menu extends StatefulWidget {
  @override
  _Menu createState() => new _Menu();
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Menu'),
        ),
        body: new Center(
            child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: new RaisedButton(
                color: Theme.of(context).buttonColor,
                child: new Text('Shutdown'),
                onPressed: () async {
                  // Navigator.pop(context);
                  await ShutdownPlatform.shutdownNow;
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: new RaisedButton(
                color: Theme.of(context).buttonColor,
                child: new Text('DeviceInfo'),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DeviceInfoPage()),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: new RaisedButton(
                color: Theme.of(context).buttonColor,
                child: new Text('DeviceId'),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DeviceIdPage()),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: new RaisedButton(
                color: Theme.of(context).buttonColor,
                child: new Text('Permission'),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new PermissionPage()),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: new Text('占位'),
            )
          ],
        )));
  }
}
