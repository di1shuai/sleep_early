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
      print(value);
      print(_deviceList);
      notifyListeners();
    });
  }
}

// consumer
class Title extends StatelessWidget {
  const Title({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<ListDeviceProvider>(context).deviceList.toString());
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
            print("1");
            dList.refresh(context);
            print("2");
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
