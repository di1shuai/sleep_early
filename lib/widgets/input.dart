import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Widget child;

  Input({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(
            border: new Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 240, 240, 240), width: 1.0))),
        child: child);
  }
}
