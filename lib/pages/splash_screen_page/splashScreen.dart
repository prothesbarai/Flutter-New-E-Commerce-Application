import 'dart:async';
import 'package:AppStore/utils/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../homePage.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}
class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), () =>Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => MyHomePage(),)),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pink1,
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("PiFast",style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 44.sp),),
                SizedBox(height: 15.h,),
                CircularProgressIndicator(color: AppColor.white,),
              ],
            ),
          )
      ),
    );
  }
}
