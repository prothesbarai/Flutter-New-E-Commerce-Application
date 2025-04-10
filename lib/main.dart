import 'package:flutter/material.dart';
import 'package:AppStore/pages/EditProfilePage.dart';
import 'package:AppStore/utils/AppColor.dart';
import 'package:AppStore/utils/AppString.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Hive.init Crushed Purpose
  final dir = await getApplicationSupportDirectory(); // path provider give a local storage path
  Hive.init(dir.path); // This Location Store Data
  await Hive.openBox('localStorage'); // local storage Database name
  runApp(const MyApp());
}

// Stateless Widget For Homepage
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}


// State Full Widget For My Home Page
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  static const String email = "example123@gmail.com";
  static const String profileName = "Profile Name";
  bool _isSearching = false;
  TextEditingController _searchingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchingController,
          autofocus: true,
          cursorHeight: 16,
          cursorWidth: 1.5,
          decoration: InputDecoration(
            hintText: AppString.searchHint,
            hintStyle: TextStyle(color: Colors.grey[600],fontSize: 14),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.black),
          onChanged: (value) {

          },
        )
            : Image.asset('assets/logos.png', height: 30,),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.bodyColor, AppColor.bodyColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu,color: AppColor.pink1,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchingController.clear();
                }
              });
            },
            icon: Icon(
              _isSearching ? Icons.close : Icons.search_rounded,
              color: AppColor.pink1,
            ),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart,color: AppColor.pink1,),
            onPressed: () {
              // Notifications action
              print("Notifications button tapped");
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert,color: AppColor.pink1,),
            onSelected: (value) {
              // Handle menu selection
              print("Selected: $value");
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'settings',
                  child: Text(AppString.setting),
                ),
                PopupMenuItem(
                  value: 'logout',
                  child: Text(AppString.logout),
                ),
              ];
            },
          ),
        ],

      ),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.pink1,AppColor.pink2,AppColor.pink3],
              begin: Alignment.topLeft,
              end: Alignment.topRight
            ),
          ),
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Row(
                    children: [
                      Icon(Icons.account_circle,size: 78.0,color: AppColor.yellowAccent,),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(profileName,style: TextStyle(color: AppColor.yellowAccent,fontSize: 20,fontWeight:FontWeight.bold),),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(email,style: TextStyle(color: AppColor.yellowAccent,fontSize: 18,),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
              ),

              _buildDrawerItem(Icons.edit, 'Edit Profile', context, EditProfilePage()),
              _buildDrawerItem(Icons.layers, 'My Orders', context,EditProfilePage()),
              Divider(color: AppColor.yellowAccent),
              _buildDrawerItem(Icons.card_giftcard, 'Offers', context,EditProfilePage()),
              _buildDrawerItem(Icons.category, 'All Categories', context,EditProfilePage()),
              _buildDrawerItem(Icons.playlist_add_check, 'Shop by Concern', context,EditProfilePage()),
              Divider(color: AppColor.yellowAccent,),
              _buildDrawerItem(Icons.shopping_bag, 'Shop by Brands', context,EditProfilePage()),
              _buildDrawerItem(Icons.card_membership, 'Membership Cards', context,EditProfilePage()),
              Divider(color: AppColor.yellowAccent,),
              _buildDrawerItem(Icons.location_on, 'Set a Delivery Point', context,EditProfilePage()),
              _buildDrawerItem(Icons.map, 'Covered Areas', context,EditProfilePage()),
              _buildDrawerItem(Icons.store, 'About Paikaree', context,EditProfilePage()),


            ],
          ),
        ),
      ),


      // Body Start Here
        body: SafeArea(
          child: Column(
            children: [
              // Static Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 25.0),
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    prefixIcon: Icon(Icons.search, color: AppColor.pink1, size: 20),
                    hintText: AppString.searchHint,
                    hintStyle: TextStyle(fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.pink1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.pink1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              // ======================= Content Write Start Here ====================


            ],
          ),
        ),


      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: AppColor.pink3,
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.category, color: Colors.yellowAccent),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.card_membership, color: Colors.yellowAccent),
              onPressed: () {},
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.chat, color: Colors.yellowAccent),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.yellowAccent),
              onPressed: () {},
            ),
          ],
        ),
      ),

      resizeToAvoidBottomInset: false,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColor.pink3,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.yellowAccent),
      ),




    );

  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, Widget destinationPage){
    return ListTile(
      leading: Icon(icon,color: AppColor.yellowAccent,),
      title: Text(title, style: TextStyle(color: AppColor.yellowAccent,fontSize: 16),),
      onTap: (){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => destinationPage,));
      },
    );
  }




}


