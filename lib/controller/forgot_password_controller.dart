import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';
import 'package:ozone_london/screen/auth/sign_in_screen.dart';
import 'package:ozone_london/screen/forgot_password/reset_password_screen.dart';
import 'package:ozone_london/screen/forgot_password/validate_code_screen.dart';

class ForgotPasswordController extends GetxController {
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  String validateCode = "";
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool isLoading = false;

  TextEditingController userAndEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> sendResetPasswordLink() async {
    isLoading = true;
    update();

    await ckWordPressAPI
        .resetPassword(email: userAndEmailController.text)
        .then((value) {
      if (value?.data?.status == 200) {
        showCustomSnackBar(value?.message, isError: false);
        Get.to(const ValidateCodeScreen());
      }
    });

    isLoading = false;
    update();
  }

  Future<void> validateCodeVerify() async {
    isLoading = true;
    update();

    await ckWordPressAPI
        .validateCode(email: userAndEmailController.text, code: validateCode)
        .then((value) {
      if (value?.data?.status == 200) {
        showCustomSnackBar(value?.message, isError: false);
        Get.to(const ResetPassWordScreen());
      }
    });

    isLoading = false;
    update();
  }

  Future<void> setNewPassword() async {
    isLoading = true;
    update();

    await ckWordPressAPI
        .setPassword(
            email: userAndEmailController.text,
            code: validateCode,
            password: confirmPasswordController.text)
        .then((value) {
      if (value?.data?.status == 200) {
        showCustomSnackBar(value?.message, isError: false);
        Get.to(const SignInScreen());
      }
    });

    isLoading = false;
    update();
  }
}
