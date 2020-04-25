import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/account_api.dart';
import 'package:sleep_early/api/device_api.dart';
import 'package:sleep_early/models/device.dart';
import 'package:sleep_early/widgets/device_card.dart';

// provider
class ListDeviceProvider with ChangeNotifier {
  List<Device> _deviceList;
  List<Device> get deviceList => this._deviceList;

  refresh(BuildContext context) {
    DeviceAPI.getDeviceByAccountId(AccountAPI.currentAccount(context).id)
        .then((value) {
      _deviceList = value;
      notifyListeners();
    });
  }
}

// consumer
class Title extends StatelessWidget {
  const Title({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ListDeviceProvider>(
      builder: (context, dList, child) {
        return ListView.builder(
            itemCount: dList.deviceList.length,
            itemBuilder: (BuildContext context, int index) {
              return DeviceDemo(device: dList._deviceList[index]);
            });
      },
    );
  }
}

class DeviceDemo extends StatelessWidget {
  Device device;
  DeviceDemo({Key key, this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ListDeviceProvider>(builder: (context, dList, child) {
      return Card(
          color: device.isBinding()
              ? Theme.of(context).accentColor
              : Theme.of(context).cardTheme.color,
          elevation: 15.0, //设置阴影
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: SizedBox(
              height: 60.0, //设置高度
              child: SwitchListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(device.deviceName),
                      ),
                      Expanded(
                          flex: 1,
                          child: FlatButton(
                              child: Text(
                                device.time,
                                style:
                                    Theme.of(context).primaryTextTheme.button,
                              ),
                              onPressed:  () async {
                                final TimeOfDay picked = await showTimePicker(
                                    context: context,
                                    initialTime: device.getTimeOfDay());
                                if (picked != null &&
                                    picked != device.getTimeOfDay()) {
                                  device.setTimeOfDay(picked);
                                  print(" time -> ${device.time}");
                                  device = await DeviceAPI.UpdateDevice(device);
                                  dList.refresh(context);
                                }
                                if (picked == null) {
                                  device.setTimeOfDay(
                                      TimeOfDay(hour: 22, minute: 30));
                                  device = await DeviceAPI.UpdateDevice(device);
                                  dList.refresh(context);
                                }
                              }))
                    ],
                  ),
                  value: device.open,
                  secondary: getIcon(context),
                  onChanged: (value) async {
                    device.open = value;
                    await DeviceAPI.UpdateDevice(device);
                    dList.refresh(context);
                  })));
    });
  }

  Icon getIcon(BuildContext context) {
    Icon result;
    switch (device.platform) {
      case 'MACOS':
        result = Icon(Icons.desktop_mac,
            color: Theme.of(context).accentIconTheme.color);
        break;
      case 'WINDOWS':
        result = Icon(Icons.desktop_windows,
            color: Theme.of(context).accentIconTheme.color);
        break;
      case 'LINUX':
        result = Icon(Icons.tablet_mac,
            color: Theme.of(context).accentIconTheme.color);
        break;
      case 'IOS':
        result = Icon(Icons.phone_iphone,
            color: Theme.of(context).accentIconTheme.color);
        break;
      case 'ANDROID':
        result = Icon(Icons.phone_android,
            color: Theme.of(context).accentIconTheme.color);
        break;

      default:
        result = Icon(Icons.device_unknown,
            color: Theme.of(context).iconTheme.color);
    }
    return result;
  }
}

class ListViewDevice extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Consumer<ListDeviceProvider>(builder: (context, dList, _) {
      if (dList.deviceList == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            dList.refresh(context);
          },
          child: ListView.builder(
              itemCount: dList.deviceList.length,
              itemBuilder: (BuildContext context, int index) {
                return DeviceCard(device: dList.deviceList[index]);
              }),
        );
      }
    });
  }
}

// modify provider
class RefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          ListDeviceProvider dl =
              Provider.of<ListDeviceProvider>(context, listen: false);
          dl.refresh(context);
        });
  }
}

// UI

class ListViewDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListDeviceProvider()),
      ],
      child: Consumer<ListDeviceProvider>(
        builder: (context, dList, _) {
          return MaterialApp(
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListViewDemo")),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Title(),
          ),
          Expanded(
            flex: 2,
            child: Center(child: ListViewDevice()),
          ),
        ],
      ),
      floatingActionButton: RefreshButton(),
    );
  }
}
