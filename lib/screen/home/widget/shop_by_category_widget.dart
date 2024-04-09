// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/home_controller.dart';
import 'package:ozone_london/presentation/network_image/netwok_image.dart';

import '../../../controller/product_category_controller.dart';
import '../../category/category_list_screen.dart';

class ShopByCategoryWidget extends StatelessWidget {
  const ShopByCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<HomeController>(),
        builder: (controller) {
          return Container(
            height: size.height(160),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return size.WidthSpace(15);
              },
              scrollDirection: Axis.horizontal,
              itemCount: controller.productDataCategoryList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.find<ProductCategoryController>().productCategory(
                            categoryId:
                                controller.productDataCategoryList[index].id ??
                                    0);
                        Get.to(CategoryListScreen(
                          id: controller.productDataCategoryList[index].id ?? 0,
                          title: controller.productDataCategoryList[index].name
                                  ?.replaceAll("amp;", "") ??
                              '',
                        ));
                      },
                      child: Container(
                        width: size.width(120),
                        height: size.height(120),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: CustomNetworkImage(
                            image: controller.productDataCategoryList[index]
                                    .image?.src ??
                                ""),
                      ),
                    ),
                    size.HeightSpace(10),
                    Text(
                        controller.productDataCategoryList[index].name
                                ?.replaceAll("amp;", "") ??
                            "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: primaryBlackColor))
                  ],
                );
              },
            ),
          );
        });
  }
}
