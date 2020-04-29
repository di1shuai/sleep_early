import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/sign_api.dart';
import 'package:sleep_early/common/keys.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/common/routes.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/models/enums/identity_type.dart';
import 'package:sleep_early/models/sign.dart';
import 'package:sleep_early/widgets/input.dart';

class SignupRoute extends StatefulWidget {
  @override
  _SignupRouteState createState() => _SignupRouteState();
}

class _SignupRouteState extends State<SignupRoute> {
  TextEditingController _usernameC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();
  TextEditingController _verifiedCodeC = TextEditingController();


  @override
  void dispose() {
    _usernameC?.dispose();
    _passwordC?.dispose();
    _verifiedCodeC?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
        padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
        child: SvgPicture.asset("imgs/logo_light.svg",
            width: 200,
            color: Theme.of(context).iconTheme.color,
            semanticsLabel: "Sleep Early"));

    final usernameT = UsernameT(key: Keys.signupUsernameKey,controller: _usernameC);

    final passwordT = PasswordT(controller: _passwordC);

    final verifiedCodeT = TextFormField(
        controller: _verifiedCodeC,
        maxLength: 6,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            labelText: "验证码",
            hintText: "获取到的验证码",
            prefixIcon: Icon(Icons.verified_user),
            suffixIcon: FlatButton(
              padding: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              onPressed: () async {
                if (Keys.signupUsernameKey.currentState.validate()) {
                  bool res = await SignAPI.verified(Sign(
                      username: _usernameC.text.trim(),
                      identityType: IdentityType.EMAIL));
                  if (res == true) {
                    print("验证码已发送");
                  }
                }else{
                  EasyLoading.showError("请输入正确格式的账号信息",
              duration: Duration(milliseconds: 500));
                }
              },
              child: Text("获取验证码"),
            )),
        validator: (value) {
          if (value.trim().isEmpty) {
            return "验证码不能为空";
          } else if (value.trim().length != 6) {
            return "请输入6位验证码";
          }
          return null;
        },
        inputFormatters: [
          // WhitelistingTextInputFormatter(RegExp("[a-z][A-Z][0-9][.]")),      //限制只允许输入字母和数字
          WhitelistingTextInputFormatter.digitsOnly, //限制只允许输入数字
//                    LengthLimitingTextInputFormatter(8),                      //限制输入长度不超过8位
        ]);

    final signupB = RaisedButton(
      onPressed: () async {
        FormState signupForm = Keys.signupFormKey.currentState;
        if (signupForm.validate()) {
          Account account = await SignAPI.signup(Sign(
              username: _usernameC.text,
              password: _passwordC.text,
              verifiedCode: _verifiedCodeC.text,
              identityType: IdentityType.EMAIL));
          Provider.of<AccountProvider>(context, listen: false).account =
              account;
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.HOME_ROUTE, (Route<dynamic> route) => false);
        } else {
          EasyLoading.showError("请输入正确格式的信息",
              duration: Duration(milliseconds: 500));
        }
      },
      color: Color.fromARGB(255, 61, 203, 128),
      // color: Theme.of(context).accentColor,
      child: Text(
        '注册',
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("注册"),
        ),
        body: Form(
          key: Keys.signupFormKey,
          autovalidate: false,
          child: Column(children: [
            logo,
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  usernameT,
                  passwordT,
                  verifiedCodeT,
                  Container(
                    height: 45.0,
                    margin: EdgeInsets.only(top: 40.0),
                    child: SizedBox.expand(
                      child: signupB,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
