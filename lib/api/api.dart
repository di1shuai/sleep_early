import 'package:sleep_early/api/api_url.dart';
import 'package:sleep_early/api/api_util.dart';
import 'package:sleep_early/model/account.dart';
import 'package:sleep_early/model/device.dart';

class API {
  static Future<Account> getAccount(int id) async {
    Map data = await APIUtil.get(APIUrl.ACCOUNT + id.toString());
    try {
      Account account = Account.fromMap(data);

      return account;
    } catch (err) {
      throw Exception('Failed to load Account');
    }
  }

  static Future<List<Device>> getDeviceList(int accountId) async {
    var data = await APIUtil.get(
        APIUrl.DEVICE.replaceFirst(APIUrl.DEVICE_REPICE, accountId.toString()));
    try {
      List<Device> devices = toDeviceList(data);
      return devices;
    } catch (err) {
      throw Exception('Failed to load Devices');
    }
  }

  static Future<Device> CreateDevice(int accountId,Device device) async {
    var data = await APIUtil.post(
        APIUrl.DEVICE.replaceFirst(APIUrl.DEVICE_REPICE, accountId.toString()),
        device.toMap());
    try {
      Device device = Device.fromMap(data);
      return device;
    } catch (err) {
      throw Exception('Failed to load Device');
    }
  }

  static Future<Device> UpdateDevice(int accountId,Device device) async {
    var data = await APIUtil.put(
        APIUrl.DEVICE.replaceFirst(APIUrl.DEVICE_REPICE, accountId.toString()),
        device.toMap());
    try {
      Device device = Device.fromMap(data);
      return device;
    } catch (err) {
      throw Exception('Failed to load Device');
    }
  }


}

List<Device> toDeviceList(data) {
  List<Device> list = List();
  for (var device in data) {
    Device d = Device.fromMap(device);
    list.add(d);
  }
  return list;
}
