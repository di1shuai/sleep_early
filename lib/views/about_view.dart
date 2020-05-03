
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
          children: <Widget>[
            Container(
              child: Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text("用户协议"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.UserAgreement_ROUTE);
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text("隐私政策"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.PrivacyPolicy_ROUTE);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text("检查版本更新"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        print("检查版本更新");
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Center(child: Text("Version:")),
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
