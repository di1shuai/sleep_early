import 'package:flutter/material.dart';
import 'package:shutdown_platform/shutdown_platform.dart';
import 'package:sleep_early/api/device_api.dart';
import 'package:sleep_early/demo/cron_demo.dart';
import 'package:sleep_early/demo/device_id.dart';
import 'package:sleep_early/demo/device_info.dart';
import 'package:sleep_early/demo/future_list_demo.dart';
import 'package:sleep_early/demo/http_demo.dart';
import 'package:sleep_early/demo/key_demo.dart';
import 'package:sleep_early/demo/listview_demo.dart';
import 'package:sleep_early/demo/markdown_demo.dart';
import 'package:sleep_early/demo/permission_demo.dart';
import 'package:sleep_early/demo/provider_account.dart';
import 'package:sleep_early/demo/provider_demo.dart';
import 'package:sleep_early/demo/shard_preference_demo.dart';
import 'package:sleep_early/demo/svg_demo.dart';
import 'package:sleep_early/demo/text_demo.dart';
import 'package:sleep_early/demo/text_demo2.dart';
import 'package:sleep_early/demo/time_demo.dart';
import 'package:sleep_early/models/device.dart';
import 'package:sleep_early/demo/login.dart';
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
            title: new Text('MarkDemo'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new MarkdownDemo()),
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
            title: new Text('future list '),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new FutureListDemo()),
              );
            },
          ),
          new ListTile(
            title: new Text('future list go '),
            onTap: () async {
              List<Device> data = await DeviceAPI.getDeviceByAccountId(1);
              for (Device device in data) {
                print(device);
              }
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
            title: new Text('timer'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new TimerDemo()),
              );
            },
          ),
          new ListTile(
            title: new Text('provider account'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ProviderAccountAPP()),
              );
            },
          ),
          new ListTile(
            title: new Text('cron demo'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new CronDemo()),
              );
            },
          ),
          new ListTile(
            title: new Text('ShardPreference demo'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ShardPreferenceDemo()),
              );
            },
          ),
          new ListTile(
            title: new Text('List View demo'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ListViewDemoApp()),
              );
            },
          ),
          new ListTile(
            title: new Text('Login'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Login()),
              );
            },
          ),
          new ListTile(
            title: new Text('svg'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new SVGDemo()),
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
