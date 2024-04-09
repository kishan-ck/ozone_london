// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/controller/wishlist_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';
import 'package:ozone_london/screen/product_detail/product_detail_screen.dart';
import 'package:ozone_london/screen/wishlist/widget/wishlist_widget.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<WishListController>(),
      builder: (controller) {
        return OfflineBuilder(
          connectivityBuilder: (context, value, child) {
            if (value == ConnectivityResult.none) {
              return Scaffold(
                body: InternetError(),
              );
            }
            return child;
          },
          child: Stack(
            children: [
              Scaffold(
                appBar: commonPageAppBar(
                    title: "wish_list".tr, isNotification: false),
                backgroundColor: backgroundColor,
                body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(size.height(15)),
                    child: Column(
                      children: [
                        ListView.separated(
                          itemCount: controller.wishList.length,
                          shrinkWrap: true,
                          controller: ScrollController(),
                          itemBuilder: (context, index) {
                            return WishlistWidget(
                              productVariation:
                                  controller.wishList[index].wishlistType ==
                                          "variable"
                                      ? "select_option".tr
                                      : "add_to_cart".tr,
                              productVariationTap: () {
                                if (controller.wishList[index].wishlistType ==
                                    "variable") {
                                  Get.find<ProductDetailController>()
                                      .productDetail(
                                    productId:
                                        controller.wishList[index].productId ??
                                            0,
                                    productsId:
                                        Get.find<ProductDetailController>()
                                                .productDetailModel
                                                ?.relatedIds!
                                                .cast<int>() ??
                                            [],
                                  );
                                  Get.to(ProductDetailScreen());
                                }
                              },
                              productName:
                                  controller.wishList[index].wishlistName ?? "",
                              productPrise:
                                  controller.wishList[index].wishlistPrice ??
                                      "",
                              productDate:
                                  controller.wishList[index].wishlistTime ?? "",
                              productImage:
                                  controller.wishList[index].wishlistImageUrl ??
                                      "",
                              removeWishlistTap: () {
                                controller.removeWishList(
                                    productID:
                                        controller.wishList[index].productId ??
                                            0);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return size.HeightSpace(10);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              controller.isLoading ? loadingWidget() : SizedBox()
            ],
          ),
        );
      },
    );
  }
}
