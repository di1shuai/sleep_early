import 'package:flutter/material.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global{

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {

    
  }

}