import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prodictproj/models/user_model.dart';
import 'package:prodictproj/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildUser(constraints),
                  buildPassword(constraints),
                  buildLogin(constraints),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildUser(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.6,
      child: TextFormField(
        controller: userController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill User';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.perm_identity),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Container buildPassword(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: constraints.maxWidth * 0.6,
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Password';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Container buildLogin(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.6,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            String user = userController.text;
            String password = passwordController.text;
            print('## user = $user, password = $password');

            checkAuthen(user, password);
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Future<Null> checkAuthen(String user, String password) async {
    String apiCheckAuthen =
        'https://www.androidthai.in.th/bigc/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiCheckAuthen).then((value) async {
      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(item);
          if (password == model.password) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('type', model.type);
            preferences.setString('name', model.name);
            Navigator.pushNamedAndRemoveUntil(
                context, MyConstant.routeHome, (route) => false);
          } else {
            Fluttertoast.showToast(msg: 'Password False');
          }
        }
      } else {
        Fluttertoast.showToast(msg: 'User False');
      }
    });
  }
}
