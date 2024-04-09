import 'package:ck_woocommerce_api/models/order_detail_data_model.dart';
import 'package:ck_woocommerce_api/models/order_list_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/screen/order/order_detail_screen.dart';

class OrderController extends GetxController {
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  List<OrderListDataModel> orderList = [];
  OrderDetailDataModel? orderDetailDataModel;

  Future<void> getOrderList() async {
    isLoading = true;
    update();
    await wooCommerceAPI
        .getOrderList(customerId: int.parse(getStorage.read("id").toString()))
        .then((value) {
      if (value != null) {
        orderList = value;
        isLoading = false;
        update();
      }
    });
  }

  Future<void> orderDetail({required int orderID}) async {
    isLoading = true;
    update();
    await wooCommerceAPI.orderDetails(orderID: orderID).then((value) {
      if (value != null) {
        orderDetailDataModel = value;
        Get.to(const OrderDetailScreen());
      }
    });
    isLoading = false;
    update();
  }
}
