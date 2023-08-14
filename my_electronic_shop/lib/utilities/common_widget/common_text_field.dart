import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'common_text_widget.dart';

class CommonTextField extends StatelessWidget{
  final TextEditingController textEditingController;
  final TextInputType? textInputType;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validatorFunction;
  RxBool isPasswordIconClicked = false.obs;
  final bool? isPassword;
  final int? maxLength;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Iterable<String>? autofillHints;

  CommonTextField({super.key,
    required this.textEditingController,
    required this.hintText,
    required this.labelText,
    this.textInputType,
    this.validatorFunction,
    this.isPassword,
    this.suffixIcon,
    this.maxLength,
    this.prefixIcon,
    this.autofillHints,
  });


  @override
  Widget build(BuildContext context) {
    return _commonTextField();
  }

  Widget _commonTextField() {
    return Obx(
          () => TextFormField(
        controller: textEditingController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: textInputType,
        maxLength: maxLength,
        obscureText:
        isPassword != null ? _decideObscure() : isPasswordIconClicked.value,
        autofillHints: autofillHints ?? const [AutofillHints.name],
        decoration: InputDecoration(
            label: CommonTextWidget(
              text: labelText,
              textSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            suffixIcon: _suffixIcon(),
            prefixIcon: prefixIcon,
            hintText: hintText,
            isDense: true),
        validator: validatorFunction,
      ),
    );
  }

  bool _decideObscure() {
    if (isPassword == true) {
      if (isPasswordIconClicked.value) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Widget? _suffixIcon() {
    if (suffixIcon != null) {
      return suffixIcon;
    } else if (isPassword == true) {
      return Obx(
            () => InkWell(
            onTap: () =>
            isPasswordIconClicked.value = !isPasswordIconClicked.value,
            child: isPasswordIconClicked.value
                ? const Icon(FontAwesomeIcons.eye)
                : const Icon(FontAwesomeIcons.eyeSlash)),
      );
    }
    return null;
  }


}
