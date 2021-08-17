import 'package:flutter/material.dart';

class MyConstant {
  static String domain = 'https://40793c92d28d.ngrok.io';
  static String routeHome = '/home';
  static String routeAuthen = '/authen';

  static List<String> menus = [
    'menu1',
    'menu2',
    'menu3',
    'menu4',
    'menu5',
    'menu6',
    'menu7',
    'menu8',
  ];

  static List<Color> colors = [
    Colors.blue,
    Colors.amber,
    Colors.brown,
    Colors.white,
    Colors.cyan,
    Colors.deepPurple,
    Colors.indigo,
    Colors.green,
  ];

  ButtonStyle myButtonStyle({Color? color}) {
    if (color == null) {
      color = Colors.green;
    }
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      primary: color,
    );
  }
}
