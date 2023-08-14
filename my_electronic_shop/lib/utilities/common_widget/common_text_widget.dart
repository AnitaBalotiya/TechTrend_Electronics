import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_electronic_shop/utilities/constants/color_constant.dart';

class CommonTextWidget extends StatelessWidget {
  final String text;
  double? textSize;
  double? letterSpacing;
  FontWeight? fontWeight;
  Color? fontColor;
  TextAlign? textAlign;

  CommonTextWidget(
      {super.key,
      required this.text,
      this.textAlign,
      this.fontWeight,
      this.textSize,
      this.fontColor,
      this.letterSpacing});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
            letterSpacing: letterSpacing ?? 0,
            color: fontColor ?? ColorConstant.textColor,
            fontSize: textSize ?? 14.sp,
            fontWeight: fontWeight ?? FontWeight.bold));
  }
}
