import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SVG Demo"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SvgPicture.asset("imgs/logo_light.svg",
                color: Theme.of(context).accentColor, semanticsLabel: 'logo_light'),
            SvgPicture.asset("imgs/logo.svg",
            width: 100,
                color: Theme.of(context).accentColor, semanticsLabel: 'logo')
          ],
        ),
      ),
    );
  }
}
