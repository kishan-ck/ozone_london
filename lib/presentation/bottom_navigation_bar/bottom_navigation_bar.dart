// ignore_for_file: deprecated_member_use, prefer_const_constructors, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';
import 'package:ozone_london/screen/cart/cart_screen.dart';
import 'package:ozone_london/screen/cart/model/cart_data_model.dart';
import 'package:ozone_london/screen/home/home_screen.dart';
import 'package:ozone_london/screen/main_menu/main_menu_screen.dart';
import 'package:ozone_london/screen/profile/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:badges/badges.dart' as badges;
import '../../controller/searchController.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int index;

  const CustomBottomNavigationBar({Key? key, required this.index})
      : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  final List<Widget> _bottomNavigationItems = [
    HomeScreen(),
    MainMenuScreen(),
    ProfileScreen(),
    CartScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems(CartController controller) {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home_outlined),
          title: ("Home"),
          inactiveIcon: Icon(Icons.home_outlined),
          activeColorPrimary: iconColor,
          inactiveColorPrimary: inActiveIconColor),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.category_outlined),
          title: ("Product"),
          inactiveIcon: Icon(Icons.category_outlined),
          activeColorPrimary: iconColor,
          inactiveColorPrimary: inActiveIconColor),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person_outline),
          title: ("Profile"),
          inactiveIcon: Icon(Icons.person_outline),
          activeColorPrimary: iconColor,
          inactiveColorPrimary: inActiveIconColor),
      PersistentBottomNavBarItem(
          icon: controller.cartCount == 0
              ? Icon(Icons.shopping_bag_outlined)
              : badges.Badge(
                  badgeContent: Text(
                    controller.cartCount.toString(),
                    style: TextStyle(color: whiteColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Icon(Icons.shopping_bag_outlined),
                  )),
          title: ("Quotes"),
          inactiveIcon: controller.cartCount == 0
              ? Icon(Icons.shopping_bag_outlined)
              : badges.Badge(
                  badgeContent: Text(
                    controller.cartCount.toString(),
                    style: TextStyle(color: whiteColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Icon(Icons.shopping_bag_outlined),
                  )),
          activeColorPrimary: iconColor,
          inactiveColorPrimary: inActiveIconColor),
    ];
  }

  late int sindex = widget.index;

  void tapindex(int index) {
    Get.find<searchController>().cleare();
    if (sindex != index) {
      // Get.find<CartController>().getCartListData();
      setState(() {
        sindex = index;

        final data = getStorage.read('cartList');
        print("cart List Storage:: $data");
        if (data != null) {
          Get.find<CartController>().cartList = (data as List<dynamic>)
              .map((e) => CartDataModel.fromJson(e))
              .toList();
          Get.find<CartController>().cartOrderSummary();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (context, value, child) {
        if (value == ConnectivityResult.none) {
          return Scaffold(
            body: InternetError(),
          );
        }
        return child;
      },
      child: GetBuilder<CartController>(
        init: Get.find<CartController>(),
        assignId: true,
        builder: (controller) {
          return Center(
            child: PersistentTabView(
              context,
              screens: _bottomNavigationItems,
              controller: _controller,
              items: _navBarsItems(controller),
              confineInSafeArea: true,
              onItemSelected: tapindex,
              key: UniqueKey(),
              decoration: NavBarDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
              backgroundColor: whiteColor,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: false,
              hideNavigationBarWhenKeyboardShows: true,
              popAllScreensOnTapOfSelectedTab: true,
              navBarStyle: NavBarStyle.style5,
            ),
          );
        },
      ),
    );
  }
}
