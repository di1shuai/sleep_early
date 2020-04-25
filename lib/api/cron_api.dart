import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shutdown_platform/shutdown_platform.dart';
import 'package:sleep_early/common/global.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/models/device.dart';

import 'account_api.dart';
import 'device_api.dart';

class CronAPI {
  static _newShutdown(int hour, int minute, Function call) {
    Global.shutdownCron.close();
    Global.shutdownCron = new Cron();
    String cronStr = "$minute $hour * * *";
    Global.shutdownCron.schedule(Schedule.parse(cronStr), call);
  }

  static scheduleShutdown(int hour, int minute) {
    _newShutdown(hour, minute, () async {
      print("shutdown -> " + DateTime.now().toString());
      String res = await ShutdownPlatform.shutdownNow;
      print(res);
    });
    print("已设置 $hour:$minute 关机");
  }

  static scheduleShutdownCancel() {
    Global.shutdownCron.close();
    print("关机已取消");
  }

  static refreshDeviceList(BuildContext context) {
    //每分钟刷新一下
    Global.refreshCron.close();
    Global.refreshCron = new Cron();
    Global.refreshCron.schedule(Schedule.parse(Global.refreshCronStr), () {
      Future<List<Device>> devicesFuture =
          DeviceAPI.getDeviceByAccountId(AccountAPI.currentAccount(context).id);
      devicesFuture.then((value) {
        Provider.of<DeviceListProvider>(context,listen: false).devices = value;
      });
    });
  }
}
