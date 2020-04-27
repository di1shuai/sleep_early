import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/sign_api.dart';
import 'package:sleep_early/common/routes.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/models/enums/identity_type.dart';
import 'package:sleep_early/models/sign.dart';

// provider

class ProviderAccount with ChangeNotifier {
  Account _account;

  Account get account => this._account;

  set account(Account account) {
    this._account = account;
    notifyListeners();
  }
}

// Consumer

class IsLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProviderAccount proAccount = Provider.of<ProviderAccount>(context);
    String status = "未登录";
    if (proAccount.account != null) {
      status = "登录：" + proAccount.account.id.toString();
    }
    return Text(status);
  }
}

// modify provider

class UPInput extends StatefulWidget {
  @override
  _UPInputState createState() => _UPInputState();
}

class _UPInputState extends State<UPInput> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _upassController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   //监听输入改变
  //   // _unameController.addListener(() {
  //   //   print("uname -> " + _unameController.text);
  //   //   print("upass -> " + _upassController.text);
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
            labelText: "密码", hintText: "您的登录密码", prefixIcon: Icon(Icons.lock)),
        obscureText: true,
      ),
      Text(_unameController.text),
      Text(_upassController.text),
      FlatButton(
        onPressed: () async {
          Account account =
              await SignAPI.signin(Sign(username: _unameController.text, password:_upassController.text,identityType: IdentityType.EMAIL));
          print(account);
          Provider.of<ProviderAccount>(context, listen: false).account =
              account;
        },
        child: Text('登录'),
      ),
    ]);
  }
}

// UI

class ProviderAccountAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProviderAccount(),
        )
      ],
      child: Consumer<ProviderAccount>(builder: (context, pAccount, _) {
        return MaterialApp(title: 'ProviderAccount Demo', home: ProviderHome());
      }),
    );
  }
}

class ProviderHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ProviderAccount Demo"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            UPInput(),
            IsLogin(),
            FlatButton(
              onPressed: () {
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   Routes.HOME_ROUTE,
                //   (route) => route == null,
                // );
                Navigator.pushNamed(context, Routes.HOME_ROUTE);
              },
              child: Text('Back'),
            )
          ],
        ),
      ),
    );
  }
}
