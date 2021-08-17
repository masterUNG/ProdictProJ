import 'package:flutter/material.dart';

class HeadAdmin extends StatelessWidget {
  const HeadAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Head Admin',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
