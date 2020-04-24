import 'package:flutter/material.dart';
import 'package:sleep_early/api/account_api.dart';
import 'package:sleep_early/api/api.dart';
import 'package:sleep_early/api/device_api.dart';
import 'package:sleep_early/common/routes.dart';
import 'package:sleep_early/widgets/device_dialog.dart';
import 'package:sleep_early/widgets/menu.dart';
import 'package:sleep_early/widgets/device_card.dart';
import 'package:sleep_early/models/device.dart';

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
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool isCreate = await showCreateDialog(context);
            if (isCreate == false) {
              print('取消');
            } else {
              print('刷新');
            }
          },
          tooltip: 'Binding',
          child: Icon(Icons.add),
        ),
      );
    } else {
      //未登录
      return Center(
        child: RaisedButton(
          color: Theme.of(context).buttonColor,
          child: Text('登录'),
          onPressed: () => Navigator.of(context).pushNamed(Routes.LOGIN_ROUTE),
        ),
      );
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
            List<Device> devices = snapshot.data;
            return ListView.builder(
                itemCount: devices.length,
                itemBuilder: (BuildContext context, int index) {
                  return DeviceCard(device: devices[index]);
                });
          }
        } else {
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      },
    );
  }
}
