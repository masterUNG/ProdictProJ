import 'package:flutter/material.dart';
import 'package:prodictproj/bodys/menu1.dart';
import 'package:prodictproj/bodys/menu2.dart';
import 'package:prodictproj/bodys/menu3.dart';
import 'package:prodictproj/bodys/menu4.dart';
import 'package:prodictproj/bodys/menu5.dart';
import 'package:prodictproj/bodys/menu6.dart';
import 'package:prodictproj/bodys/menu7.dart';
import 'package:prodictproj/bodys/menu8.dart';
import 'package:prodictproj/utility/my_constant.dart';
import 'package:prodictproj/widgets/head_admin.dart';
import 'package:prodictproj/widgets/head_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String>? menus;
  List<Color>? colors;
  List<Widget> widgets = [
    Menu1(),
    Menu2(),
    Menu3(),
    Menu4(),
    Menu5(),
    Menu6(),
    Menu7(),
    Menu8(),
  ];
  int indexBody = 0;
  bool? adminBool;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menus = MyConstant.menus;
    colors = MyConstant.colors;
    findType();
  }

  Future<Null> findType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String type = preferences.getString('type')!;
    if (type == 'admin') {
      setState(() {
        adminBool = true;
      });
    } else {
      setState(() {
        adminBool = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   actions: [adminBool == null ? SizedBox() : adminBool! ? HeadAdmin() :HeadUser() ],
      // ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.clear().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, MyConstant.routeAuthen, (route) => false));
              },
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          // height: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildHambaker(),
                  adminBool == null ? SizedBox() : adminBool! ? HeadAdmin() :HeadUser(),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              buildListView(),
              widgets[indexBody],
            ],
          ),
        ),
      ),
    );
  }

  IconButton buildHambaker() {
    return IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(Icons.menu));
  }

  Container buildListView() {
    return Container(
      height: 50,
      child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: menus!.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                indexBody = index;
              });
            },
            child: Card(
              color: colors![index],
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 8, bottom: 8),
                child: Center(
                  child: Text(
                    menus![index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
