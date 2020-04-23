import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/api.dart';
import 'package:sleep_early/common/global.dart';
import 'package:sleep_early/models/account.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('登录')),
        body: Center(
          child: IconButton(
            icon: Icon(Icons.access_alarm),
            onPressed: _onLogin,
          ),
        ));
  }

  void _onLogin() async {
    Account account = await API.login('test', 'test');
    // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
    Provider.of<AccountModel>(context, listen: false).account = account;
    if (account != null) {
      // 返回
      Navigator.of(context).pop();
    }
  }
}
