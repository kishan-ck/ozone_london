// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';

class SignUpController extends GetxController {
  final formkey = GlobalKey<FormState>();

  bool passwordVisible = true;
  bool checkboxValue = false;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController yourNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  Future<void> createUser() async {
    isLoading = true;
    update();

    await wooCommerceAPI.createUser(body: {
      "email": emailController.text,
      "first_name": yourNameController.text,
      "username": userNameController.text,
      "password": passwordController.text
    }).then((value) {
      if (value?.id != null) {
        showCustomSnackBar("user_create_successfully".tr, isError: false);
        Get.back();
      }
    });

    isLoading = false;
    update();
  }
}
