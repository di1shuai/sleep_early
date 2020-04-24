import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleep_early/api/api.dart';
import 'package:sleep_early/models/account.dart';
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

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    // _prefs = await SharedPreferences.getInstance();
    // var _profile = _prefs.getString("profile");
    // if (_profile != null) {
    //   try {
    //     profile = Profile.fromJson(_profile);
    //   } catch (e) {
    //     print(e);
    //   }
    // }
    deviceId = await PlatformDeviceId.getDeviceId;
    print("deviceId -> " +deviceId);
  }

  // 持久化Profile信息
  static saveProfile() => _prefs.setString("profile", profile.toJson());
}

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class AccountModel extends ProfileChangeNotifier {
  Account get account => _profile.account;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => account != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set account(Account account) {
    if (account?.id != _profile.account?.id) {
      _profile.lastLoginId = _profile.account?.id;
      _profile.account = account;
      notifyListeners();
    }
  }
}
