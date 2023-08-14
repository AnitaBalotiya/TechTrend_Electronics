import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_text_widget.dart';
import 'package:my_electronic_shop/utilities/routes/route_constant.dart';

import '../constants/color_constant.dart';

class CommonAppBar {
  final String title;
  Color? bgColor;
  double? fontSize;
  bool? isBack;
  bool? isLogout;

  CommonAppBar(
      {required this.title,
      this.bgColor,
      this.isBack,
      this.fontSize,
      this.isLogout});

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: bgColor ?? ColorConstant.primaryColor,
      centerTitle: false,
      leadingWidth: 25.w,
      automaticallyImplyLeading: isBack ?? false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonTextWidget(
              text: title,
              fontColor: Colors.white,
              textSize: fontSize ?? 18.sp),
          isLogout ?? false
              ? InkWell(
                  onTap: () => Get.offAllNamed(RouteConstants.loginScreen),
                  child: const Icon(Icons.logout_outlined))
              : const SizedBox()
        ],
      ),
    );
  }
}
