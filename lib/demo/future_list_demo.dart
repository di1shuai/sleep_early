import 'package:flutter/material.dart';
import 'package:sleep_early/api/api.dart';
import 'package:sleep_early/models/device.dart';

class FutureListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FutureListDemo'),
      ),
      body: Center(
        child: FutureList(),
      ),
    );
  }
}

class FutureList extends StatefulWidget {
  @override
  _FutureListState createState() => _FutureListState();
}

class _FutureListState extends State<FutureList> {
  Future<List<Device>> _future;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    _future = API.getDeviceByAccountId(1);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Device>>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // 请求已结束
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          } else {
            // 请求成功，显示数据
            return Text("Contents: ${snapshot.data.toString()}");
          }
        } else {
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      },
    );
  }
}
