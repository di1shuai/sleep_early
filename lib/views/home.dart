import 'package:flutter/material.dart';
import 'package:sleep_early/api/account_api.dart';
import 'package:sleep_early/api/api.dart';
import 'package:sleep_early/api/cron_api.dart';
import 'package:sleep_early/api/device_api.dart';
import 'package:sleep_early/views/login.dart';
import 'package:sleep_early/widgets/device_dialog.dart';
import 'package:sleep_early/widgets/menu.dart';
import 'package:sleep_early/widgets/device_card.dart';
import 'package:sleep_early/models/device.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  List<Device> devices;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (API.isLogin(context)) {
      //登录
      return Scaffold(
        appBar: AppBar(
          title: Text('SleepEarly'),
        ),
        drawer: Menu(),
        body: _buildBody(context),
      );
    } else {
      //未登录
      return LoginRoute();
    }
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<List<Device>>(
      future:
          DeviceAPI.getDeviceByAccountId(AccountAPI.currentAccount(context).id),
      builder: (BuildContext context, AsyncSnapshot<List<Device>> snapshot) {
        // 请求已结束
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          } else {
            // 请求成功，显示数据
            devices = snapshot.data;
            return Column(children: <Widget>[
              Expanded(
                flex: 5,
                child: ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DeviceCard(device: devices[index]);
                    }),
              ),
              Expanded(flex: 1, child: _needShowBinding())
            ]);
          }
        } else {
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _needShowBinding() {
    if (DeviceAPI.hasBinding(devices)) {
      return Icon(Icons.check);
    } else {
      return FloatingActionButton(
        onPressed: () async {
          bool isCreate = await showCreateDialog(context);
          if (isCreate == false) {
            print('取消');
          } else {
            setState(() {});
          }
        },
        tooltip: 'Binding',
        child: Icon(Icons.add),
      );
    }
  }
}
