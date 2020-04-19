import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class DeviceId {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> get getDeviceId  async {
    String deviceId;
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      } else if (Platform.isMacOS) {
        deviceId = '';
      } else if (Platform.isWindows) {
        deviceId = '';
      } else if (Platform.isLinux) {
        deviceId = '';
      } else {
        deviceId = '';
      }
    } on PlatformException {
      deviceId = '';
    }
    return deviceId;
  }

}