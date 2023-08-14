import 'package:get/get.dart';
import 'package:my_electronic_shop/ui/access_control_system/sign_up_screen.dart';
import 'package:my_electronic_shop/ui/home_screen/add_product_screen.dart';
import 'package:my_electronic_shop/ui/home_screen/edit_product_screen.dart';
import 'package:my_electronic_shop/ui/home_screen/home_screen.dart';
import 'package:my_electronic_shop/ui/home_screen/product_list.dart';
import 'package:my_electronic_shop/utilities/routes/route_constant.dart';

import '../../ui/access_control_system/login_screen.dart';

class RouteScreen {
  static final routes = [
    GetPage(
      name: RouteConstants.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: RouteConstants.signupScreen,
      page: () => SignupScreen(),
    ),
    GetPage(
      name: RouteConstants.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: RouteConstants.productListScreen,
      page: () => ProductListScreen(),
    ),
    GetPage(
      name: RouteConstants.editProductScreen,
      page: () => EditProductScreen(),
    ),
    GetPage(
      name: RouteConstants.addProductScreen,
      page: () => AddProductScreen(),
    ),
  ];
}
