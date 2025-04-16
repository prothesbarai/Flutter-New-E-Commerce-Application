import 'package:AppStore/utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helper/profile_page_database_helper.dart';
import '../pages/User_Profile_Page.dart';

class Customdrawerwidget extends StatefulWidget {
  const Customdrawerwidget({super.key});

  @override
  State<Customdrawerwidget> createState() => _CustomdrawerwidgetState();
}

class _CustomdrawerwidgetState extends State<Customdrawerwidget> {
  String userName = 'Loading...';
  String userEmail = 'Loading...';

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    final profile = await DatabaseHelper.instance.getUserProfile();
    if (profile != null) {
      setState(() {
        userName = profile['name'] ?? 'No Name';
        userEmail = profile['email'] ?? 'No Email';
      });
    } else {
      setState(() {
        userName = 'No Name Found';
        userEmail = 'No Email Found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.pink1, AppColor.pink2, AppColor.pink3, AppColor.pink1],
            tileMode: TileMode.repeated,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  Icon(Icons.account_circle, color: AppColor.yellowAccent, size: 78.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userName, style: TextStyle(color: AppColor.white, fontSize: 20.sp, fontWeight: FontWeight.bold,),
                        ),
                        SizedBox(height: 2.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(userEmail, style: TextStyle(color: AppColor.white, fontSize: 15.sp),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.edit, 'Edit Profile', context, EditProfilePage()),
            _buildDrawerItem(Icons.layers, 'My Orders', context, EditProfilePage()),
            Divider(color: AppColor.yellowAccent),
            _buildDrawerItem(Icons.card_giftcard, 'Offers', context, EditProfilePage()),
            _buildDrawerItem(Icons.category, 'All Categories', context, EditProfilePage()),
            _buildDrawerItem(Icons.playlist_add_check, 'Shop by Concern', context, EditProfilePage()),
            Divider(color: AppColor.yellowAccent),
            _buildDrawerItem(Icons.shopping_bag, 'Shop by Brands', context, EditProfilePage()),
            _buildDrawerItem(Icons.card_membership, 'Membership Cards', context, EditProfilePage()),
            Divider(color: AppColor.yellowAccent),
            _buildDrawerItem(Icons.location_on, 'Set a Delivery Point', context, EditProfilePage()),
            _buildDrawerItem(Icons.map, 'Covered Areas', context, EditProfilePage()),
            _buildDrawerItem(Icons.store, 'About Paikaree', context, EditProfilePage()),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      IconData icon, String title, BuildContext context, Widget destinationPage) {
    return ListTile(
      leading: Icon(icon, color: AppColor.yellowAccent),
      title: Text(
        title,
        style: TextStyle(color: AppColor.yellowAccent, fontSize: 16.sp),
      ),
      onTap: () async {
        Navigator.pop(context);
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
        // Optional: Drawer এ ফেরত আসলে আবার লোড করাও
        await loadProfileData();
      },
    );
  }
}
