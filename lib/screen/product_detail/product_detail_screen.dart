// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/controller/wishlist_controller.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';
import 'package:ozone_london/screen/cart/model/cart_data_model.dart';
import 'package:ozone_london/screen/cart/widget/add_to_cart_dialog.dart';
import 'package:ozone_london/screen/product_detail/product_detail_bottom_navigation_bar.dart';
import 'package:ozone_london/screen/product_detail/widget/product_detail_widget.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        return Scaffold(
          appBar: _productDetailsAppBar(
              icon: controller.productDetailModel?.wishlist == "0"
                  ? Icons.favorite
                  : Icons.favorite_border,
              iconColor: controller.productDetailModel?.wishlist == "0"
                  ? redColor
                  : primaryBlackColor,
              onTap: (value) async {
                if (controller.productDetailModel?.wishlist == "0") {
                  Get.find<WishListController>()
                      .removeWishList(
                      productID: controller.productDetailModel?.id ?? 0)
                      .then((value) {
                    controller.productDetail(
                      productId: controller.productDetailModel?.id ?? 0,
                      productsId: controller.productDetailModel!.relatedIds!
                          .cast<int>(),
                    );
                  });
                } else {
                  controller
                      .addWishListProduct(
                      controller.productDetailModel?.id ?? 0)
                      .then((value) {
                    controller
                        .productDetail(
                      productId: controller.productDetailModel?.id ?? 0,
                      productsId: controller.productDetailModel!.relatedIds!
                          .cast<int>(),
                    )
                        .then((value) =>
                        showCustomSnackBar(
                            controller.addWishListModel?.message,
                            isError: false));
                  });
                }
              }),
          backgroundColor: backgroundColor,
          body: controller.isLoading != true
              ? ProductDetailsWidget()
              : Center(
              child: CircularProgressIndicator(
                color: primaryBlackColor,
              )),
          bottomNavigationBar: controller.isLoading != true
              ? ProductBottomNavigationBar(
            addToCartPress: () async {
              // controller.addItemToCartWithColorAndSizeCheck();

              List? data = await getStorage.read('cartList');
              if (data == null) {
                controller.addItemToCartWithColorAndSizeCheck();
              } else {
                final existOrNot = data.where((element) {
                  return (element["name"] ==
                      controller.productDetailModel?.name &&
                      element["selectedColor"] ==
                          controller.selectedColor &&
                      element["selectedSize"] == controller.selectedSize);
                }).toList();
                if (existOrNot.isEmpty) {
                  controller.addItemToCartWithColorAndSizeCheck();
                } else {
                  if (existOrNot[0]["selectedColor"] ==
                      controller.selectedColor &&
                      existOrNot[0]["selectedSize"] ==
                          controller.selectedSize) {
                    print("check exist:: $existOrNot");
                    existOrNot[0]["count"] +=
                        int.parse(controller.cartCountController.text);

                    final newData = await getStorage.read('cartList');
                    Get
                        .find<CartController>()
                        .cartList
                        .clear();
                    await getStorage.remove("cartList");
                    getStorage.write("cartList", newData);

                    Get
                        .find<CartController>()
                        .cartList =
                        (newData as List<dynamic>)
                            .map((e) => CartDataModel.fromJson(e))
                            .toList();

                    Get.dialog(
                      Dialog(
                          insetPadding: EdgeInsets.all(15),
                          child: AddToCartDialog(
                              productName:
                              controller.productDetailModel!.name ??
                                  "",
                              image: controller.productDetailModel
                                  ?.images?[0].src ??
                                  "")),
                    );
                    controller.update();
                  } else {
                    controller.addItemToCartWithColorAndSizeCheck();
                  }
                }
              }
            },
          )
              : SizedBox(),
        );
      },
    );
  }
}

AppBar _productDetailsAppBar(
    {Future<bool?> Function(bool)? onTap, Color? iconColor, IconData? icon}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: primaryBlackColor,
        )),
    actions: [
      IconButton(
        onPressed: () {
          Share.share(
              'https://minimog-import.thememove.com/fashion1/product/boxy-denim-jacket/',
              subject: 'Test');
        },
        icon: Icon(
          Icons.share,
          color: primaryBlackColor,
        ),
      ),
      LikeButton(
        onTap: onTap,
        bubblesColor: BubblesColor(
            dotPrimaryColor: primaryBlackColor,
            dotSecondaryColor: primaryBlackColor),
        likeBuilder: (bool isLiked) {
          return Icon(
            icon,
            color: iconColor,
            // size: buttonSize,
          );
        },
      ),
      size.WidthSpace(10)
    ],
  );
}
