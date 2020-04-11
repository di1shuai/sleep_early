import 'package:flutter/material.dart';
import 'device_card.dart';
import 'package:sleep_early/model/device_card.dart';

class Header extends StatelessWidget {
  Header({this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      onPressed: null,
                      disabledColor: Theme.of(context).accentColor),
                ),
                Expanded(
                  flex: 15,
                  child: new Center(child: title),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).iconTheme.color
                      ),
                      tooltip: 'Search',
                      onPressed: null,
                      disabledColor: Theme.of(context).accentColor),
                )
              ])),
          Expanded(flex: 1, child: DeviceCard('全部设备', null, false, '22:30')),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List items = DeviceCardModel.data();

    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Header(
              title: Text(
                'Sleep Early',
                style: Theme.of(context).primaryTextTheme.title,
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: new ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return new ListTile(
                      title: new SizedBox(
                          height: 70.0, //设置高度
                          child: new Card(
                              color: Theme.of(context).cardTheme.color,
                              elevation: 15.0, //设置阴影
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))), //设置圆角
                              child: new DeviceCard(
                                  items[index].deviceName,
                                  items[index].icon,
                                  items[index].switchValue,
                                  items[index].time))));
                },
              ))
        ],
      ),
    );
  }
}
