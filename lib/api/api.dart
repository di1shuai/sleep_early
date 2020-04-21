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
}

List<Device> toDeviceList(data) {
  List<Device> list = List();
  for (var device in data) {
    Device d = Device.fromMap(device);
    list.add(d);
  }
  return list;
}
