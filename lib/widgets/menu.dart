import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/account_api.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/common/routes.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0, bottom: 30),
              child: ListTile(
                leading:
                    // Padding(
                    // padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    // child:
                    ClipOval(
                  child: Image.asset(
                    "imgs/avatar.png",
                    width: 80,
                  ),
                ),
                // ),
                title: Text(
                  AccountAPI.currentAccount(context).nickname,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.ACCOUNT_ROUTE),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.ac_unit),
                    title: const Text('Demo'),
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.DEMO_ROUTE),
                  ),
                  Divider(),
                  ListTile(
                    leading: const Icon(Icons.feedback),
                    title: const Text('反馈'),
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.DEMO_ROUTE),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('关于'),
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.DEMO_ROUTE),
                  ),
                  Divider(),
                  ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('退出'),
                      onTap: () {
                        Provider.of<AccountProvider>(context,listen: false).account = null;
                        Provider.of<DeviceListProvider>(context,listen: false).devices = null;
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.SIGNIN_ROUTE,
                            (Route<dynamic> route) => false);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
