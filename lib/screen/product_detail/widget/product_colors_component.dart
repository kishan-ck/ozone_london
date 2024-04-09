// ignore_for_file: prefer_const_constructors

import 'package:ck_woocommerce_api/models/productDetailDataModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';

import '../../../constant/color_list.dart';

class ProductColorsComponent extends StatefulWidget {
  const ProductColorsComponent({Key? key}) : super(key: key);

  @override
  State<ProductColorsComponent> createState() => _ProductColorsComponentState();
}

class _ProductColorsComponentState extends State<ProductColorsComponent> {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        Iterable<DefaultAttributes>? productColor = controller
            .productDetailModel?.defaultAttributes
            ?.where((element) => element.id == 2);

        Iterable<Attributes>? productColorList = controller
            .productDetailModel?.attributes
            ?.where((element) => element.id == 2);
        return productColor != null && productColor.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('colors:'.tr,
                            style: TextStyle(
                                color: primaryBlackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        size.WidthSpace(3),
                        Text(controller.selectedColor,
                            style: TextStyle(fontSize: 18, color: textColor)),
                      ],
                    ),
                    size.HeightSpace(15),
                    Wrap(
                      spacing: 10,
                      children: List.generate(
                        productColorList?.first.options?.length ?? 0,
                        (index) => Container(
                          width: size.height(50),
                          height: size.width(50),
                          padding: EdgeInsetsDirectional.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: controller.selectedColor ==
                                        productColorList?.first.options?[index]
                                    ? primaryBlackColor
                                    : Colors.transparent,
                                width: 2),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectedColor =
                                  productColorList?.first.options?[index] ?? "";
                              controller.update();
                            },
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: getColorsFromName(
                                    productColorList?.first.options?[index] ??
                                        ""),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox();
      },
    );
  }

// // Replace 'red' with the color name from your API
//
// Color getColorFromName(String colorName) {
//   String hexCode = ColorNameToHex.getColorHexFromName(colorName);
//   if (hexCode != null) {
//     hexCode = hexCode.replaceAll(
//         "#", ""); // Remove the '#' symbol from the hex code
//     return Color(int.parse(hexCode, radix: 16));
//   }
//   return Colors.transparent; // Default color if the name is not found
// }
}
