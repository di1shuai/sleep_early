import 'package:flutter/cupertino.dart';
import 'package:sleep_early/views/about/privacy_policy_view.dart';
import 'package:sleep_early/views/about/user_agreement_view.dart';
import 'package:sleep_early/views/about_view.dart';
import 'package:sleep_early/views/account_view.dart';
import 'package:sleep_early/views/demo_view.dart';
import 'package:sleep_early/views/home_view.dart';
import 'package:sleep_early/views/signin_view.dart';
import 'package:sleep_early/views/signup_view.dart';

class Routes{

  static const String HOME_ROUTE  = "/";
  static const String SIGNIN_ROUTE = "/signin";
  static const String SIGNUP_ROUTE = "/signup";
  static const String ACCOUNT_ROUTE = "/account";
  static const String ABOUT_ROUTE = "/about";
  static const String PRIVACY_POLICY_ROUTE = "/about/privacy_policy";
  static const String USER_AGREEMENT_ROUTE = "/about/user_agreement";
  static const String DEMO_ROUTE  = "/demo";


  static Map<String , WidgetBuilder> getRoutesMap(BuildContext context){
    return {
      HOME_ROUTE : (context) => HomeRoute(),
      SIGNIN_ROUTE : (context) => SigninRoute(),
      SIGNUP_ROUTE : (context) => SignupRoute(),
      ACCOUNT_ROUTE : (context) => AccountRoute(),
      DEMO_ROUTE : (context) => DemoRoute(),
      ABOUT_ROUTE : (context) => AboutRoute(),
      PRIVACY_POLICY_ROUTE : (context) => PrivacyPolicyRoute(),
      USER_AGREEMENT_ROUTE : (context) => UserAgreementRoute(),
    
    };
  }

}