import 'dart:math';

import 'package:ck_woocommerce_api/models/create_user_data_model.dart';
import 'package:ck_woocommerce_api/models/user_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:ozone_london/constant/dynamic_size.dart';

class AddressController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool isBillingEdit = false;
  bool isShippingEdit = false;
  bool isLoading = false;
  UserDetailModel? userDetailList = UserDetailModel();
  CreateUserDataModel? createUserDataModel = CreateUserDataModel();

  Future<void> fetchAddress() async {
    isLoading = true;
    update();
    await wooCommerceAPI
        .userDetails(userId: int.parse(getStorage.read("id").toString()))
        .then((value) {
      userDetailList = value;
    });
    isLoading = false;
    update();
  }

  Future<void> editBillingAddress() async {
    isLoading = true;
    update();
    await wooCommerceAPI.updateUser(body: {
      if (isBillingEdit)
        "billing": {
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "company": companyNameController.text,
          "country": countryController.text,
          "address_1": streetAddressController.text,
          "address_2": apartmentController.text,
          "city": cityController.text,
          "state": stateController.text,
          "postcode": pinCodeController.text,
          "phone": phoneNumberController.text.toString(),
        }
      else if (isShippingEdit)
        "shipping": {
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "company": companyNameController.text,
          "country": countryController.text,
          "address_1": streetAddressController.text,
          "address_2": apartmentController.text,
          "city": cityController.text,
          "state": stateController.text,
          "postcode": pinCodeController.text,
          "phone": phoneNumberController.text.toString(),
        }
    }, userId: int.parse(getStorage.read("id").toString())).then((value) {
      createUserDataModel = value;
      print("phone number:: ${createUserDataModel?.shipping?.phone}");
      print(
          "phone controller number:: ${phoneNumberController.text.toString()}");
    });
    isLoading = false;
    update();
  }

  void controllerTextForEditBilling() {
    if (userDetailList != null) {
      firstNameController.text = isBillingEdit
          ? userDetailList?.billing?.firstName ?? ""
          : isShippingEdit
              ? userDetailList?.shipping?.firstName ?? ""
              : "";
      lastNameController.text = isBillingEdit
          ? userDetailList?.billing?.lastName ?? ""
          : isShippingEdit
              ? userDetailList?.shipping?.lastName ?? ""
              : "";
      companyNameController.text = isBillingEdit
          ? userDetailList?.billing?.company ?? ""
          : isShippingEdit
              ? userDetailList?.shipping?.company ?? ""
              : "";
      countryController.text = isBillingEdit
          ? userDetailList?.billing?.country ?? ""
          : isShippingEdit
              ? userDetailList?.shipping?.country ?? ""
              : "";
      streetAddressController.text = isBillingEdit
          ? userDetailList?.billing?.address1 ?? ""
          : isShippingEdit
              ? userDetailList?.shipping?.address1 ?? ""
              : "";
      apartmentController.text = isBillingEdit
          ? userDetailList?.billing?.address2 ?? ""
          : isShippingEdit
              ? userDetailList?.shipping?.address2 ?? ""
              : "";
      cityController.text = isBillingEdit
          ? userDetailList?.billing?.city ?? ""
          : isShippingEdit
              ? userDetailList?.shipping?.city ?? ""
              : "";
      stateController.text = isBillingEdit
          ? userDetailList?.billing?.state ?? ""
          : isShippingEdit
              ? userDetailList?.shipping?.state ?? ""
              : "";
      pinCodeController.text = isBillingEdit
          ? userDetailList?.billing?.postcode ?? ""
          : isShippingEdit
              ? userDetailList?.shipping?.postcode ?? ""
              : "";
      phoneNumberController.text = isBillingEdit
          ? userDetailList?.billing?.phone ?? ""
          : isShippingEdit
              ? userDetailList?.shipping?.phone ?? ""
              : "";
    }
  }
}
