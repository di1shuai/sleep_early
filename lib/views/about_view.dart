import 'package:flutter/material.dart';
import 'package:sleep_early/common/routes.dart';

class AboutRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
          ),
          Card(
            elevation: 2.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("用户协议"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.USER_AGREEMENT_ROUTE);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text("隐私政策"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.PRIVACY_POLICY_ROUTE);
                  },
                ),
              ],
            ),
          ),

          //2
          Padding(
            padding: const EdgeInsets.all(16.0),
          ),
          Card(
            elevation: 2.0,
            child: Column(
            children: <Widget>[
              ListTile(
                title: Text("检查版本更新"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  print("检查版本更新");
                },
              ),
            ],
          ),),
          //3
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Center(child: Text("Version:")),
            ),
          ),
        ],
      ),
    );
  }
}
