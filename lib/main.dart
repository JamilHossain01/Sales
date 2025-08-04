import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Your design size
      minTextAdapt: true,

      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins', // 👈 This applies Poppins globally
            scaffoldBackgroundColor: Colors.black,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),

          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: (context, widget) => widget ?? const SizedBox.shrink(),
          // You can set theme, locale, etc here
        );
      },
    );
  }
}
