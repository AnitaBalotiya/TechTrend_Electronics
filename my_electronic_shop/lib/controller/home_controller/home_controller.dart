
import 'package:get/get.dart';
import 'package:my_electronic_shop/model/product_model/products_model.dart';
import 'package:my_electronic_shop/services/api_services.dart';
import 'package:my_electronic_shop/services/internet_checker.dart';
import 'package:my_electronic_shop/services/sp_helper.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_snackbar.dart';
import 'package:my_electronic_shop/utilities/constants/api_constant.dart';

class HomeController extends GetxController {
  RxList productList = [].obs;
  RxList serviceCenterList = [].obs;
  RxBool isDataLoaded = false.obs;
  RxString location = "".obs;
  RxString createdBy = "".obs;

  @override
  void onInit() {
    getUserLocation();
    getAllProduct();
    super.onInit();
  }

  Future<void> getUserLocation() async {
    location.value = await SPHelper.getLocation() ?? "-";
    createdBy.value = await SPHelper.getUserName() ?? "-";

  }
  Future<void> getAllProduct() async {
    bool? isInternetAvailable =
        await CheckInternetConnection().getInternetStatus();
    if (isInternetAvailable == true) {
      var url = ApiConstants.mainUrl;
      dynamic mainList = await ApiServices().getApi(url: url);
      if (mainList != null) {
        List<dynamic> list = mainList['products']
            .map((element) => ProductModel.fromJson(element))
            .toList();
        productList.clear();
        for (var element in list) {
          productList.add(element);
        }
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
}
