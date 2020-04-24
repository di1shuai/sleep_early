import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_early/api/device_api.dart';

import 'package:sleep_early/models/device.dart';

class DeviceCard extends StatefulWidget {
  Device device;

  DeviceCard({
    Key key,
    this.device,
  }) : super(key: key);

  @override
  _DeviceCardState createState() => _DeviceCardState(device: device);
}

class _DeviceCardState extends State<DeviceCard> {
  Device device;

  TimeOfDay _time;

  _DeviceCardState({Key key, this.device}) {
    this.device = device;
    if (this.device != null) {
      List timeArr = device.time.split(':');
      int hour = int.parse(timeArr[0]);
      int minute = int.parse(timeArr[1]);
      this._time = TimeOfDay(hour: hour, minute: minute);
    }
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

  @override
  Widget build(BuildContext context) {
    return Card(
        color: device.isBinding()
            ? Theme.of(context).accentColor
            : Theme.of(context).cardTheme.color,
        elevation: 15.0, //设置阴影
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))), //设置圆角
        child: SizedBox(
            height: 60.0, //设置高度
            child: ListTile(
                leading: getIcon(context),
                trailing: CupertinoSwitch(
                  value: device.open,
                  onChanged: (value) async {
                    device.open = value;
                    device = await DeviceAPI.UpdateDevice(device);
                    setState(() {});
                  },
                ),
                title: Row(children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(device.deviceName,
                        style: Theme.of(context).primaryTextTheme.bodyText1),
                  ),
                  Expanded(
                    flex: 2,
                    child: FlatButton(
                      child: Text(
                        '${_time.hour}:${_time.minute}',
                        style: Theme.of(context).primaryTextTheme.button,
                      ),
                      onPressed: () {
                        _selectTime(context);
                      },
                    ),
                  ),
                ]))));
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time) {
      print(" time -> ${_time.hour}:${_time.minute}");
      _time = picked;
      device.time = _time.hour.toString() + ":" + _time.minute.toString();
      device = await DeviceAPI.UpdateDevice(device);
      setState(() {});
    }
    if (picked == null) _time = TimeOfDay(hour: 22, minute: 30);
  }
}
