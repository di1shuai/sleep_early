import 'dart:convert';

import 'package:flutter/material.dart';

class DeviceCardModel {
  int id;
  String deviceName;
  String platform;
  bool switchValue;
  String time;

  
  DeviceCardModel(
    this.id,
    this.deviceName,
    this.platform,
    this.switchValue,
    this.time);
  

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
    list.add(DeviceCardModel(1, 'mac笔记本', 'macos', false, '22:30'));
    list.add(DeviceCardModel(2, 'windows笔记本', 'windows', true, '22:30'));
    list.add(DeviceCardModel(3, 'iphone手机', 'ios', true, '22:30'));
    list.add(DeviceCardModel(4, 'android手机', 'android', true, '22:30'));
    list.add(DeviceCardModel(5, 'ipad', 'ios', true, '22:30'));
    list.add(DeviceCardModel(6, '华为平板', 'android', true, '23:00'));
    return list;
  }



  DeviceCardModel copyWith({
    int id,
    String deviceName,
    String platform,
    bool switchValue,
    String time,
  }) {
    return DeviceCardModel(
      id ?? this.id,
      deviceName ?? this.deviceName,
      platform ?? this.platform,
      switchValue ?? this.switchValue,
      time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deviceName': deviceName,
      'platform': platform,
      'switchValue': switchValue,
      'time': time,
    };
  }

  static DeviceCardModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return DeviceCardModel(
      map['id'],
      map['deviceName'],
      map['platform'],
      map['switchValue'],
      map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  static DeviceCardModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'DeviceCardModel(id: $id, deviceName: $deviceName, platform: $platform, switchValue: $switchValue, time: $time)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is DeviceCardModel &&
      o.id == id &&
      o.deviceName == deviceName &&
      o.platform == platform &&
      o.switchValue == switchValue &&
      o.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      deviceName.hashCode ^
      platform.hashCode ^
      switchValue.hashCode ^
      time.hashCode;
  }
}

main(List<String> args) {
   
 
  List list = DeviceCardModel.data();
  // list.forEach((d) => {print(d._id)});
  print(list);


}
