// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/presentation/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';

class SignInController extends GetxController {
  final formkey = GlobalKey<FormState>();

  RxBool passwordVisible = true.obs;

  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    isLoading = true;
    update();

    await ckWordPressAPI
        .login(
            userName: emailController.text, password: passwordController.text)
        .then((value) {
      if (value?.token != null) {
        getStorage.write("token", value?.token);
        getStorage.write("email", value?.userEmail);
        getStorage.write("name", value?.userDisplayName);
        getStorage.write("id", value?.userId);
        showCustomSnackBar("login_successfully".tr, isError: false);
        emailController.clear();
        passwordController.clear();
        isLoading = false;
        Get.find<CartController>().cartOrderSummary();
        return Get.offAll(const CustomBottomNavigationBar(index: 0));
      }
    });

    isLoading = false;
    update();
  }
}
