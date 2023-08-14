import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/model/product_model/products_model.dart';
import 'package:my_electronic_shop/services/api_services.dart';
import 'package:my_electronic_shop/services/internet_checker.dart';
import 'package:my_electronic_shop/utilities/constants/api_constant.dart';

import '../../utilities/common_widget/common_snackbar.dart';

enum ReturnPolicy { yes, no }

class EditProductController extends GetxController {
  Rx<ReturnPolicy?> returnPolicy = ReturnPolicy.no.obs;

  final formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> etProductName = TextEditingController().obs;
  Rx<TextEditingController> etProductPrice = TextEditingController().obs;
  Rx<TextEditingController> etProductRate = TextEditingController().obs;
  Rx<TextEditingController> etProductDiscount = TextEditingController().obs;
  Rx<TextEditingController> etProductCategory = TextEditingController().obs;

  RxString currentSelectedCategory = "".obs;
  RxBool isDataLoaded = false.obs;

  RxList serviceCenterList = [].obs;
  RxList<String> productCategoryList = <String>[].obs;
  var productId;

  @override
  void onInit() {
    productId = Get.arguments;
    makeServiceCenterList();
    init();
    super.onInit();
  }

  Future<void> init() async {
    await getProductApi();
    await getProductCategories();
  }

  void makeServiceCenterList() {
    serviceCenterList
        .add(ServiceCenter(serviceCenterName: "Mumbai", isChecked: true.obs));
    serviceCenterList.add(
        ServiceCenter(serviceCenterName: "Bengaluru", isChecked: false.obs));
    serviceCenterList.add(
        ServiceCenter(serviceCenterName: "Ahmedabad", isChecked: true.obs));
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

  Future<void> getProductApi() async {
    bool? isInternetAvailable =
        await CheckInternetConnection().getInternetStatus();
    if (isInternetAvailable == true) {
      var url = "${ApiConstants.mainUrl}/$productId";
      dynamic mainList = await ApiServices().getApi(url: url);
      if (mainList != null) {
        etProductName.value.text = mainList['title'] ?? "";
        etProductPrice.value.text = mainList['price'].toString();
        etProductRate.value.text = mainList['rating'].toString();
        etProductDiscount.value.text =
            mainList['discountPercentage'].toString();
        currentSelectedCategory.value = mainList['category'] ?? "";
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

  Future<void> updateProductApi() async {
    bool? isInternetAvailable =
        await CheckInternetConnection().getInternetStatus();
    if (isInternetAvailable == true) {
      var url = "${ApiConstants.mainUrl}/$productId";
      Map<String, dynamic> jsonBody = {
        "title": etProductName.value.text,
        "price": etProductPrice.value.text,
        "rating": etProductRate.value.text,
        "category": currentSelectedCategory.value,
        "discountPercentage": etProductDiscount.value.text,
      };
      dynamic mainList =
          await ApiServices().putApi(url: url, jsonBody: jsonBody);
      if (mainList != null) {
        Get.back();
        CommonSnackBar.showSnackBar(
            title: "Updated Successfully.",
            message: "Product Updated Successfully.");
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
