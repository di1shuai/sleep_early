import 'package:flutter/material.dart';
import 'package:shutdown_platform/shutdown_platform.dart';
import 'package:sleep_early/demo/device_id.dart';
import 'package:sleep_early/demo/device_info.dart';
import 'package:sleep_early/demo/http_demo.dart';
import 'package:sleep_early/demo/key_demo.dart';
import 'package:sleep_early/demo/permission_demo.dart';
import 'package:sleep_early/demo/provider_account.dart';
import 'package:sleep_early/demo/provider_demo.dart';
import 'package:sleep_early/demo/text_demo.dart';
import 'package:sleep_early/demo/text_demo2.dart';
import 'package:sleep_early/widgets/device_dialog.dart';

class DemoRoute extends StatefulWidget {
  @override
  _Menu createState() => new _Menu();
}

class _Menu extends State<DemoRoute> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Demo'),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('Shutdown'),
            onTap: () async {
              // Navigator.pop(context);
              await ShutdownPlatform.shutdownNow;
            },
          ),
          new ListTile(
            title: new Text('DeviceInfo'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new DeviceInfoPage()),
              );
            },
          ),
          new ListTile(
            title: new Text('DeviceId'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new DeviceIdPage()),
              );
            },
          ),
          new ListTile(
            title: new Text('Permission'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new PermissionPage()),
              );
            },
          ),
          new ListTile(
            title: new Text('text input '),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new TextPage()),
              );
            },
          ),
          new ListTile(
            title: new Text('provider'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new ProviderApp()),
              );
            },
          ),
          new ListTile(
            title: new Text('provider account'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new ProviderAccountAPP()),
              );
            },
          ),
          new ListTile(
            title: new Text('http'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new HttpApp()),
              );
            },
          ),
          new ListTile(
            title: new Text('key '),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new KeyPage()),
              );
            },
          ),
          new ListTile(
            title: new Text('text input 2'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new FocusTestRoute()),
              );
            },
          ),
          new ListTile(
            title: new Text('pop dailog'),
            onTap: () async {
              bool data = await showCreateDialog(context);
              if (data == null) {
                print("取消绑定");
              } else {
                print("确认绑定");
                //... 绑定
                // http post json
                print(data);
              }
            },
          ),
        ],
      ),
    );
  }
}
