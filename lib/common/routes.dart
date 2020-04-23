import 'package:flutter/cupertino.dart';
import 'package:sleep_early/views/demo.dart';
import 'package:sleep_early/views/home.dart';
import 'package:sleep_early/views/login.dart';

class Routes{

  static const String HOME_ROUTE  = "/";
  static const String LOGIN_ROUTE = "/login";
  static const String DEMO_ROUTE  = "/demo";


  static Map<String , WidgetBuilder> getRoutesMap(BuildContext context){
    return {
      HOME_ROUTE : (context) => HomeRoute(),
      LOGIN_ROUTE : (context) => LoginRoute(),
      DEMO_ROUTE : (context) => DemoRoute(),
    };
  }

}