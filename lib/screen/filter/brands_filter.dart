// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/presentation/check_box_list_tile/check_box_list_tile_widget.dart';
import 'package:ozone_london/presentation/expansion_tile/expansion_tile_widget.dart';

class BrandsFilter extends StatefulWidget {
  const BrandsFilter({Key? key}) : super(key: key);

  @override
  State<BrandsFilter> createState() => _BrandsFilterState();
}

class _BrandsFilterState extends State<BrandsFilter> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductListController>(),
      builder: (controller) {
        return ExpansionTileWidget(
          title: 'brands'.tr,
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CheckboxListTileWidget(
                      value: controller.abbyCheckbox,
                      title: 'Abby',
                      onChanged: (val) {
                        controller.abbyCheckbox = val;
                        controller.update();
                      },
                    );
                  },
                )
              ],
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
