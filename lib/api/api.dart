import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/api_url.dart';
import 'package:sleep_early/api/api_util.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/models/device.dart';

class API {
  // Login

  static Future<Account> login(String username, String password) async {
    Map data = await APIUtil.post(APIUrl.LOGIN, {"id": username});
    try {
      Account account = Account.fromMap(data);
      return account;
    } catch (err) {
      throw Exception('Failed to login');
    }
  }

  static bool isLogin(BuildContext context) {
    AccountProvider proAccount = Provider.of<AccountProvider>(context);
    bool isLogin = false;
    if (proAccount.account != null) {
      isLogin = true;
    }
    return isLogin;
  }

  // Account

  static Future<Account> getAccount(int id) async {
    Map data = await APIUtil.get(APIUrl.ACCOUNT + id.toString());
    try {
      Account account = Account.fromMap(data);

      return account;
    } catch (err) {
      throw Exception('Failed to load Account');
    }
  }

  static Account currentAccount(BuildContext context) {
    AccountProvider accountPrd = Provider.of<AccountProvider>(context);
    return accountPrd.account;
  }

  // Device

  static Future<List<Device>> getDeviceList(Device device) async {
    var data = await APIUtil.get(APIUrl.DEVICE, device.toMap());
    try {
      List<Device> devices = toDeviceList(data);
      return devices;
    } catch (err) {
      throw Exception('Failed to load Devices');
    }
  }

  static Future<List<Device>> getDeviceByAccountId(int accountId) async {
    Map<String, int> query = {"accountId": accountId};
    var data = await APIUtil.get(APIUrl.DEVICE, query);
    try {
      List<Device> devices = toDeviceList(data);
      return devices;
    } catch (err) {
      throw Exception('Failed to load Devices');
    }
  }

  static Future<Device> CreateDevice(Device device) async {
    var data = await APIUtil.post(APIUrl.DEVICE, device.toMap());
    try {
      Device device = Device.fromMap(data);
      return device;
    } catch (err) {
      throw Exception('Failed to load Device');
    }
  }

  static Future<Device> UpdateDevice(int accountId, Device device) async {
    var data = await APIUtil.put(APIUrl.DEVICE, device.toMap());
    try {
      Device device = Device.fromMap(data);
      return device;
    } catch (err) {
      throw Exception('Failed to load Device');
    }
  }

  static Future<Device> getInitDevice() async {
    return new Device(
        id: null,
        accountId: 1,
        deviceName: Platform.localHostname,
        deviceId: await PlatformDeviceId.getDeviceId,
        platform: Platform.operatingSystem.toUpperCase(),
        open: true,
        time: '22:30');
  }

  static List<Device> toDeviceList(data) {
    List<Device> list = List();
    for (var device in data) {
      Device d = Device.fromMap(device);
      list.add(d);
    }
    return list;
  }
}
