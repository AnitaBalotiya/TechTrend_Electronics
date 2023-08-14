import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/services/sp_helper.dart';
import 'package:my_electronic_shop/utilities/routes/route_constant.dart';

import '../../services/location_services.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> etName = TextEditingController().obs;
  Rx<TextEditingController> etPassword = TextEditingController().obs;
  Rx<TextEditingController> etConfirmPassword = TextEditingController().obs;
  Rx<TextEditingController> etEmailId = TextEditingController().obs;
  Rx<TextEditingController> etContactNo = TextEditingController().obs;
  String? location;

  @override
  void onInit() {
    // etName.value.text = "Anita";
    // etPassword.value.text = "anita123";
    // etConfirmPassword.value.text = "anita123";
    // etEmailId.value.text = "anita@gmail.com";
    // etContactNo.value.text = "0876534349";
    super.onInit();
  }

  Future<void> validateForm() async {
    if (formKey.value.currentState!.validate()) {
      SPHelper.setUserName(username: etName.value.text);
      SPHelper.setUserPassword(password: etPassword.value.text);
      SPHelper.setUserEmailId(emailId: etEmailId.value.text);
      SPHelper.setContactNo(contactNo: etContactNo.value.text);
      location = await LocationServices().getGeoLocation();
      log("location $location");
      SPHelper.setLocation(location: location ?? "-");
      Get.offAllNamed(RouteConstants.loginScreen);
    }
  }
}
