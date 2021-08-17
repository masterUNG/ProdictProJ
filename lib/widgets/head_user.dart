import 'package:flutter/material.dart';
import 'package:prodictproj/utility/my_constant.dart';

class HeadUser extends StatelessWidget {
  const HeadUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: buildContent(),
    );
  }

  Row buildContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: MyConstant().myButtonStyle(color: Colors.orange),
          onPressed: () {},
          child: Text('หัวหน้า'),
        ),
        SizedBox(
          width: 4,
        ),
        ElevatedButton(style: MyConstant().myButtonStyle(),
          onPressed: () {},
          child: Text('ผู้อำนวยการ'),
        ),
      ],
    );
  }
}
