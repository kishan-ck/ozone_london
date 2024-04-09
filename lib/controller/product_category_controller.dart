import 'package:ck_woocommerce_api/models/productCategoryDataModel.dart';
import 'package:ck_woocommerce_api/models/productDetailDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductCategoryController extends GetxController {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  List<ProductCategoryDataModel> productDataCategoryList = [];
  List<ProductDetailsDataModel> productDetailList = [];

  ScrollController scrollController = ScrollController();

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  int refreshPage = 1;

  void onRefresh({required int categoryId}) async {
    refreshPage = refreshPage + 1;
    await wooCommerceAPI
        .getProductList(page: refreshPage, category_id: categoryId)
        .then((value) {
      if (value != null) {
        productDetailList.addAll(value);
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        refreshController.resetNoData();
        update();
      }
    });
  }

  Future<void> productCategory({required int categoryId}) async {
    isLoading = true;
    update();
    await wooCommerceAPI.getProductList(category_id: categoryId).then((value) {
      if (value != null) {
        productDetailList = value;
        isLoading = false;
        update();
      }
    });
  }

  Future<void> productCategoryList() async {
    await wooCommerceAPI.getProductCategoryList().then((value) {
      if (value != null) {
        productDataCategoryList = value;
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
