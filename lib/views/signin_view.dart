import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/sign_api.dart';
import 'package:sleep_early/common/global.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/common/routes.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/models/enums/identity_type.dart';
import 'package:sleep_early/models/sign.dart';
import 'package:sleep_early/widgets/input.dart';

class SigninRoute extends StatefulWidget {
  @override
  _SigninRouteState createState() => _SigninRouteState();
}

class _SigninRouteState extends State<SigninRoute> {
  TextEditingController _usernameC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();

  @override
  void dispose() {
    _usernameC?.dispose();
    _passwordC?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = new Container(
        padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
        child: SvgPicture.asset("imgs/logo_light.svg",
            width: 100,
            color: Theme.of(context).iconTheme.color,
            semanticsLabel: "Sleep Early"));

    final usernameT = UsernameT(controller: _usernameC);

    final passwordT = PasswordT(
      controller: _passwordC,
    );

    final agreementT =  AgreementT();

    final signinB = Builder(builder: (context) {
      return new RaisedButton(
        onPressed: () async {
          if (Form.of(context).validate()) {
            Account account = await SignAPI.signin(Sign(
                username: _usernameC.text.trim(),
                password: _passwordC.text.trim(),
                identityType: IdentityType.EMAIL));
            Provider.of<AccountProvider>(context, listen: false).account =
                account;
            if (account != null) {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.HOME_ROUTE, (Route<dynamic> route) => false);
            }
          } else {
            EasyLoading.showError("请输入正确格式的信息",
                duration: Duration(seconds: Global.showDialogTime));
          }
        },
        color: Color.fromARGB(255, 61, 203, 128),
        child: new Text(
          '登录',
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(45.0)),
      );
    });

    final signupB = FlatButton(
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.SIGNUP_ROUTE);
      },
      child: Text(
        '注册账号',
        style: TextStyle(
          fontSize: 13.0,
        ),
      ),
    );

    final findB = FlatButton(
      onPressed: () {
        EasyLoading.showInfo("暂不支持", duration: Duration(seconds: Global.showDialogTime));
      },
      child: Text(
        '忘记密码？',
        style: TextStyle(
          fontSize: 13.0,
          // color: Color.fromARGB(255, 53, 53, 53)
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("登录"),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Form(
          autovalidate: false,
          child: Column(children: [
            logo,
            new Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  usernameT,
                  passwordT,
                  agreementT,
                  new Container(
                    height: 45.0,
                    margin: EdgeInsets.only(top: 40.0),
                    child: SizedBox.expand(child: signinB),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 30.0),
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[signupB, findB],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )));
  }
}
