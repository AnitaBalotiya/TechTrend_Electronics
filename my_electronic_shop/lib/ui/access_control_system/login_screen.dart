import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/controller/access_control_system/login_controller.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_appbar.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_button.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_text_field.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_text_widget.dart';
import 'package:my_electronic_shop/utilities/routes/route_constant.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Login").appBar(),
      body: _bodyUI(),
    );
  }

  Widget _bodyUI() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            _welcome(),
            SizedBox(
              height: Get.height * 0.35,
            ),
            _loginForm()
          ],
        ),
      ),
    );
  }

  Widget _welcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonTextWidget(text: "Welcome!", textSize: 18.sp),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: CommonTextWidget(
              text: "Kindly enter your credentials to continue!",
              textSize: 13.sp,
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Form(
        key: _controller.formKey.value,
        child: Column(
          children: [
            CommonTextField(
                validatorFunction: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return "Required Field.";
                  }
                  return null;
                },
                textEditingController: _controller.etName.value,
                hintText: "",
                labelText: "Username"),
            SizedBox(
              height: 30.h,
            ),
            CommonTextField(
              validatorFunction: (value) {
                if (value == null || value.isEmpty || value.trim().isEmpty) {
                  return "Required Field.";
                }
                return null;
              },
              textEditingController: _controller.etPassword.value,
              hintText: "",
              labelText: "Password",
              isPassword: true,
            ),
            SizedBox(
              height: 30.h,
            ),
            _loginButton()
            // CommonButton(
            //   buttonText: "Login",
            //   onClick: () => _controller.validateForm(),
            // )
          ],
        ));
  }

  Widget _loginButton() {
    return Column(
      children: [
        CommonButton(
          buttonTextSize: 18.sp,
          buttonWidth: Get.width * 0.6,
          buttonText: "Login",
          onClick: () => _controller.validateForm(),
        ),
        SizedBox(
          height: 3.h,
        ),
        InkWell(
            onTap: () => Get.toNamed(RouteConstants.signupScreen)
                ?.then((_) => _controller.clearTextBox()),
            child: CommonTextWidget(
              text: "Not a member? Click here",
              fontWeight: FontWeight.w600,
            ))
      ],
    );
  }
}
