// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/presentation/check_box_list_tile/check_box_list_tile_widget.dart';
import 'package:ozone_london/presentation/expansion_tile/expansion_tile_widget.dart';

class CategoriesFilter extends StatefulWidget {
  const CategoriesFilter({Key? key}) : super(key: key);

  @override
  State<CategoriesFilter> createState() => _CategoriesFilterState();
}

class _CategoriesFilterState extends State<CategoriesFilter> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductListController>(),
      builder: (controller) {
        return ExpansionTileWidget(
          title: 'categories'.tr,
          children: [
            CheckboxListTileWidget(
              value: controller.allCheckbox,
              title: 'Fashion',
              onChanged: (val) {
                controller.allCheckbox = val;
                controller.update();
              },
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
