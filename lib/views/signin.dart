import 'package:flutter/material.dart';
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
  TextEditingController _unameController = TextEditingController();
  TextEditingController _upassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Column(children: [
        TextField(
          autofocus: true,
          controller: _unameController,
          decoration: InputDecoration(
              labelText: "用户名",
              hintText: "邮箱",
              prefixIcon: Icon(Icons.person)),
        ),
        TextField(
          controller: _upassController,
          decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              prefixIcon: Icon(Icons.lock)),
          obscureText: true,
        ),
        Text(_unameController.text),
        Text(_upassController.text),
        FlatButton(
          onPressed: () async {
            Account account =
                await SignAPI.signin(Sign(username:_unameController.text, password:_upassController.text,identityType:IdentityType.EMAIL));
            Provider.of<AccountProvider>(context, listen: false).account =
                account;
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.HOME_ROUTE, (Route<dynamic> route) => false);
          },
          child: Text('登录'),
        ),
      ]),
    );
  }
}
