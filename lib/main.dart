import 'package:AppStore/pages/splash_screen_page/splashScreen.dart';
import 'package:AppStore/providers/user_profile_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Hive.init Crushed Purpose
  final dir = await getApplicationSupportDirectory(); // path provider give a local storage path
  Hive.init(dir.path); // This Location Store Data
  await Hive.openBox('localStorage'); // local storage Database name
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProfileProvider()), // ✅ Inject provider
      ],
      child: const MyApp(),
    ),
  );
}

// Stateless Widget For Homepage
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Splashscreen(),
        );
      },
    );
  }

}





