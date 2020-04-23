import 'package:flutter/material.dart';
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
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "imgs/avatar.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
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
                    title: const Text('Manage accounts'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.ac_unit),
                    title: const Text('Demo'),
                    onTap: () => Navigator.pushNamed(context, Routes.DEMO_ROUTE),
                  ),
                  ListTile(
                    leading: const Icon(Icons.ac_unit),
                    title: const Text('Login'),
                    onTap: () => Navigator.pushNamed(context, Routes.LOGIN_ROUTE),
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
