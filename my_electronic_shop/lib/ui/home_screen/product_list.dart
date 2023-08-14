import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/home_controller/home_controller.dart';
import '../../model/product_model/products_model.dart';
import '../../utilities/common_widget/common_appbar.dart';
import '../../utilities/common_widget/common_text_widget.dart';
import '../../utilities/constants/color_constant.dart';
import '../../utilities/constants/string_constant.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: CommonAppBar(title: StringConstant.appName, fontSize: 16.sp, isLogout: true)
            .appBar(),
        body: _bodyUI(),
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
                Expanded(
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
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
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
                Expanded(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        text: "Created By",
                        textSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CommonTextWidget(
                        text:
                            "${_controller.createdBy.value}, (${_controller.location.value})",
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
