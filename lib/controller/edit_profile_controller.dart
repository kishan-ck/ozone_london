import 'package:ck_woocommerce_api/models/create_user_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';

class EditProfileController extends GetxController {
  final formkey = GlobalKey<FormState>();

  bool isLoading = false;

  CreateUserDataModel? createUserDataModel;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();

  Future<void> editUserData() async {
    isLoading = true;
    update();

    String userId = getStorage.read("id");
    print("USER ID ====> $userId");

    await wooCommerceAPI.updateUser(userId: userId, body: {
      "email": emailAddressController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
    }).then((value) {
      if (value != null) {
        getStorage.write("email", value.email);
        getStorage.write("name", value.firstName);
        getStorage.write("lastName", value.lastName);
        createUserDataModel = value;
        Get.back();
        showCustomSnackBar("user_updated_successfully".tr, isError: false);
      }
    });

    isLoading = false;
    update();
  }
}
