import 'package:flutter/material.dart';
import 'package:prodictproj/states/authen.dart';
import 'package:prodictproj/states/home.dart';
import 'package:prodictproj/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/home': (BuildContext context) => Home(),
  '/authen': (BuildContext context) => Authen(),
};

String? firstState;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print('### type ==>>> $type');
  if (type == null) {
    firstState = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    firstState = MyConstant.routeHome;
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: firstState,
    );
  }
}
