import 'package:AppStore/utils/AppColor.dart';
import 'package:flutter/material.dart';

class Customfloatingactionbutton extends StatelessWidget {
  const Customfloatingactionbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){},
      backgroundColor: AppColor.pink3,
      shape: CircleBorder(),
      child: Text("0.0",style: TextStyle(color: AppColor.yellowAccent),),
    );
  }
}
