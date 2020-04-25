import 'package:flutter/material.dart';
import 'package:sleep_early/api/api.dart';
import 'package:sleep_early/views/login.dart';
import 'package:sleep_early/widgets/device_card_list.dart';
import 'package:sleep_early/widgets/menu.dart';

import 'package:sleep_early/widgets/show_binding.dart';

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (API.isLogin(context)) {
      //登录

      return Scaffold(
        appBar: AppBar(
          title: Text('SleepEarly'),
        ),
        drawer: Menu(),
        body: Column(children: <Widget>[
          Expanded(
            flex: 6,
            child: DeviceCardList(),
          ),
          Expanded(flex: 1, child: ShowBinding())
        ]),
      );
    } else {
      //未登录
      return LoginRoute();
    }
  }
}
