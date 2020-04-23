import 'package:sleep_early/api/api_url.dart';
import 'package:sleep_early/api/api_util.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/models/device.dart';

class API {
  
  // Login
  
  static Future<Account> login(String username,String password) async {
    Map data = await APIUtil.post(APIUrl.LOGIN,{"id":username});
    try {
      Account account = Account.fromMap(data);
      return account;
    } catch (err) {
      throw Exception('Failed to login');
    }
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

  
  
  
  
  // Device
  
  static Future<List<Device>> getDeviceList(Device device) async {
    var data = await APIUtil.get(APIUrl.DEVICE,device.toMap());
    try {
      List<Device> devices = toDeviceList(data);
      return devices;
    } catch (err) {
      throw Exception('Failed to load Devices');
    }
  }

    static Future<List<Device>> getDeviceByAccountId(int accountId) async {
    Map query = {"accountId":accountId};
    var data = await APIUtil.get(APIUrl.DEVICE,query);
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

  static Future<Device> UpdateDevice(int accountId,Device device) async {
    var data = await APIUtil.put(APIUrl.DEVICE,device.toMap());
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
