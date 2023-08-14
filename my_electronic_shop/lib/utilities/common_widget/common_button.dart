import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_text_widget.dart';
import 'package:my_electronic_shop/utilities/constants/color_constant.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  void Function()? onClick;
  double? buttonWidth;
  double? buttonTextSize;

  CommonButton(
      {super.key, required this.buttonText, this.onClick, this.buttonWidth, this.buttonTextSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: buttonWidth ?? Get.width * 0.4,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                backgroundColor: ColorConstant.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                elevation: 1),
            onPressed: onClick,
            child: CommonTextWidget(
              textSize: buttonTextSize ?? 15.sp,
              fontColor: Colors.white,
              text: buttonText,
            )));
  }
}
