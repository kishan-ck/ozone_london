import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/presentation/check_box_list_tile/check_box_list_tile_widget.dart';
import 'package:ozone_london/presentation/expansion_tile/expansion_tile_widget.dart';

class SizeFilter extends StatefulWidget {
  const SizeFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<SizeFilter> createState() => _SizeFilterState();
}

class _SizeFilterState extends State<SizeFilter> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductListController>(),
      builder: (controller) {
        return ExpansionTileWidget(
          title: 'size'.tr,
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CheckboxListTileWidget(
                        value: controller.size2Checkbox,
                        title: 'Size 2',
                        onChanged: (val) {
                          controller.size2Checkbox = val;
                          controller.update();
                        });
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
