import 'package:cron/cron.dart';
import 'package:shutdown_platform/shutdown_platform.dart';
import 'package:sleep_early/common/global.dart';

class CronAPI {
  static _setNew(int hour, int minute, Function call) {
    Global.cron.close();
    Global.cron = new Cron();
    String cronStr = "$minute $hour * * *";
    Global.cron.schedule(Schedule.parse(cronStr), call);
  }

  static scheduleShutdown(int hour, int minute) {
    _setNew(hour, minute, () async {
      print("shutdown -> " + DateTime.now().toString());
      String res = await ShutdownPlatform.shutdownNow;
      print(res);
    });
    print("已设置 $hour:$minute 关机");
  }

  static void scheduleShutdownCancel() {
    Global.cron.close();
    print("关机已取消");
  }
}
