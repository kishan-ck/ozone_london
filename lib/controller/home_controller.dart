// ignore_for_file: avoid_print

import 'package:ck_woocommerce_api/models/productCategoryDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';

class HomeController extends GetxController {
  bool isBackPress = false;

  ScrollController scrollController = ScrollController();
  RxInt selectedIndex = 0.obs;

  late DateTime currentBackPressTime;

  List<ProductCategoryDataModel> productDataCategoryList = [];

  Future<void> productCategoryList() async {
    await wooCommerceAPI.getProductCategoryList().then((value) {
      if (value != null) {
        productDataCategoryList = value;
        update();
      }
    });
  }

  @override
  void onInit() {
    super.onInit();

    productCategoryList();
  }
}
