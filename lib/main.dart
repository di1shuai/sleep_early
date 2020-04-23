import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/common/providers.dart';
import 'api/api.dart';
import 'common/routes.dart';

// void main() => Global.init().then((e) => runApp(SleepEarly()));
void main() => runApp(SleepEarly());

class SleepEarly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AccountProvider(),
          )
        ],
        child: Consumer<AccountProvider>(builder: (context, pAccount, _) {
          return MaterialApp(
              title: 'Sleep Early',
              theme: ThemeData.dark(),
              darkTheme: ThemeData.dark(),
              routes: Routes.getRoutesMap(context),
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(builder: (context) {
                  String routeName = settings.name;
                  print("=========!!!!============" + routeName);

                  // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
                  if (routeName != Routes.LOGIN_ROUTE &&
                      !API.isLogin(context)) {
                    routeName = Routes.LOGIN_ROUTE;
                    // 引导用户登录；
                  }
                  // 其它情况则正常打开路由。
                  Navigator.of(context).pushNamed(routeName);
                });
              });
        }));
  }
}
