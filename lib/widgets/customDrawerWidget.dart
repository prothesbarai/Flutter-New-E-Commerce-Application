import 'package:AppStore/utils/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../pages/other_page/user_profile_page/User_Profile_Page.dart';
import '../providers/user_profile_data_provider.dart';

class Customdrawerwidget extends StatelessWidget {
  const Customdrawerwidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<UserProfileProvider>(context); // 🔄 Listen for updates

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
                        Text(
                          profile.name.isEmpty ? 'No Name' : profile.name.split(" ").first,
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            profile.email.isEmpty ? 'No Email' : profile.email,
                            style: TextStyle(color: AppColor.white, fontSize: 15.sp),
                          ),
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
      IconData icon,
      String title,
      BuildContext context,
      Widget destinationPage,
      ) {
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

        // No need to call loadProfileData manually — provider auto updates the UI
      },
    );
  }
}
