import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sleep_early/model/device_card.dart';

class DeviceDialog extends StatefulWidget {
  

  DeviceCardModel device;
  bool isCreate;
  DeviceDialog({Key key , this.device, this.isCreate}):super(key:key);

  @override
  State<StatefulWidget> createState() => _DeviceDialogState(device, isCreate);
}

class _DeviceDialogState extends State<DeviceDialog> {
  DeviceCardModel _device;
  bool _isCreate;
  TimeOfDay _time;

  _DeviceDialogState(this._device, this._isCreate){
    _time = _device.getTimeOfDay();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text('平台: ' + _device.platform),
        ),
        TextField(
          autofocus: false,
          maxLength: 12,
          decoration: InputDecoration(
              labelText: "名称",
              hintText: _device.deviceName,
              prefixIcon: Icon(Icons.device_unknown)),
          onChanged: (value) => {
            setState(() {
              _device.deviceName = value;
            })
          },
        ),
        FlatButton(
          child: Text(
            '${_time.hour}:${_time.minute}',
            style: Theme.of(context).primaryTextTheme.button,
          ),
          onPressed: () {
            _selectTime(context);
          },
        ),
        CupertinoSwitch(
          value: _device.switchValue,
          onChanged: (value) {
            setState(() {
              _device.switchValue = value;
            });
          },
        )
      ],
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time) {
      print("time -> ${_time.hour}:${_time.minute}");
    }
    setState(() {
      _time = picked;
      _device.time = _time.hour.toString() + ':' + _time.hour.toString();
    });
    if (picked == null) _time = TimeOfDay(hour: 22, minute: 30);
  }
}

Future<DeviceCardModel> showCreateDialog(BuildContext context) {
  DeviceCardModel _device_init = new DeviceCardModel(
      null, Platform.localHostname, Platform.operatingSystem, true, '22:30');

  final GlobalKey<_DeviceDialogState> key = GlobalKey();

  DeviceDialog dialog = new DeviceDialog(key:key,device:_device_init,isCreate:true);

  return showDialog<DeviceCardModel>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("设备绑定"),
        content: dialog,
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text("绑定"),
            onPressed: () {
              //Todo http json create
              Navigator.of(context).pop(key.currentState._device);
            },
          ),
        ],
      );
    },
  );
}
