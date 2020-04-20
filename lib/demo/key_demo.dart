import 'package:flutter/material.dart';
import 'package:sleep_early/model/device_card.dart';

class KeyPage extends StatefulWidget {

  @override
  _KeyPageState createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> {
  
  DeviceCardModel d = new DeviceCardModel(null, null, null, null, null);

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
  
  DeviceCardModel d;

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

