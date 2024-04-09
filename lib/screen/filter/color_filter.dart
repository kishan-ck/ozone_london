// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/presentation/expansion_tile/expansion_tile_widget.dart';

class ColorsFilter extends StatefulWidget {
  const ColorsFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<ColorsFilter> createState() => _ColorsFilterState();
}

class _ColorsFilterState extends State<ColorsFilter> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductListController>(),
      builder: (controller) {
        return ExpansionTileWidget(
          title: 'colors'.tr,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Wrap(
                  spacing: 10,
                  children: List.generate(
                    controller.colorList.length,
                    (index) => Container(
                      width: size.height(50),
                      height: size.width(50),
                      padding: EdgeInsetsDirectional.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: controller.selectColor == index
                                ? primaryBlackColor
                                : Colors.transparent,
                            width: 2),
                      ),
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => controller.selectColor = index),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: controller.colorList[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            size.HeightSpace(15),
            const Divider(),
          ],
        );
      },
    );
  }
}
