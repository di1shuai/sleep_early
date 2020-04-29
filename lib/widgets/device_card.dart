import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/device_api.dart';
import 'package:sleep_early/common/providers.dart';

import 'package:sleep_early/models/device.dart';
import 'package:sleep_early/widgets/input.dart';

class DeviceCard extends StatelessWidget {
  Device device;

  DeviceCard({
    Key key,
    this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceListProvider>(builder: (context, dList, child) {
      final deviceTimeB = FlatButton(
          child: Text(
            device.time,
          ),
          onPressed: () async {
            final TimeOfDay picked = await showTimePicker(
                context: context, initialTime: device.getTimeOfDay());
            if (picked != null && picked != device.getTimeOfDay()) {
              device.setTimeOfDay(picked);
              print(" time -> ${device.time}");
              device = await DeviceAPI.UpdateDevice(device);
              dList.refresh(context);
            }
            if (picked == null) {
              device.setTimeOfDay(TimeOfDay(hour: 22, minute: 30));
              print(" time -> ${device.time}");
              device = await DeviceAPI.UpdateDevice(device);
              dList.refresh(context);
            }
          });

      final deviceNameB = FlatButton(
          onPressed: () async {
            print(device.deviceName);
            String res = await showDevicenameDialog(
                context, device.deviceName, device.getIcon(context));
            if (res != null) {
              device.deviceName = res;
              device = await DeviceAPI.UpdateDevice(device);
              dList.refresh(context);
            }
          },
          child: Text(
            device.deviceName,
          ));

      final deviceTile = SwitchListTile(
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: deviceNameB,
              ),
              Expanded(flex: 1, child: deviceTimeB)
            ],
          ),
          value: device.open,
          secondary: device.getIcon(context),
          onChanged: (value) async {
            device.open = value;
            await DeviceAPI.UpdateDevice(device);
            dList.refresh(context);
          });

      return GestureDetector(
          onLongPress: () {
            //Todo 删除
            print("长按");
          },
          child: Card(
              color: device.isBinding()
                  ? Color.fromARGB(255, 61, 203, 128)
                  : Theme.of(context).cardTheme.color,
              elevation: 15.0, //设置阴影
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: SizedBox(
                  height: 60.0, //设置高度
                  child: deviceTile)));
    });
  }

  Future<String> showDevicenameDialog(
      BuildContext context, String oldDeviceName, Icon icon) {
    TextEditingController _deviceNameC = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final content = SizedBox(
      width: 300,
      child: Form(
          key: _formKey,
          child: DeviceNameT(
              controller: _deviceNameC,
              oldDeviceName: oldDeviceName,
              icon: icon)),
    );

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("设备名称"),
          content: content,
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(null),
            ),
            FlatButton(
              child: Text("更新"),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  Navigator.of(context).pop(_deviceNameC.text);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
