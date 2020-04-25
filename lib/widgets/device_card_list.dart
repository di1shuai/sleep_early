import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/account_api.dart';
import 'package:sleep_early/api/cron_api.dart';
import 'package:sleep_early/api/device_api.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/models/device.dart';

import 'device_card.dart';

class DeviceCardList extends StatefulWidget {
  @override
  _DeviceCardList createState() => _DeviceCardList();
}

class _DeviceCardList extends State<DeviceCardList> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    Future<List<Device>> devicesFuture =
        DeviceAPI.getDeviceByAccountId(AccountAPI.currentAccount(context).id);
    devicesFuture.then((value) {
      Provider.of<DeviceListProvider>(context, listen: false).devices = value;
      CronAPI.refreshDeviceList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceListProvider>(builder: (context, dList, _) {
      if (dList.devices == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
            itemCount: dList.devices.length,
            itemBuilder: (BuildContext context, int index) {
              return DeviceCard(device: dList.devices[index]);
            });
      }
    });
  }
}
