class DeviceCardModel {
  int id;
  String deviceName;
  String icon;
  bool switchValue;
  String time;
  int code;
  String platform;
  String deviceId;
  String deviceType;

  int hour;
  int minute;

  DeviceCardModel(this.id, this.deviceName, this.icon, this.switchValue,  _time, this.code,) {
    if (_time != null) {
      this.time = _time;
      List timeArr = _time.split(':');
      this.hour = int.parse(timeArr[0]);
      this.minute = int.parse(timeArr[1]);
    }
  }

  static List data(){
    List list = [];
    list.add(DeviceCardModel(1, 'mac笔记本', 'mac', false, '22:30', 1));
    list.add(DeviceCardModel(2, 'windows笔记本', 'windows', true, '22:30', 2));
    list.add(DeviceCardModel(3, 'iphone手机', 'iphone', true, '22:30', 3));
    list.add(DeviceCardModel(4, 'android手机', 'iphone', true, '22:30', 4));
    list.add(DeviceCardModel(5, 'ipad', 'ipad', true, '22:30', 5));
    list.add(DeviceCardModel(6, '华为平板', 'tablet', true, '23:00', 6));
    return list;
  }

}

main(List<String> args) {
   
 
  List list = DeviceCardModel.data();
  // list.forEach((d) => {print(d._id)});
  print(list);


}
