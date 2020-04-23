import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/api.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/models/account.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
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
              hintText: "用户名或邮箱",
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
                await API.login(_unameController.text, _upassController.text);
            print(account);
            Provider.of<AccountProvider>(context, listen: false).account =
                account;
          },
          child: Text('登录'),
        ),
      ]),
    );
  }
}
