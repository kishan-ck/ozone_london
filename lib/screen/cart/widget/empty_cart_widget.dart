// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/presentation/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/screen/home/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ic_empty_cart.png'),
          size.HeightSpace(20),
          Text('your_cart_is_empty'.tr,
              style: TextStyle(color: primaryBlackColor, fontSize: 24)),
          size.HeightSpace(20),
          Text(
            'you_may_check_out_all_the_available_products_and_buy_some_in_the_shop'
                .tr,
            style: TextStyle(fontSize: 18, color: textColor),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          size.HeightSpace(40),
          AppButton(
            buttonText: 'continue_shopping'.tr,
            onPressed: () {
              Get.find<CartController>().cartOrderSummary();
              Get.offAll(
                CustomBottomNavigationBar(
                  index: 0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
