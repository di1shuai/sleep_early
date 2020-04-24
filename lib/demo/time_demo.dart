import 'dart:async';

import 'package:flutter/material.dart';

class TimerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    /* 单次回调 */
    const timeout = const Duration(seconds: 5);
    print('currentTime=' + DateTime.now().toString());
    Timer(timeout, () {
      //到时回调
      print('afterTimer=' + DateTime.now().toString());
    });


    /* 多次回调 */
    int count = 0;
    const period = const Duration(seconds: 1);
    print('currentTime=' + DateTime.now().toString());
    Timer.periodic(period, (timer) {
      //到时回调
      print('afterTimer=' + DateTime.now().toString());
      count++;
      if (count >= 5) {
        //取消定时器，避免无限回调
        timer.cancel();
        timer = null;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Timer Demo'),
      ),
      body: Center(),
    );
  }
}
