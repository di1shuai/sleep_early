import 'package:flutter/material.dart';
import 'package:sleep_early/api/account_api.dart';
import 'package:sleep_early/api/device_api.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/models/device.dart';
import 'package:sleep_early/models/profile.dart';

import 'global.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class AccountProvider extends ProfileChangeNotifier {
  Account get account => this._profile.account;

  bool get isLogin => account != null;

  set account(Account account) {
    if (account?.id != Global.profile.account?.id) {
      Global.profile.lastLoginId = Global.profile.account?.id;
      Global.profile.account = account;
      notifyListeners();
    }
  }
}

class DeviceListProvider with ChangeNotifier {
  List<Device> _devices;

  List<Device> get devices => this._devices;

  set devices(List<Device> devices) {
    if (_devices == null) {
      _devices = List<Device>();
    }
    _devices.clear();
    _devices.addAll(devices);
    notifyListeners();
  }

  bool get isInit {
    return _devices != null;
  }

  refresh(BuildContext context) async {
    devices = await DeviceAPI.getDeviceByAccountId(
        AccountAPI.currentAccount(context).id);
  }
}
