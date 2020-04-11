import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DeviceCard extends StatefulWidget {
  String deviceName;
  String icon;
  bool _switchValue;
  String _time;

  DeviceCard(this.deviceName, this.icon, this._switchValue, this._time);

  @override
  _DeviceCardState createState() =>
      _DeviceCardState(deviceName, icon, _switchValue, _time);
}

class _DeviceCardState extends State<DeviceCard> {
  String _deviceName;
  String _icon;
  bool _switchValue;
  TimeOfDay _time;

  _DeviceCardState(
      this._deviceName, this._icon, this._switchValue, String time) {
    List timeArr = time.split(':');
    int hour = int.parse(timeArr[0]);
    int minute = int.parse(timeArr[1]);
    this._time = TimeOfDay(hour: hour, minute: minute);
  }

  Icon getIcon(BuildContext context) {
    Icon result;
    switch (this._icon) {
      case 'mac':
        result = Icon(Icons.desktop_mac, color: Theme.of(context).accentColor);
        break;
      case 'windows':
        result = Icon(Icons.desktop_windows, color: Theme.of(context).accentColor);
        break;
      case 'ipad':
        result = Icon(Icons.tablet_mac, color: Theme.of(context).accentColor);
        break;
      case 'tablet':
        result = Icon(Icons.tablet_android, color: Theme.of(context).accentColor);
        break;
      case 'iphone':
        result = Icon(Icons.phone_iphone, color: Theme.of(context).accentColor);
        break;
      case 'android':
        result = Icon(Icons.phone_android, color: Theme.of(context).accentColor);
        break;
      default:
        result = Icon(Icons.device_unknown, color: Theme.of(context).accentColor);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: getIcon(context),
      ),
      Expanded(
        flex: 2,
        child: Text(this._deviceName,
            style: Theme.of(context).primaryTextTheme.body1),
      ),
      Expanded(
        flex: 2,
        child: FlatButton(
          child: Text(
            '${_time.hour}:${_time.minute}',
            style: Theme.of(context).primaryTextTheme.body1,
          ),
          onPressed: () {
            _selectTime(context);
          },
        ),
      ),
      Expanded(
        flex: 2,
        child: CupertinoSwitch(
          value: _switchValue,
          onChanged: (value) {
            setState(() {
              _switchValue = value;
            });
          },
        ),
      ),
    ]);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time)
      print(" time -> ${_time.hour}:${_time.minute}");
    setState(() {
      _time = picked;
    });
    if (picked == null) _time = TimeOfDay(hour: 22, minute: 30);
  }
}
