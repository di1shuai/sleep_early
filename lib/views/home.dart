import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/api.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/common/routes.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/widgets/menu.dart';
import 'package:sleep_early/widgets/device_card.dart';
import 'package:sleep_early/models/device.dart';
import 'package:sleep_early/widgets/device_dialog.dart';

class Header extends StatelessWidget {
  Header({this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 150.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(Icons.menu,
                            color: Theme.of(context).iconTheme.color),
                        tooltip: 'Navigation menu',
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Menu()),
                          );
                        },
                        disabledColor: Theme.of(context).accentColor),
                  ),
                  Expanded(
                    flex: 15,
                    child: new Center(child: title),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        icon: Icon(Icons.search,
                            color: Theme.of(context).iconTheme.color),
                        tooltip: 'Search',
                        onPressed: null,
                        disabledColor: Theme.of(context).accentColor),
                  )
                ])),
            // Expanded(flex: 1, child: DeviceCard('全部设备', null, false, '22:30')),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Account _account;
  List<Device> _devices;

  Future<List<Device>> _devicesFuture;
  Future<Account> _accountFuture;

  @override
  void initState() {
    // init();
    super.initState();
  }

  Future<void> init() async {
    _account = await API.getAccount(1);
    // _accountFuture = API.getAccount(1);
    // print(_account);
    _devicesFuture = API.getDeviceByAccountId(1);
    // _devicesFuture = API.getDeviceList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SleepEarly'),
      ),
      drawer: Menu(),
      body: Center(),
    );

    // Material(
    //   color: Theme.of(context).backgroundColor,
    //   child: Column(
    //     children: <Widget>[
    //       Expanded(
    //         flex: 1,
    //         child: Header(
    //           title: Text(
    //             'Sleep Early',
    //             style: Theme.of(context).primaryTextTheme.headline6,
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //           flex: 4,
    //           child: FutureBuilder<List>(
    //               future: _devicesFuture,
    //               builder: (context, snapshot) {
    //                 if (snapshot.connectionState == ConnectionState.done) {
    //                   if (snapshot.hasData) {
    //                     return ListView(
    //                       children: snapshot.data.map((device) {
    //                         return ListTile(
    //                             title: SizedBox(
    //                                 height: 60.0, //设置高度
    //                                 child: Card(
    //                                     color:
    //                                         Theme.of(context).cardTheme.color,
    //                                     elevation: 15.0, //设置阴影
    //                                     shape: const RoundedRectangleBorder(
    //                                         borderRadius: BorderRadius.all(
    //                                             Radius.circular(10.0))), //设置圆角
    //                                     child: DeviceCard(
    //                                         device.deviceName,
    //                                         device.platform,
    //                                         device.open,
    //                                         device.time))));
    //                       }).toList(),
    //                     );
    //                   } else if (snapshot.hasError) {
    //                     return Text("${snapshot.error}");
    //                   }
    //                 } else {
    //                   // By default, show a loading spinner.
    //                   return CircularProgressIndicator();
    //                 }
    //               })),
    //       Expanded(
    //         flex: 1,
    //         child: IconButton(
    //           icon: Icon(
    //             Icons.access_time,
    //             color: Theme.of(context).iconTheme.color,
    //           ),
    //           onPressed: () async {
    //             bool isCreate = await showCreateDialog(context);
    //             if (isCreate == null) {
    //               print('取消');
    //             } else {
    //               setState(() => {});
    //               print('刷新');
    //             }
    //           },
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SleepEarly'),
      ),
      drawer: Menu(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (API.isLogin(context)) {
      //已登录，则展示项目列表
      return FutureBuilder<List<Device>>(
          future: API.getDeviceByAccountId(API.currentAccount(context).id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView(
                    children: snapshot.data.map((device) {
                  DeviceCard(device: device);
                }).toList());
              }
            }
          });
    } else {
      //未登录
      return Center(
        child: RaisedButton(
          child: Text('登录'),
          onPressed: () => Navigator.of(context).pushNamed(Routes.LOGIN_ROUTE),
        ),
      );
    }
  }
}

class IsLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountProvider proAccount = Provider.of<AccountProvider>(context);
    String status = "未登录";
    if (proAccount.account != null) {
      status = "登录：" + proAccount.account.id.toString();
    }
    return Text(status);
  }
}
