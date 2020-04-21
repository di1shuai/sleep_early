import 'dart:convert';

import 'package:flutter/material.dart';

class Device {
  int id;
  String deviceName;
  String deviceId;
  String platform;
  bool open;
  String time;

  
  Device(
    this.id,
    this.deviceName,
    this.deviceId,
    this.platform,
    this.open,
    this.time
  );
  

  TimeOfDay getTimeOfDay(){
    if (time != null){
      List timeArr = time.split(':');   
      int hour = int.parse(timeArr[0]);
      int minute = int.parse(timeArr[1]);
      return TimeOfDay(hour: hour,minute: minute);
    }
    return null;
  }

  static List data(){
    List list = [];
    list.add(Device(1, 'mac笔记本','xxxxxx' ,'macos', false, '22:30'));
    list.add(Device(2, 'windows笔记本','xxxx' ,'windows', true, '22:30'));
    list.add(Device(3, 'iphone手机','xxxx' ,'ios', true, '22:30'));
    list.add(Device(4, 'android手机','xxx' ,'android', true, '22:30'));
    list.add(Device(5, 'ipad','xxxx' ,'ios', true, '22:30'));
    list.add(Device(6, '华为平板','xxxx', 'android', true, '23:00'));
    return list;
  }



  Device copyWith({
    int id,
    String deviceName,
    String deviceId,
    String platform,
    bool open,
    String time,
  }) {
    return Device(
      id ?? this.id,
      deviceName ?? this.deviceName,
      deviceId ?? this.deviceId,
      platform ?? this.platform,
      open ?? this.open,
      time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      map['id'],
      map['deviceName'],
      map['deviceId'],
      map['platform'],
      map['open'],
      map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  static Device fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Device(id: $id, deviceName: $deviceName, deviceId: $deviceId, platform: $platform, open: $open, time: $time)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Device &&
      o.id == id &&
      o.deviceName == deviceName &&
      o.deviceId == deviceId &&
      o.platform == platform &&
      o.open == open &&
      o.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      deviceName.hashCode ^
      deviceId.hashCode ^
      platform.hashCode ^
      open.hashCode ^
      time.hashCode;
  }
}

main(List<String> args) {
   
 
  List list = Device.data();
  // list.forEach((d) => {print(d._id)});
  print(list);


}
