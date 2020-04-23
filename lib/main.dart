import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'common/global.dart';
import 'views/home.dart';
import 'views/login.dart';

// void main() => Global.init().then((e) => runApp(SleepEarly()));
void main() =>  runApp(SleepEarly());

class SleepEarly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    // MultiProvider(
    //     providers: <SingleChildWidget>[
    //       ChangeNotifierProvider.value(value: AccountModel())
    //     ],
    //     child: Consumer(builder:
    //         (BuildContext context, AccountModel accountModel, Widget child) {
    //       child:
          MaterialApp(
              title: 'Sleep Early',
              theme: ThemeData.dark(),
              darkTheme: ThemeData.dark(),
              home: Home(),
              routes: <String, WidgetBuilder>{
                "login": (context) => LoginRoute()
              });
        // }));

    // return new Power();
    // return NativeApp();
  }
}
