// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/order_controller.dart';
import 'package:ozone_london/controller/profile_controller.dart';
import 'package:ozone_london/presentation/common_appbar/common_appbar.dart';
import 'package:ozone_london/screen/auth/sign_in_screen.dart';
import 'package:ozone_london/screen/order/order_screen.dart';
import 'package:ozone_london/screen/profile/edit_profile_screen.dart';
import 'package:ozone_london/screen/profile/widget/my_account_card.dart';
import 'package:ozone_london/screen/profile/widget/setting_card.dart';
import 'package:ozone_london/screen/profile/widget/sign_out_confirmation_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProfileController>(),
      builder: (controller) {
        return Scaffold(
          appBar: commonAppBar(),
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  size.HeightSpace(10),
                  Text("Hi, ${getStorage.read("name")}",
                      style: TextStyle(
                          fontSize: 22,
                          color: primaryBlackColor,
                          fontWeight: FontWeight.bold)),
                  Text("${getStorage.read("email")}",
                      style: TextStyle(color: textColor, fontSize: 18)),
                  TextButton(
                      onPressed: () {
                        Get.to(
                          UserEditProfile(),
                        );
                      },
                      child: Text("edit_account".tr,
                          style: TextStyle(color: Colors.pink, fontSize: 16)),
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.pink.shade50),
                          padding: MaterialStateProperty.all(
                              EdgeInsetsDirectional.zero))),
                  size.HeightSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.find<OrderController>().getOrderList();
                          Get.to(OrderScreen());
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Ink(
                          height: size.height(100),
                          width: size.width(100),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              boxShadow: AppShadows.buttonBoxShadow,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/ic_orders.svg',
                                  height: size.height(40)),
                              Text('orders'.tr,
                                  style: TextStyle(
                                      color: textColor, fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(15),
                        child: Ink(
                          height: size.height(100),
                          width: size.width(100),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              boxShadow: AppShadows.buttonBoxShadow,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/ic_return.svg',
                                  height: size.height(40)),
                              Text('return'.tr,
                                  style: TextStyle(
                                      color: textColor, fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(15),
                        child: Ink(
                          height: size.height(100),
                          width: size.width(100),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              boxShadow: AppShadows.buttonBoxShadow,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/ic_credit.svg',
                                  height: size.height(40)),
                              Text('payment'.tr,
                                  style: TextStyle(
                                      color: textColor, fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  size.HeightSpace(20),
                  MyAccountCard(),
                  size.HeightSpace(20),
                  SettingsCard(),
                  size.HeightSpace(30),
                  OutlinedButton.icon(
                      onPressed: () {
                        Get.dialog(
                          Dialog(
                              insetPadding: EdgeInsets.all(15),
                              child: SignOutConfirmationDialog()),
                        );
                        // Get.offAll(SignInScreen());
                      },
                      icon: const Icon(Icons.power_settings_new_rounded,
                          color: iconColor),
                      label: Text("sign_out".tr,
                          style: TextStyle(
                              fontSize: 20, color: primaryBlackColor)),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              Size(double.infinity, size.height(50))),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          side: MaterialStateProperty.all(const BorderSide(
                              width: 1.2, color: primaryBlackColor)))),
                  size.HeightSpace(40),
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/images/ic_logo_dark.svg",
                          width: 200,
                        ),
                        size.HeightSpace(20),
                        Text(
                            '© copyright 2023 Ozone London All rights reserved.',
                            style: TextStyle(
                                fontSize: 16, color: grayColor, height: 1.5),
                            maxLines: 3,
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  size.HeightSpace(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
