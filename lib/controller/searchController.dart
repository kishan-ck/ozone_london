// ignore_for_file: avoid_print

import 'package:ck_woocommerce_api/models/productDetailDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:ozone_london/controller/home_controller.dart';
import 'package:ozone_london/controller/product_category_controller.dart';

class searchController extends GetxController {
  bool isBackPress = false;
  bool isSearch = false;
  bool isSearchLoading = false;
  ScrollController scrollController = ScrollController();

  TextEditingController searchControllertxt = TextEditingController();
  RxInt selectedIndex = 0.obs;

  int searchrefreshPage = 1;
  List<ProductDetailsDataModel> productDetailList = [];

  Future<void> onRefresh() async {
    searchrefreshPage = searchrefreshPage + 1;
    return await wooCommerceAPI
        .searchProductList(
            page: searchrefreshPage, searchKey: searchControllertxt.text)
        .then((value) {
      if (value != null) {
        productDetailList.addAll(value);

        update();
      }
    });
  }

  cleare() {
    isSearch = false;
    isSearchLoading = false;
    productDetailList = [];
    searchControllertxt.text = '';
    Get.find<HomeController>().update();
    Get.find<ProductCategoryController>().update();
  }

  onSearch(String val) async {
    isSearch = true;
    if (val.isEmpty) {
      isSearch = false;
    } else {
      isSearchLoading = true;
    }
    update();
    Get.find<HomeController>().update();
    Get.find<ProductCategoryController>().update();
    await wooCommerceAPI.searchProductList(searchKey: val).then((value) {
      if (value != null) {
        productDetailList = value;
        isSearchLoading = false;
        update();
      }
    });
  }

  String? isDiscount(String? price, String? salePrice) {
    if (price == null ||
        salePrice == null ||
        salePrice.toString().isEmpty ||
        price.toString().isEmpty) {
      return null;
    } else {
      double pr = double.parse(price.toString());
      double spr = double.parse(salePrice.toString());
      if (pr > 0 && spr > 0) {
        double temp = pr - spr;
        double temp2 = temp / pr;
        double temp3 = temp2 * 100;

        return temp3.toString().split(".").first;
      } else {
        return null;
      }
    }
  }
}
