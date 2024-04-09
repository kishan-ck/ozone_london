// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';
import 'package:ozone_london/screen/home/widget/product22_widget.dart';
import 'package:ozone_london/screen/product/product_list_screen.dart';
import 'package:ozone_london/screen/product_detail/product_detail_screen.dart';
import 'package:ozone_london/screen/see_more/see_more_button.dart';

class ProductListComponent extends StatelessWidget {
  const ProductListComponent({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (context, value, child) {
        if (value == ConnectivityResult.none) {
          return Scaffold(
            body: InternetError(),
          );
        }
        return child;
      },
      child: GetBuilder(
        init: Get.find<ProductListController>(),
        builder: (controller) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  itemCount: controller.productDetailList.length > 4
                      ? 4
                      : controller.productDetailList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (final context, final index) => InkWell(
                      onTap: () {
                        Get.find<ProductDetailController>().productDetail(
                            productId:
                                controller.productDetailList[index].id ?? 0,
                            productsId: controller
                                .productDetailList[index].relatedIds!
                                .cast<int>());
                        Get.to(ProductDetailScreen());
                      },
                      child: Product2x2CardWidget(
                        image: controller.productDetailList[index].images !=
                                    null &&
                                controller
                                    .productDetailList[index].images!.isNotEmpty
                            ? controller.productDetailList[index].images?.first
                                    .src ??
                                ""
                            : "",
                        price: controller.productDetailList[index].price ?? "",
                        productName:
                            controller.productDetailList[index].name ?? "",
                      )),
                ),
                size.HeightSpace(30),
                SeeMoreButton(
                  title: "see_more".tr,
                  onTap: () {
                    Get.to(ProductListScreen());
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
