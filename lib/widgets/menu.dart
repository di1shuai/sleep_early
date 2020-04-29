import 'package:flutter/material.dart';
import 'package:sleep_early/api/account_api.dart';
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
              padding: const EdgeInsets.only(top: 38.0),
              child: ListTile(
                leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "imgs/avatar.png",
                        width: 80,
                      ),
                    ),
                  ),
                title: Text(
                    AccountAPI.currentAccount(context).nickname,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

              ),
          
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage devices'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.ac_unit),
                    title: const Text('Demo'),
                    onTap: () => Navigator.of(context).pushNamed( Routes.DEMO_ROUTE),
                  ),
                  ListTile(
                    leading: const Icon(Icons.ac_unit),
                    title: const Text('Signin'),
                    onTap: () => Navigator.of(context).pushNamed( Routes.SIGNIN_ROUTE),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
