import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/device_api.dart';
import 'package:sleep_early/common/providers.dart';

import 'package:sleep_early/models/device.dart';

class DeviceCard extends StatelessWidget {
  Device device;

  DeviceCard({
    Key key,
    this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceListProvider>(builder: (context, dList, child) {
      return Card(
          color: device.isBinding()
              ? Theme.of(context).accentColor
              : Theme.of(context).cardTheme.color,
          elevation: 15.0, //设置阴影
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: SizedBox(
              height: 60.0, //设置高度
              child: SwitchListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(device.deviceName,
                            style:
                                Theme.of(context).primaryTextTheme.bodyText1),
                      ),
                      Expanded(
                          flex: 1,
                          child: FlatButton(
                              child: Text(
                                device.time,
                                style:
                                    Theme.of(context).primaryTextTheme.button,
                              ),
                              onPressed:  () async {
                                final TimeOfDay picked = await showTimePicker(
                                    context: context,
                                    initialTime: device.getTimeOfDay());
                                if (picked != null &&
                                    picked != device.getTimeOfDay()) {
                                  device.setTimeOfDay(picked);
                                  print(" time -> ${device.time}");
                                  device = await DeviceAPI.UpdateDevice(device);
                                  dList.refresh(context);
                                }
                                if (picked == null) {
                                  device.setTimeOfDay(
                                      TimeOfDay(hour: 22, minute: 30));
                                  print(" time -> ${device.time}");
                                  device = await DeviceAPI.UpdateDevice(device);
                                  dList.refresh(context);
                                }
                              }))
                    ],
                  ),
                  value: device.open,
                  secondary: getIcon(context),
                  onChanged: (value) async {
                    device.open = value;
                    await DeviceAPI.UpdateDevice(device);
                    dList.refresh(context);
                  })));
    });
  }

  _selectTime(){
    
  }

  Icon getIcon(BuildContext context) {
    Icon result;
    switch (device.platform) {
      case 'MACOS':
        result = Icon(Icons.desktop_mac,
            color: Theme.of(context).accentIconTheme.color);
        break;
      case 'WINDOWS':
        result = Icon(Icons.desktop_windows,
            color: Theme.of(context).accentIconTheme.color);
        break;
      case 'LINUX':
        result = Icon(Icons.tablet_mac,
            color: Theme.of(context).accentIconTheme.color);
        break;
      case 'IOS':
        result = Icon(Icons.phone_iphone,
            color: Theme.of(context).accentIconTheme.color);
        break;
      case 'ANDROID':
        result = Icon(Icons.phone_android,
            color: Theme.of(context).accentIconTheme.color);
        break;

      default:
        result = Icon(Icons.device_unknown,
            color: Theme.of(context).iconTheme.color);
    }
    return result;
  }
}
