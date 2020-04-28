import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sleep_early/common/global.dart';

class Device {
  int id;
  int accountId;
  String deviceName;
  String deviceId;
  String platform;
  bool open;
  String time;
  Device({
    this.id,
    this.accountId,
    this.deviceName,
    this.deviceId,
    this.platform,
    this.open,
    this.time,
  });

  Device copyWith({
    int id,
    int accountId,
    String deviceName,
    String deviceId,
    String platform,
    bool open,
    String time,
  }) {
    return Device(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      deviceName: deviceName ?? this.deviceName,
      deviceId: deviceId ?? this.deviceId,
      platform: platform ?? this.platform,
      open: open ?? this.open,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountId': accountId,
      'deviceName': deviceName,
      'deviceId': deviceId,
      'platform': platform,
      'open': open,
      'time': time,
    };
  }

  static Device fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Device(
      id: map['id'],
      accountId: map['accountId'],
      deviceName: map['deviceName'],
      deviceId: map['deviceId'],
      platform: map['platform'],
      open: map['open'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  static Device fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Device(id: $id, accountId: $accountId, deviceName: $deviceName, deviceId: $deviceId, platform: $platform, open: $open, time: $time)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Device &&
        o.id == id &&
        o.accountId == accountId &&
        o.deviceName == deviceName &&
        o.deviceId == deviceId &&
        o.platform == platform &&
        o.open == open &&
        o.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        accountId.hashCode ^
        deviceName.hashCode ^
        deviceId.hashCode ^
        platform.hashCode ^
        open.hashCode ^
        time.hashCode;
  }

  TimeOfDay getTimeOfDay() {
    var split = this.time.split(":");
    int hour = int.parse(split[0]);
    int minute = int.parse(split[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  setTimeOfDay(TimeOfDay _time) {
    this.time = _time.hour.toString() + ":" + _time.minute.toString();
  }

  bool isBinding() {
    return this.deviceId == Global.deviceId;
  }

   Icon getIcon(BuildContext context) {
    Icon result;
    switch (platform) {
      case 'MACOS':
        result =
            Icon(Icons.desktop_mac, color: Theme.of(context).iconTheme.color);
        break;
      case 'WINDOWS':
        result = Icon(Icons.desktop_windows,
            color: Theme.of(context).iconTheme.color);
        break;
      case 'LINUX':
        result =
            Icon(Icons.tablet_mac, color: Theme.of(context).iconTheme.color);
        break;
      case 'IOS':
        result =
            Icon(Icons.phone_iphone, color: Theme.of(context).iconTheme.color);
        break;
      case 'ANDROID':
        result =
            Icon(Icons.phone_android, color: Theme.of(context).iconTheme.color);
        break;

      default:
        result = Icon(Icons.device_unknown,
            color: Theme.of(context).iconTheme.color);
    }
    return result;
  }
}
