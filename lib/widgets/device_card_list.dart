import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/cron_api.dart';
import 'package:sleep_early/common/providers.dart';

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
    DeviceListProvider dl =
        Provider.of<DeviceListProvider>(context, listen: false);
    dl.refresh(context);
    CronAPI.refreshDeviceList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceListProvider>(builder: (context, dList, child) {
      if (dList.devices == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            setState((){
               dList.refresh(context);
            });
          },
          child: new ListView.builder(
              itemCount: dList.devices.length,
              itemBuilder: (BuildContext context, int index) {
                return new DeviceCard(device: dList.devices[index]);
              }),
        );
      }
    });
  }
}
