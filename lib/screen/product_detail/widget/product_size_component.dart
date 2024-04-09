// ignore_for_file: prefer_const_constructors

import 'package:ck_woocommerce_api/models/productDetailDataModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';

class ProductSizesComponent extends StatefulWidget {
  const ProductSizesComponent({Key? key}) : super(key: key);

  @override
  State<ProductSizesComponent> createState() => _ProductSizesComponentState();
}

class _ProductSizesComponentState extends State<ProductSizesComponent> {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        Iterable<DefaultAttributes>? productSize = controller
            .productDetailModel?.defaultAttributes
            ?.where((element) => element.id == 1);

        Iterable<Attributes>? productSizeList = controller
            .productDetailModel?.attributes
            ?.where((element) => element.id == 1);

        return productSize != null && productSize.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('size'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(controller.selectedSize,
                            style: TextStyle(fontSize: 18, color: textColor)),
                      ],
                    ),
                    size.HeightSpace(15),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: List.generate(
                        productSizeList?.first.options?.length ?? 0,
                        (index) => GestureDetector(
                          onTap: () {
                            controller.selectedSize =
                                productSizeList?.first.options?[index] ?? "";
                            controller.update();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: primaryBlackColor),
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                color: controller.selectedSize ==
                                        productSizeList?.first.options?[index]
                                    ? shadowColor
                                    : kBackgroundCardColor),
                            child: Text(
                              productSizeList?.first.options?[index] ?? "",
                              style: TextStyle(
                                  fontSize: 18, color: primaryBlackColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              )
            : SizedBox();
      },
    );
  }
}
