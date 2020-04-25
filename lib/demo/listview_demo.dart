import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/widgets/device_card.dart';

class ListViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListViewDemo"),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            DeviceListProvider dl =
                Provider.of<DeviceListProvider>(context, listen: false);
            dl.refresh(context);
          }),
    );
  }

  Widget _buildBody() {
    return Consumer<DeviceListProvider>(builder: (context, dList, _) {
      if (dList.devices == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            dList.refresh(context);
          },
          child: ListView.builder(
              itemCount: null,
              itemBuilder: (BuildContext context, int index) {
                return DeviceCard(device: dList.devices[index]);
              }),
        );
      }
    });
  }
}
