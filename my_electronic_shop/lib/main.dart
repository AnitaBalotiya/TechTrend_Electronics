import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/services/location_services.dart';
import 'package:my_electronic_shop/utilities/constants/color_constant.dart';
import 'package:my_electronic_shop/utilities/constants/string_constant.dart';
import 'package:my_electronic_shop/utilities/routes/route_constant.dart';
import 'package:my_electronic_shop/utilities/routes/route_screen.dart';

void main() {
  runApp(const MyApp());
  LocationServices().getGeoLocation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringConstant.appName,
          theme: ThemeData(
            primaryColor: ColorConstant.primaryColor,
            fontFamily: "Times New Roman",
          ),
          initialRoute: RouteConstants.loginScreen,
          getPages: RouteScreen.routes,
        );
      },
    );
  }
}
