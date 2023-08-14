import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/controller/home_controller/edit_product_controller.dart';
import 'package:my_electronic_shop/model/product_model/products_model.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_appbar.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_button.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_text_field.dart';
import 'package:my_electronic_shop/utilities/common_widget/common_text_widget.dart';

import '../../utilities/constants/color_constant.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({super.key});

  final EditProductController _controller = Get.put(EditProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Edit Product", isBack: true).appBar(),
      body: _bodyUI(),
    );
  }

  Widget _bodyUI() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: Obx(() => _controller.isDataLoaded.value
            ? Column(
                children: [
                  SizedBox(height: 10.h,),
                  _editProduct(),
                  SizedBox(
                    height: 20.h,
                  ),
                  _saveButton()
                ],
              )
            : const SizedBox()),
      ),
    );
  }

  Widget _editProduct() {
    return Form(
        key: _controller.formKey.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextField(
                textEditingController: _controller.etProductName.value,
                hintText: "",
                textInputType: TextInputType.text,
                validatorFunction: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return "Required Field.";
                  }
                  return null;
                },
                labelText: "Product Name"),
            SizedBox(
              height: 20.h,
            ),
            CommonTextField(
                textEditingController: _controller.etProductPrice.value,
                hintText: "",
                textInputType: TextInputType.number,
                validatorFunction: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return "Required Field.";
                  }
                  return null;
                },
                labelText: "Product Price"),
            SizedBox(
              height: 20.h,
            ),
            CommonTextField(
                textEditingController: _controller.etProductRate.value,
                hintText: "",
                textInputType: TextInputType.number,
                validatorFunction: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return "Required Field.";
                  }
                  return null;
                },
                labelText: "Product Rate"),
            SizedBox(
              height: 20.h,
            ),
            CommonTextField(
                textEditingController: _controller.etProductDiscount.value,
                hintText: "",
                textInputType: TextInputType.number,
                labelText: "Product Discount"),
            SizedBox(
              height: 20.h,
            ),
            _productCategory(),
            SizedBox(
              height: 20.h,
            ),
            CommonTextWidget(text: "Service Center", textSize: 15.sp),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                      spacing: 10.w,
                      runAlignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      children: [
                        for (var element in _controller.serviceCenterList)
                          _serviceCenter(serviceCenter: element)
                      ]),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            _checkReturnPolicy(),
          ],
        ));
  }

  Widget _serviceCenter({required ServiceCenter serviceCenter}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: 6.w,
              child: Checkbox(
                  side: const BorderSide(color: ColorConstant.primaryColor),
                  activeColor: ColorConstant.primaryColor,
                  value: serviceCenter.isChecked.value,
                  onChanged: (bool? value) {
                    serviceCenter.isChecked.value = value!;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CommonTextWidget(
                  fontWeight: FontWeight.w600,
                  text: serviceCenter.serviceCenterName,
                  textSize: 11.sp),
            )
          ],
        ),
      ),
    );
  }

  Widget _checkReturnPolicy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(text: "Return Policy"),
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          title: const Text('Yes'),
          leading: Radio<ReturnPolicy>(
            value: ReturnPolicy.yes,
            groupValue: _controller.returnPolicy.value,
            onChanged: (ReturnPolicy? value) {
              _controller.returnPolicy.value = value;
              print(value);
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          title: const Text('No'),
          leading: Radio<ReturnPolicy>(
            value: ReturnPolicy.no,
            groupValue: _controller.returnPolicy.value,
            onChanged: (ReturnPolicy? value) {
              _controller.returnPolicy.value = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _productCategory() {
    return InputDecorator(
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r)))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text("Select Category"),
          value: _controller.currentSelectedCategory.value,
          isDense: true,
          onChanged: (String? newValue) {
            _controller.currentSelectedCategory.value = newValue.toString();
          },
          items: _controller.productCategoryList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return CommonButton(
      buttonWidth: 200.w,
      buttonTextSize: 18,
      buttonText: "Save",
      onClick: ()=>_controller.updateProductApi(),
    );
  }
}
