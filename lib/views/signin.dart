import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/sign_api.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/common/routes.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/models/enums/identity_type.dart';
import 'package:sleep_early/models/sign.dart';

class SigninRoute extends StatefulWidget {
  @override
  _SigninRouteState createState() => _SigninRouteState();
}

class _SigninRouteState extends State<SigninRoute> {
  TextEditingController _usernameC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();
  TextEditingController _verifiedCodeC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Column(children: [
        new Container(
            padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
            child: SvgPicture.asset("imgs/logo_light.svg",
                width: 200,
                color: Theme.of(context).iconTheme.color,
                semanticsLabel: "Sleep Early")),
        new Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              new Container(
                  decoration: new BoxDecoration(
                      border: new Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 240, 240, 240),
                              width: 1.0))),
                  child: TextField(
                    autofocus: true,
                    controller: _usernameC,
                    decoration: InputDecoration(
                        labelText: "用户名",
                        hintText: "邮箱",
                        prefixIcon: Icon(Icons.person)),
                  )),
              new Container(
                decoration: new BoxDecoration(
                    border: new Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 240, 240, 240),
                            width: 1.0))),
                child: TextField(
                  controller: _passwordC,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                ),
              ),
              new Container(
                height: 45.0,
                margin: EdgeInsets.only(top: 40.0),
                child: new SizedBox.expand(
                  child: new RaisedButton(
                    onPressed: () async {
                      Account account = await SignAPI.signin(Sign(
                          username: _usernameC.text,
                          password: _passwordC.text,
                          identityType: IdentityType.EMAIL));
                      Provider.of<AccountProvider>(context, listen: false)
                          .account = account;
                      Navigator.pushNamedAndRemoveUntil(context,
                          Routes.HOME_ROUTE, (Route<dynamic> route) => false);
                    },
                    color: Color.fromARGB(255, 61, 203, 128),
                    // color: Theme.of(context).accentColor,
                    child: new Text(
                      '登录',
                      style: TextStyle(
                        fontSize: 14.0,
                        // color: Color.fromARGB(255, 255, 255, 255)
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(45.0)),
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 30.0),
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                        child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.SIGNUP_ROUTE);
                      },
                      child: Text(
                        '注册账号',
                        style: TextStyle(
                          fontSize: 13.0,
                          // color: Color.fromARGB(255, 53, 53, 53)
                        ),
                      ),
                    )),
                    FlatButton(
                      onPressed: () {
                        print("跳转");
                      },
                      child: Text(
                        '忘记密码？',
                        style: TextStyle(
                          fontSize: 13.0,
                          // color: Color.fromARGB(255, 53, 53, 53)
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
