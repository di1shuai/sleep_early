import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/sign_api.dart';
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
  bool isShowPassWord = false;

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

    final usernameT = TextField(
      autofocus: true,
      controller: _usernameC,
      decoration: InputDecoration(
          labelText: "用户名", hintText: "邮箱", prefixIcon: Icon(Icons.person)),
    );

    final passwordT = TextField(
      controller: _passwordC,
      decoration: InputDecoration(
          labelText: "密码",
          hintText: "您的登录密码",
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isShowPassWord = !isShowPassWord;
                });
              },
              icon: Icon(
                isShowPassWord ? Icons.visibility_off : Icons.visibility,
              ))),
      obscureText: !isShowPassWord,
    );

    final verifiedCodeT = TextField(
      controller: _verifiedCodeC,
      decoration: InputDecoration(
          labelText: "验证码",
          hintText: "获取到的验证码",
          prefixIcon: Icon(Icons.lock),
          suffixIcon: FlatButton(
            onPressed: () async {
              bool res = await SignAPI.verified(Sign(
                  username: _usernameC.text,
                  identityType: IdentityType.EMAIL)
                  );
              if (res== true){
                print("验证码已发送");
              }
            },
            child: Text("获取验证吗"),
          )),
      obscureText: true,
    );

    final signupB = RaisedButton(
      onPressed: () async {
        Account account = await SignAPI.signup(Sign(
            username: _usernameC.text,
            password: _passwordC.text,
            verifiedCode: _verifiedCodeC.text,
            identityType: IdentityType.EMAIL));
        Provider.of<AccountProvider>(context, listen: false).account = account;
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.HOME_ROUTE, (Route<dynamic> route) => false);
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
      body: Column(children: [
        logo,
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Input(
                child: usernameT,
              ),
              Input(
                child: passwordT,
              ),
              Input(
                child: verifiedCodeT,
              ),
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
    );
  }
}
