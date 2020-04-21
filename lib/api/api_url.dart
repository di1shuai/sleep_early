class APIUrl {
  
  static const String BASE_URL = 'http://192.168.72.91:8888/api/';

  static const String ACCOUNT =  'account/';

  static const String DEVICE_REPICE =  'accountId';
  static const String DEVICE =  DEVICE_REPICE+'/device/'; //获取设备信息

  
  static String getRepiceUrl(String from,String to){
    return from.replaceFirst(from, to);
  } 

}