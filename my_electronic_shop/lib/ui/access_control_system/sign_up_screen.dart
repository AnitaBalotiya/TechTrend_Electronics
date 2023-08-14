import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/controller/access_control_system/sign_up_controller.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_text_widget.dart';

import '../../utilities/common_widget/common_appbar.dart';
import '../../utilities/common_widget/common_button.dart';
import '../../utilities/common_widget/common_text_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupController _controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Signup", isBack: true).appBar(),
      body: _bodyUI(),
    );
  }

  Widget _bodyUI() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            _signupForm()
          ],
        ),
      ),
    );
  }

  Widget _signupForm() {
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
                if (value.length != 8) {
                  return "Password should be 8 Character long";
                }
                return null;
              },
              textEditingController: _controller.etPassword.value,
              hintText: "",
              maxLength: 8,
              labelText: "Password",
              isPassword: true,
            ),
            SizedBox(
              height: 30.h,
            ),
            CommonTextField(
              validatorFunction: (value) {
                if (value == null || value.isEmpty || value.trim().isEmpty) {
                  return "Required Field.";
                }
                if (_controller.etPassword.value.text != value) {
                  return "Password doesn't match";
                }
                return null;
              },
              maxLength: 8,
              textEditingController: _controller.etConfirmPassword.value,
              hintText: "",
              labelText: "Confirm Password",
              isPassword: true,
            ),
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
              textInputType: TextInputType.emailAddress,
              textEditingController: _controller.etEmailId.value,
              hintText: "",
              labelText: "Email",
            ),
            SizedBox(
              height: 30.h,
            ),
            CommonTextField(
              validatorFunction: (value) {
                if (value == null || value.isEmpty || value.trim().isEmpty) {
                  return "Required Field.";
                }
                if (value.length != 10) {
                  return "Password should be 10 Character long";
                }
                return null;
              },
              textEditingController: _controller.etContactNo.value,
              hintText: "",
              maxLength: 10,
              textInputType: TextInputType.phone,
              labelText: "Phone Number",
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            _loginButton(),
          ],
        ));
  }

  Widget _loginButton() {
    return Column(
      children: [
        CommonButton(
          buttonWidth: Get.width * 0.7,
          buttonText: "Signup",
          onClick: () => _controller.validateForm(),
        ),
        SizedBox(
          height: 5.h,
        ),
        InkWell(
            onTap: () => Get.back(),
            child: CommonTextWidget(text: "Already member? Click here"))
      ],
    );
  }
}
