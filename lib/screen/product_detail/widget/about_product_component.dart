// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';

class AboutProductComponent extends StatelessWidget {
  const AboutProductComponent({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        return controller.productDetailModel?.shortDescription == null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "product_detail".tr,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryBlackColor),
                    ),
                    // size.HeightSpace(15),
                    Html(
                      shrinkWrap: true,
                      data:
                          controller.productDetailModel?.shortDescription ?? "",
                    )
                  ],
                ),
              )
            : SizedBox();
      },
    );
  }
}
