import 'dart:async';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';

class DeviceIdPage extends StatefulWidget {
  @override
  _DeviceIdPageState createState() => _DeviceIdPageState();
}

class _DeviceIdPageState extends State<DeviceIdPage> {
  String _deviceId = '';
  String _platform = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String deviceId = await PlatformDeviceId.getDeviceId;
    String platform = Platform.operatingSystem;
    try {
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
      } else if (Platform.isMacOS) {
      } else if (Platform.isWindows) {
      } else if (Platform.isLinux) {
      } else {
        platform = 'unknow';
      }
    } on PlatformException {

    }
    setState(() {
      _deviceId = deviceId;
      _platform = platform;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_platform + ' Device Info'),
        ),
        body: new Center(
          child: Text(_deviceId),
        ),
      ),
    );
  }
}
