// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/home_controller.dart';
import 'package:ozone_london/presentation/common_appbar/common_appbar.dart';
import 'package:ozone_london/presentation/common_search_bar/common_search_bar_widget.dart';
import 'package:ozone_london/screen/search_product/search_product.dart';

import '../../controller/searchController.dart';
import 'home_products.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  final Debouncer onSearchDebouncer =
      Debouncer(delay: Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<HomeController>(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: commonAppBar(),
          backgroundColor: backgroundColor,
          body: Container(
            margin: EdgeInsets.all(size.height(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonSearchBarWidget(
                    onChange: (value) {
                      onSearchDebouncer.call(
                        () {
                          Get.find<searchController>().onSearch(value);
                        },
                      );
                    },
                    controller:
                        Get.find<searchController>().searchControllertxt),
                // HomeMenuList(),

                Expanded(
                    child: Get.find<searchController>().isSearch
                        ? SearchScreen()
                        : homeProducts()),
                // MediaQuery.of(context).viewInsets.bottom == 0
                //     ? size.HeightSpace(16 * 2)
                //     : size.HeightSpace(
                //         MediaQuery.of(context).size.height / 3.4)
              ],
            ),
          ),
        );
      },
    );
  }
}
