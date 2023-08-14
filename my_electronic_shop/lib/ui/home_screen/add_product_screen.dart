import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_electronic_shop/controller/home_controller/add_product_controller.dart';

import '../../controller/home_controller/edit_product_controller.dart';
import '../../model/product_model/products_model.dart';
import '../../utilities/common_widget/common_appbar.dart';
import '../../utilities/common_widget/common_button.dart';
import '../../utilities/common_widget/common_text_field.dart';
import '../../utilities/common_widget/common_text_widget.dart';
import '../../utilities/constants/color_constant.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final AddProductController _controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Add Product", isBack: true).appBar(),
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
                  SizedBox(
                    height: 10.h,
                  ),
                  _addProduct(),
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

  Widget _addProduct() {
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
                labelText: "Rating"),
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
                        for (int i = 0;
                            i < _controller.serviceCenterList.length;
                            i++)
                          _serviceCenter(
                              serviceCenter: _controller.serviceCenterList[i],
                              index: i)
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

  Widget _serviceCenter(
      {required ServiceCenter serviceCenter, required int index}) {
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
                    if (serviceCenter.isChecked.value) {
                      _controller.serviceCenterList[index].isChecked = true.obs;
                    } else {
                      _controller.serviceCenterList[index].isChecked =
                          false.obs;
                    }
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
              _controller.isReturnPolicy.value =
                  value.toString().split(".").last;
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
              _controller.isReturnPolicy.value =
                  value.toString().split(".").last;
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
      buttonText: "Add",
      onClick: () => {
        if (_controller.formKey.value.currentState!.validate())
          {_controller.addProduct()}
      },
    );
  }
}
