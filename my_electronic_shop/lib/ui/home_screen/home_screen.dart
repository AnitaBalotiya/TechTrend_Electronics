import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/model/product_model/products_model.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_appbar.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_text_widget.dart';
import 'package:my_electronic_shop/utilities/constants/color_constant.dart';
import 'package:my_electronic_shop/utilities/constants/string_constant.dart';
import 'package:my_electronic_shop/utilities/routes/route_constant.dart';

import '../../controller/home_controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { return false; },
      child: Scaffold(
        appBar:
            CommonAppBar(title: StringConstant.appName, fontSize: 16.sp, isLogout: true).appBar(),
        body: _bodyUI(),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
          child: InkWell(
            onTap: () => Get.toNamed(RouteConstants.addProductScreen),
              child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: ColorConstant.primaryColor,
                  child: const Icon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                  ))),
        ),
      ),
    );
  }

  Widget _bodyUI() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: Obx(
          () => _controller.isDataLoaded.value
              ? Column(
                  children: [_productList()],
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  Widget _productList() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: _controller.productList.length,
      itemBuilder: (context, index) {
        return _productListContent(
            productModel: _controller.productList[index]);
      },
    );
  }

  Widget _productListContent({required ProductModel productModel}) {
    return Card(
      color: ColorConstant.cardColor,
      elevation: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        text: "Name",
                        textSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CommonTextWidget(
                        text: productModel.productTitle,
                        textSize: 12.sp,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Get.toNamed(RouteConstants.editProductScreen,
                          arguments: productModel.productId)
                      ?.then((_) => _controller.getAllProduct()),
                  child: Icon(FontAwesomeIcons.penToSquare,
                      size: 15.w, color: ColorConstant.textColor),
                )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        text: "Category",
                        textSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CommonTextWidget(
                        text: productModel.productCategory,
                        textSize: 11.sp,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        text: "Price",
                        textSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CommonTextWidget(
                        text: "₹ ${productModel.productPrice}",
                        textSize: 12.sp,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        text: "Rating",
                        textSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CommonTextWidget(
                        text: productModel.productRating,
                        textSize: 12.sp,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        text: "Discount",
                        textSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CommonTextWidget(
                        text: "${productModel.productDesc}%",
                        textSize: 12.sp,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        text: "Return Policy",
                        textSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CommonTextWidget(
                        text: productModel.isReturnPolicy ? "Yes" : "No",
                        textSize: 12.sp,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        text: "Service Center",
                        textSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CommonTextWidget(
                        text: "${productModel.serviceCenters.join(", ")} ",
                        textSize: 12.sp,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
