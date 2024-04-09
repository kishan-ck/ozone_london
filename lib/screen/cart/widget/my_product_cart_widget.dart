// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/screen/cart/model/cart_data_model.dart';
import 'package:ozone_london/screen/cart/widget/add_to_cart_dialog.dart';
import 'package:ozone_london/screen/cart/widget/product_cart_widget.dart';
import 'package:ozone_london/screen/cart/widget/remove_item_dialog.dart';
import 'package:ozone_london/screen/product_detail/product_detail_screen.dart';
import 'cart_button.dart';

class MyProductsCartWidget extends StatefulWidget {
  const MyProductsCartWidget({Key? key}) : super(key: key);

  @override
  State<MyProductsCartWidget> createState() => _MyProductsCartWidgetState();
}

class _MyProductsCartWidgetState extends State<MyProductsCartWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CartController>(),
      builder: (controller) {
        return ListView.separated(
          itemCount: controller.cartList.length,
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.all(15),
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 5, color: shadowColor, thickness: 1),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Get.to(ProductDetailScreen());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProductCartWidget(
                  cartData: controller.cartList[index],
                ),
                size.HeightSpace(20),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CartButton(
                        cartData: controller.cartList[index],
                        value: controller.cartValue,
                        onChange: (val) {},
                        decrementOnTap: () =>
                            controller.cartItemCountDecrement(index),
                        incrementOnTap: () =>
                            controller.cartItemCountIncrement(index),
                      ),
                      size.WidthSpace(20),
                      TextButton.icon(
                        onPressed: () {
                          Get.dialog(
                            Dialog(
                              insetPadding: EdgeInsets.all(15),
                              child: RemoveItemDialog(
                                removeOnPress: () {
                                  Get.back();
                                  controller.removeItem(index);
                                },
                                productName:
                                    controller.cartList[index].name ?? "",
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.delete_outline_rounded,
                            color: iconColor, size: 20),
                        label: Text("remove".tr,
                            style: TextStyle(color: textColor, fontSize: 16)),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: CircleAvatar(
                            backgroundColor: whiteColor,
                            child: Icon(Icons.favorite_outline_rounded,
                                color: iconColor, size: 20)),
                        label: Text("save_for_favourites".tr,
                            style: TextStyle(color: textColor, fontSize: 16)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
