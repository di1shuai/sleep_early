import 'package:flutter/material.dart';
import 'package:cron/cron.dart';

class CronDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    int hour = 18;
    int minute = 3;
    
    var cron = new Cron();
    cron.schedule(Schedule.parse("4 $hour * * *"), () async {
      print(DateTime.now().toString());
    });
    cron.close();
    cron = new Cron();
    cron.schedule(Schedule.parse("$minute $hour * * *"), () async {
      print(DateTime.now().toString());
    });


    // cron.close();
    return Scaffold(
      appBar: AppBar(title: Text('corn Demo'),),
      body: Center(),
    );
  }
}
