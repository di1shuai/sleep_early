import 'package:flutter/material.dart';
import 'package:sleep_early/models/device.dart';

class KeyPage extends StatefulWidget {

  @override
  _KeyPageState createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> {
  
  Device d = new Device(id:null, accountId: null,deviceName: null,deviceId: null,platform: null,open: null,time:null);

  final GlobalKey<SwitcherWidgetState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwitcherWidget(
        key: key,d:d
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          key.currentState.changeState();
        },
        child: Text('切换'),
      ),
      
    );
  }
}


class SwitcherWidget extends StatefulWidget {
  
  Device d;

  SwitcherWidget({Key key,this.d}) : super(key: key){
    print(this.d);
  
  }

  @override
  State<StatefulWidget> createState() => SwitcherWidgetState();
}

class SwitcherWidgetState extends State<SwitcherWidget> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Switch.adaptive(
            value: isActive,
            onChanged: (bool currentStatus) {
              isActive = currentStatus;
              setState(() {});
            }),
      ),
    );
  }

  changeState() {
    isActive = !isActive;
    setState(() {});
  }
}

