import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/common/providers.dart';
import 'common/global.dart';
import 'common/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(SleepEarly()));
}

class SleepEarly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AccountProvider>(
            create: (_) => AccountProvider(),
          ),
          ChangeNotifierProvider<DeviceListProvider>(
            create: (_) => DeviceListProvider(),
          )
        ],
        child: Consumer<AccountProvider>(builder: (context, pAccount, _) {
          return MaterialApp(
              title: 'Sleep Early',
              theme: ThemeData.dark(),
              darkTheme: ThemeData.dark(),
              routes: Routes.getRoutesMap(context));
        }));
  }
}
