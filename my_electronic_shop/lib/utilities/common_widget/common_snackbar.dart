import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constant.dart';

class CommonSnackBar {
  static void showSnackBar({required title, required message}) {
    Get.snackbar(title, message,
        backgroundColor: ColorConstant.primaryColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }
}
