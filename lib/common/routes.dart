import 'package:flutter/cupertino.dart';
import 'package:sleep_early/views/demo.dart';
import 'package:sleep_early/views/home.dart';
import 'package:sleep_early/views/signin.dart';
import 'package:sleep_early/views/signup.dart';

class Routes{

  static const String HOME_ROUTE  = "/";
  static const String SIGNIN_ROUTE = "/signin";
  static const String SIGNUP_ROUTE = "/signup";
  static const String DEMO_ROUTE  = "/demo";


  static Map<String , WidgetBuilder> getRoutesMap(BuildContext context){
    return {
      HOME_ROUTE : (context) => HomeRoute(),
      SIGNIN_ROUTE : (context) => SigninRoute(),
      SIGNUP_ROUTE : (context) => SignupRoute(),
      DEMO_ROUTE : (context) => DemoRoute(),
    };
  }

}