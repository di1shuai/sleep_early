import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/device_api.dart';
import 'package:sleep_early/common/providers.dart';

import 'device_dialog.dart';

class ShowBinding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceListProvider dList = Provider.of<DeviceListProvider>(context);
    if (dList.devices != null) {
      if (DeviceAPI.hasBinding(dList.devices)) {
        return Icon(Icons.check);
      } else {
        return FloatingActionButton(
          onPressed: () async {
            bool isCreate = await showCreateDialog(context);
            if (isCreate == false) {
              print('取消');
            } else {
              dList.refresh(context);
            }
          },
          tooltip: 'Binding',
          child: Icon(Icons.add),
        );
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
