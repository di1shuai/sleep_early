import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleep_early/models/profile.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  static String deviceId;

  static const String refreshCronStr = "*/1 * * * *";

  static Cron shutdownCron= new Cron();

  static Cron refreshCron= new Cron();

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    print("===== init start ======");
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(_profile);
        print("profile -> $profile");
      } catch (e) {
        print(e);
      }
    }
    deviceId = await PlatformDeviceId.getDeviceId;
    print("deviceId -> " +deviceId);
    print("===== init end ======");
  }

  // 持久化Profile信息
  static saveProfile() => _prefs.setString("profile", profile.toJson());
}


