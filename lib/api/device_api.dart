import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sleep_early/api/account_api.dart';
import 'package:sleep_early/common/api_url.dart';
import 'package:sleep_early/common/global.dart';
import 'package:sleep_early/common/http_manager.dart';
import 'package:sleep_early/models/device.dart';

import 'cron_api.dart';

class DeviceAPI {
// Device

  static Future<List<Device>> getDeviceList(Device device) async {
    var data = await HttpManager.get(APIUrl.DEVICE, device.toMap());
    try {
      List<Device> devices = toDeviceList(data);
      return devices;
    } catch (err) {
      throw Exception('Failed to load Devices');
    }
  }

  static Future<List<Device>> getDeviceByAccountId(int accountId) async {
    Map<String, int> query = {"accountId": accountId};
    var data = await HttpManager.get(APIUrl.DEVICE, query);
    try {
      List<Device> devices = toDeviceList(data);
      return devices;
    } catch (err) {
      throw Exception('Failed to load Devices');
    }
  }

  static Future<Device> CreateDevice(Device device) async {
    var data = await HttpManager.post(APIUrl.DEVICE, device.toMap());
    try {
      Device device = Device.fromMap(data);
      shutdownInit(device);
      return device;
    } catch (err) {
      throw Exception('Failed to load Device');
    }
  }

  static Future<Device> UpdateDevice(Device device) async {
    var data = await HttpManager.put(APIUrl.DEVICE, device.toMap());
    try {
      Device device = Device.fromMap(data);
      shutdownInit(device);
      return device;
    } catch (err) {
      throw Exception('Failed to load Device');
    }
  }

  static Future<bool> DeleteDevice(Device device) async {
    var data = await HttpManager.delete(APIUrl.DEVICE + device.id.toString());
    try {
      if (data == null) {
        device.isBinding() ? CronAPI.scheduleShutdownCancel() : null;
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw Exception('Failed to delete Device');
    }
  }

  static void shutdownInit(Device device) {
    // 设备为本设备
    if (device.isBinding()) {
      if (device.open == true) {
        //开启
        CronAPI.scheduleShutdown(
            device.getTimeOfDay().hour, device.getTimeOfDay().minute);
      } else {
        //关闭
        CronAPI.scheduleShutdownCancel();
      }
    }
  }

  static Device getInitDevice(BuildContext context) {
    String deviceName;
    if(Platform.isAndroid){
      deviceName = Global.deviceData['id'];
    }else if(Platform.isIOS){
      deviceName = Platform.localHostname;
    }else{
      deviceName = Platform.localHostname;
    }

    return new Device(
        id: null,
        accountId: AccountAPI.currentAccount(context).id,
        deviceName: DeviceAPI.isDesktop() ? Platform.localHostname : Platform.localHostname,
        deviceId: Global.deviceId,
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

  static bool hasBinding(List<Device> devices) {
    for (Device device in devices) {
      if (device.isBinding()) {
        return true;
      }
    }
    return false;
  }

  static bool isDesktop(){
    if(Platform.isWindows | Platform.isMacOS | Platform.isLinux){
      return true;
    }
    return false;
  }

}
