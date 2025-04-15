import 'package:AppStore/utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Custombottomnavbar extends StatelessWidget {
  const Custombottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0.sp,
      color: AppColor.pink3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.category,color: AppColor.yellowAccent,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.card_membership,color: AppColor.yellowAccent,)),
          SizedBox(width: 40.w,),
          IconButton(onPressed: (){}, icon: Icon(Icons.chat,color: AppColor.yellowAccent,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.person,color: AppColor.yellowAccent,)),
        ],
      ),
    );
  }
}
