import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/product_model/products_model.dart';
import '../../services/api_services.dart';
import '../../services/internet_checker.dart';
import '../../utilities/common_widget/common_snackbar.dart';
import '../../utilities/constants/api_constant.dart';
import 'edit_product_controller.dart';

class AddProductController extends GetxController {
  Rx<ReturnPolicy?> returnPolicy = ReturnPolicy.yes.obs;

  final formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> etProductName = TextEditingController().obs;
  Rx<TextEditingController> etProductPrice = TextEditingController().obs;
  Rx<TextEditingController> etProductRate = TextEditingController().obs;
  Rx<TextEditingController> etProductDiscount = TextEditingController().obs;
  Rx<TextEditingController> etProductCategory = TextEditingController().obs;

  RxString currentSelectedCategory = "".obs;
  RxString isReturnPolicy = "".obs;
  RxBool isDataLoaded = false.obs;

  RxList serviceCenterList = [].obs;
  RxList<String> productCategoryList = <String>[].obs;

  @override
  void onInit() {
    makeServiceCenterList();
    getProductCategories();
    super.onInit();
  }
  void makeServiceCenterList() {
    serviceCenterList
        .add(ServiceCenter(serviceCenterName: "Mumbai", isChecked: false.obs));
    serviceCenterList.add(
        ServiceCenter(serviceCenterName: "Bengaluru", isChecked: false.obs));
    serviceCenterList.add(
        ServiceCenter(serviceCenterName: "Ahmedabad", isChecked: false.obs));
  }

  Future<void> getProductCategories() async {
    bool? isInternetAvailable =
        await CheckInternetConnection().getInternetStatus();
    if (isInternetAvailable == true) {
      var url = "${ApiConstants.mainUrl}/categories";
      dynamic mainList = await ApiServices().getApi(url: url);
      if (mainList != null) {
        productCategoryList.clear();
        for (var element in mainList) {
          productCategoryList.add(element);
        }
        currentSelectedCategory.value = productCategoryList[0];
        isDataLoaded.value = true;
      } else {
        CommonSnackBar.showSnackBar(
            title: "Something Went Wrong.",
            message: "Something Went Wrong, please try again later");
      }
    } else {
      CommonSnackBar.showSnackBar(
          title: "Internet Not Available.",
          message: "You're not connected to internet.");
    }
  }

  Future<void> addProduct() async {
    bool? isInternetAvailable =
        await CheckInternetConnection().getInternetStatus();
    if (isInternetAvailable == true) {
      var url = "${ApiConstants.mainUrl}/add";
      Map<String, dynamic> jsonBody = {
        "title": etProductName.value.text,
        "price": etProductPrice.value.text,
        "rating": etProductRate.value.text,
        "category": etProductCategory.value.text,
        "discountPercentage": etProductDiscount.value.text,
      };
      dynamic mainList =
          await ApiServices().postApi(url: url, jsonBody: jsonBody);
      if (mainList != null) {
        log(isReturnPolicy.value);
        Get.back();
        CommonSnackBar.showSnackBar(
            title: "Added Successfully.",
            message: "Product Added Successfully.");
      } else {
        CommonSnackBar.showSnackBar(
            title: "Something Went Wrong.",
            message: "Something Went Wrong, please try again later");
      }
    } else {
      CommonSnackBar.showSnackBar(
          title: "Internet Not Available.",
          message: "You're not connected to internet.");
    }
  }
}
