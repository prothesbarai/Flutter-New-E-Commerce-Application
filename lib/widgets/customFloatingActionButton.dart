import 'package:AppStore/pages/homePage.dart';
import 'package:AppStore/utils/AppColor.dart';
import 'package:flutter/material.dart';

class Customfloatingactionbutton extends StatelessWidget {
  final bool isHome;
  const Customfloatingactionbutton({super.key, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isHome ? (){

      }
      : (){
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage(),), (route) => false
        );
      },
      backgroundColor: AppColor.pink3,
      shape: CircleBorder(),
      child: isHome ? Text("0.0",style: TextStyle(color: AppColor.yellowAccent),)
      : Icon(
        Icons.home,
        color: AppColor.yellowAccent,
      ),
    );
  }
}
