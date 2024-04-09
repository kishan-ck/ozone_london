// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/presentation/expansion_tile/expansion_tile_widget.dart';
import 'package:ozone_london/screen/filter/widget/text_field_price_widget.dart';

class PriceFilter extends StatefulWidget {
  const PriceFilter({Key? key}) : super(key: key);

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductListController>(),
      builder: (controller) {
        return ExpansionTileWidget(
          title: 'price_range'.tr,
          children: [
            RangeSlider(
              min: controller.minValue,
              max: controller.maxValue,
              activeColor: primaryBlackColor,
              inactiveColor: shadowColor,
              values: RangeValues(controller.starValue, controller.endValue),
              onChanged: (values) {
                controller.starValue = values.start.roundToDouble();
                controller.endValue = values.end.roundToDouble();
                controller.startController.text =
                    values.start.toInt().toString();
                controller.endController.text = values.end.toInt().toString();

                controller.update();
              },
            ),
            size.HeightSpace(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: TextFieldPriceWidget(
                          textController: controller.startController,
                          suffix: 'INR')),
                  size.WidthSpace(20),
                  Expanded(
                      child: TextFieldPriceWidget(
                          textController: controller.endController,
                          suffix: 'INR')),
                ],
              ),
            ),
            size.HeightSpace(10),
            const Divider(
              color: shadowColor,
            ),
          ],
        );
      },
    );
  }
}
