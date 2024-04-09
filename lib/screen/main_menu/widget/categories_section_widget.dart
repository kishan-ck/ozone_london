// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/home_controller.dart';
import 'package:ozone_london/presentation/network_image/netwok_image.dart';
import 'package:ozone_london/screen/category/category_list_screen.dart';

import '../../../controller/product_category_controller.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return GetBuilder(
      init: Get.find<HomeController>(),
      builder: (controller) {
        return GridView.count(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: controller.productDataCategoryList
              .map((e) => InkWell(
                    onTap: () {
                      Get.find<ProductCategoryController>()
                          .productCategory(categoryId: e.id ?? 0);
                      Get.to(CategoryListScreen(
                        id: e.id ?? 0,
                        title: e.name?.replaceAll("amp;", "") ?? '',
                      ));
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        boxShadow: AppShadows.buttonBoxShadow,
                        borderRadius: BorderRadius.circular(15),
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: size.height(100),
                              child: CustomNetworkImage(
                                  image: e.image?.src ?? "")),
                          size.HeightSpace(10),
                          Text(
                            e.name?.replaceAll("amp;", "") ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryBlackColor),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}
