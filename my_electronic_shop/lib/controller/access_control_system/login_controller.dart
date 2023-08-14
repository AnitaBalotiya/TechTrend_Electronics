import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/services/sp_helper.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_snackbar.dart';

import '../../utilities/routes/route_constant.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> etName = TextEditingController().obs;
  Rx<TextEditingController> etPassword = TextEditingController().obs;

  String adminUsername = "admin";
  String adminPassword = "admin@123";
  RxBool isAdminLogin = false.obs;

  @override
  void onInit() {
    clearTextBox();
    super.onInit();
  }

  void clearTextBox() {
    etName.value.clear();
    etPassword.value.clear();
  }

  Future<void> validateForm() async {
    var username = await SPHelper.getUserName();
    var password = await SPHelper.getUserPassword();
    log(username!);
    log(password!);
    if (etName.value.text == adminUsername &&
        etPassword.value.text == adminPassword) {
      Get.toNamed(RouteConstants.productListScreen);
    }
    if (formKey.value.currentState!.validate()) {
      if (etName.value.text == adminUsername &&
          etPassword.value.text == adminPassword) {
        Get.toNamed(RouteConstants.productListScreen);
        isAdminLogin.value = true;
      }

      if (!isAdminLogin.value) {
        if (etName.value.text != username &&
            etPassword.value.text != password) {
          CommonSnackBar.showSnackBar(
              title: "User Not Found.",
              message: "Please check your credentials.");
        } else if (etName.value.text != username) {
          CommonSnackBar.showSnackBar(
              title: "User Not Found.", message: "Please check your username.");
        } else if (etPassword.value.text != password) {
          CommonSnackBar.showSnackBar(
              title: "User Not Found.", message: "Please check your password.");
        } else if (etName.value.text == username &&
            etPassword.value.text == password) {
          Get.toNamed(RouteConstants.homeScreen);
        }
      }
    }
  }
}
