// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/screen/home/widget/carousel_slider_widget.dart';

import '../../constant/dynamic_size.dart';
import '../product/product_list_componet.dart';
import 'widget/shop_by_category_widget.dart';

class homeProducts extends StatelessWidget {
  const homeProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //controller: controller.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          size.HeightSpace(20),
          CarouselSliderWidget(),
          size.HeightSpace(20),
          Text(
            'shop_by_category'.tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          size.HeightSpace(10),
          ShopByCategoryWidget(),
          size.HeightSpace(10),
          Text(
            'this_weeks_highlights'.tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          size.HeightSpace(10),
          ProductListComponent()
        ],
      ),
    );
  }
}
