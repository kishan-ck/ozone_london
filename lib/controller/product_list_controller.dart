import 'package:ck_woocommerce_api/models/productDetailDataModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductListController extends GetxController {
  ScrollController scrollController = ScrollController();

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  int refreshPage = 1;
  String shortBy = "";

  bool allCheckbox = false;
  bool abbyCheckbox = false;
  bool size2Checkbox = false;
  bool isListView = true;

  double starValue = 10;
  double endValue = 80;
  double minValue = 0.0;
  double maxValue = 100.0;

  int selectColor = 0;

  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  List<ProductDetailsDataModel> productDetailList = [];

  final List<Color> colorList = [
    const Color(0xFFd5ab7f),
    const Color(0xFFaca69f),
    const Color(0xFFb1c5d4),
    const Color(0xFF8db4d2),
    const Color(0xFF94ad7e),
    const Color(0xFF063e66),
    const Color(0xFFedded9),
    const Color(0xFFe95b8d),
    const Color(0xFFc6aec7),
    const Color(0xFFe0e0e0),
    const Color(0xFF836953),
    const Color(0xFF000000),
    const Color(0xFFebe6db),
    const Color(0xFFffffff),
  ];

  setStartValue() {
    if (double.parse(startController.text).roundToDouble() <=
            double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      starValue = double.parse(startController.text).roundToDouble();
    }
  }

  setEndValue() {
    if (double.parse(startController.text).roundToDouble() <=
            double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      endValue = double.parse(endController.text).roundToDouble();
    }
  }

  void onRefresh() async {
    refreshPage = refreshPage + 1;
    await wooCommerceAPI
        .getProductList(page: refreshPage, orderBy: shortBy)
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

  List<String> shortByList = [
    "Popularity",
    "Average rating",
    "Latest",
    "Price: low to high",
    "Price: high to low",
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startController = TextEditingController(text: starValue.toInt().toString());
    endController = TextEditingController(text: endValue.toInt().toString());
    startController.addListener(setStartValue);
    endController.addListener(setEndValue);

    productList();
  }

  //
  // Future<void> orderByproductList() async {
  //   await wooCommerceAPI.orderByProductList(orderkey: "").then((value) {
  //     if (value != null) {
  //       productDetailList = value;
  //       update();
  //     }
  //   });
  // }

  Future<void> productList() async {
    await wooCommerceAPI.getProductList(orderBy: shortBy).then((value) {
      if (value != null) {
        productDetailList = value;
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
