// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/presentation/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:ozone_london/screen/auth/sign_in_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      String? token = getStorage.read("token");
      if (token == null) {
        Get.offAll(SignInScreen());
      } else {
        Get.find<CartController>().cartOrderSummary();
        Get.offAll(const CustomBottomNavigationBar(index: 0));
      }
    });
  }
}
