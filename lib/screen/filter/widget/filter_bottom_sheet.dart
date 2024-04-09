// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/screen/filter/brands_filter.dart';
import 'package:ozone_london/screen/filter/category_filter.dart';
import 'package:ozone_london/screen/filter/color_filter.dart';
import 'package:ozone_london/screen/filter/price_filter.dart';
import 'package:ozone_london/screen/filter/size_filter.dart';
import 'package:ozone_london/screen/filter/widget/hader_filter.dart';

void filterBottomSheet(BuildContext context, ProductListController controller) {
  showModalBottomSheet(
    context: context,
    backgroundColor: whiteColor,
    constraints:
        BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.2),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(25),
        topEnd: Radius.circular(25),
      ),
    ),
    builder: (builder) => StatefulBuilder(
      builder: (context, setState) => ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Container(
                      width: size.width(50),
                      height: size.height(5),
                      decoration: BoxDecoration(
                        color: primaryBlackColor,
                        borderRadius: BorderRadiusDirectional.circular(15),
                      ),
                    ),
                    size.HeightSpace(25),
                    HeaderFilter()
                  ],
                ),
                size.HeightSpace(10),
                CategoriesFilter(),
                BrandsFilter(),
                PriceFilter(),
                SizeFilter(),
                ColorsFilter(),
                size.HeightSpace(30),
                Row(
                  children: [
                    _resetButton(context),
                    size.WidthSpace(15),
                    _applyButton(context),
                  ],
                ),
                size.HeightSpace(30),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _applyButton(BuildContext context) {
  return Expanded(
    flex: 2,
    child: AppButton(
      buttonText: 'apply'.tr,
      onPressed: () {
        Get.back();
      },
    ),
  );
}

Widget _resetButton(BuildContext context) {
  return Expanded(
    child: ElevatedButton(
      onPressed: () {},
      child: Text('reset'.tr,
          style: TextStyle(color: primaryBlackColor, fontSize: 18)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: size.height(15)),
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set the border radius
        ),
      ),
    ),
  );
}
