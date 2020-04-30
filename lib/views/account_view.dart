import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/account_api.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/widgets/input.dart';

class AccountRoute extends StatefulWidget {
  @override
  _AccountRouteState createState() => _AccountRouteState();
}

class _AccountRouteState extends State<AccountRoute> {
  Account _account;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, accountP, child) {
      _account = accountP.account;

      return Scaffold(
        appBar: AppBar(
          title: Text("个人信息"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0, bottom: 30),
              child: ListTile(
                  leading: Text("头像"),
                  trailing: ClipOval(
                    child: Image.asset(
                      "imgs/avatar.png",
                      width: 80,
                    ),
                  ),
                  onTap: () {
                    print(accountP.account.id);
                  }),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                      leading: const Text("昵称"),
                      trailing: Text(accountP.account.nickname),
                      onTap: () async {
                        var nickname = await showNicknameDialog(
                            context, accountP.account.nickname);
                        if (nickname != null) {
                          _account.nickname = nickname;
                          Account account = await AccountAPI.updateAccount(_account);
                          if(account != null){
                            accountP.account = account;
                          }
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<String> showNicknameDialog(BuildContext context, String oldNickname) {
    TextEditingController _nicknameC = TextEditingController();

    final content = SizedBox(
      width: 300,
      child: Form(
          child: NicknameT(
        controller: _nicknameC,
        oldNickname: oldNickname,
      )),
    );

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("昵称"),
          content: content,
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(null),
            ),
            FlatButton(
              child: Text("更新"),
              onPressed: () async {
                // if (_formKey.currentState.validate()) {
                print(_nicknameC.text);
                Navigator.of(context).pop(_nicknameC.text);
                // }
              },
            ),
          ],
        );
      },
    );
  }
}
