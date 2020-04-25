import 'package:flutter/material.dart';
import 'package:sleep_early/api/account_api.dart';
import 'package:sleep_early/api/device_api.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/models/device.dart';

class AccountProvider with ChangeNotifier {
  Account _account;

  Account get account => this._account;

  set account(Account account) {
    this._account = account;
    notifyListeners();
  }
}

class DeviceListProvider with ChangeNotifier {
  List<Device> _devices;

  List<Device> get devices => this._devices;

  set devices(List<Device> _devices) {
    this._devices = _devices;
    notifyListeners();
  }

  refresh(BuildContext context) {
    Future<List<Device>> devicesFuture =
        DeviceAPI.getDeviceByAccountId(AccountAPI.currentAccount(context).id);
    devicesFuture.then((value) {
      devices = value;
    });
  }
}
