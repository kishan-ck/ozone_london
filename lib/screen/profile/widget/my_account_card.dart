// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/address_controller.dart';
import 'package:ozone_london/controller/wishlist_controller.dart';
import 'package:ozone_london/screen/address/address_screen.dart';
import 'package:ozone_london/screen/wishlist/wishlist_screen.dart';

class MyAccountCard extends StatelessWidget {
  MyAccountCard({
    Key? key,
  }) : super(key: key);

  final List<String> _titlesKry = [
    'wishlist'.tr,
    'download'.tr,
    'save_cards'.tr,
    'address'.tr,
  ];
  final List<IconData> _icons = [
    Icons.favorite,
    Icons.download,
    Icons.wallet,
    Icons.location_pin,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("my_account".tr, style: TextStyle(color: grayColor, fontSize: 18)),
        size.HeightSpace(10),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: AppShadows.buttonBoxShadow,
              borderRadius: BorderRadius.circular(15)),
          child: ListView.separated(
            itemCount: _titlesKry.length,
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (context, index) => ListTile(
              title: Text(_titlesKry[index],
                  style: TextStyle(fontSize: 16, color: textColor)),
              leading: Icon(
                _icons[index],
                color: iconColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              horizontalTitleGap: 12,
              onTap: () {
                switch (index) {
                  case 0:
                    Get.find<WishListController>().getWishList();
                    Get.to(WishListScreen());
                    break;
                  case 1:
                    break;
                  case 2:
                    break;
                  case 3:
                    {
                      Get.find<AddressController>().fetchAddress();
                      Get.to(AddressScreen());
                    }
                    break;
                  default:
                    throw const Text('Route in  not found.');
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
