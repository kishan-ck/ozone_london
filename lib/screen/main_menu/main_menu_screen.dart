// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_category_controller.dart';
import 'package:ozone_london/presentation/common_appbar/common_appbar.dart';
import 'package:ozone_london/presentation/common_search_bar/common_search_bar_widget.dart';
import 'package:ozone_london/screen/main_menu/main_menu_categorys.dart';
import 'package:ozone_london/screen/main_menu/widget/categories_section_widget.dart';
import 'package:ozone_london/screen/main_menu/widget/special_offer_widget.dart';
import 'package:ozone_london/screen/search_product/search_product.dart';

import '../../controller/searchController.dart';

class MainMenuScreen extends StatelessWidget {
  MainMenuScreen({Key? key}) : super(key: key);
  final Debouncer onSearchDebouncer =
      Debouncer(delay: Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductCategoryController>(),
      builder: (controller) {
        return Scaffold(
          appBar: commonAppBar(),
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundColor,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                size.HeightSpace(15),
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
                Expanded(
                    child: Get.find<searchController>().isSearch
                        ? SearchScreen()
                        : mainMenuCategory())
              ],
            ),
          ),
        );
      },
    );
  }
}
