import 'package:get/get.dart';

class ProductModel {
  late String productId;
  late String productTitle;
  late String productDesc;
  late String productPrice;
  late String productRating;
  late String productCategory;
  late bool isReturnPolicy;
  late List serviceCenters;

  ProductModel(
      {required this.productId,
      required this.productTitle,
      required this.productDesc,
      required this.productPrice,
      required this.productRating,
      required this.productCategory,
      required this.isReturnPolicy,
      required this.serviceCenters});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['id'].toString();
    productTitle = json['title'] ?? "-";
    productDesc = json['discountPercentage'].toString();
    productPrice = json['price'].toString();
    productRating = json['rating'].toString();
    productCategory = json['category'] ?? "-";
    isReturnPolicy = json[''] ?? false;
    serviceCenters = json[''] ?? ["Mumbai", "Ahmedabad"];
  }
}

class ServiceCenter {
  late String serviceCenterName;
  late RxBool isChecked;

  ServiceCenter({
    required this.serviceCenterName,
    required this.isChecked});
}
