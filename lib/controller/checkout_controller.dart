import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ozone_london/constant/colors.dart';

class CheckOutController extends GetxController {
  int radioValue = 0;
  bool isPaymentExist = false;

  late List paymentMethodList;

  DateTime selectedDate = DateTime.now();
  final dateFormat = DateFormat('mm/yyyy');

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  void onInit() {
    paymentMethodList = <_PaymentModel>[
      isPaymentExist
          ? _PaymentModel(
              title: 'credit_card_or_debit_card'.tr,
              svg: 'assets/images/visa_icon.svg')
          : _PaymentModel(
              title: 'credit_card_or_debit_card'.tr,
              svg: 'assets/images/debit_card_icon.svg'),
      _PaymentModel(
          title: 'cash_on_delivery'.tr,
          svg: 'assets/images/cash_on_delivery_icon.svg'),
      _PaymentModel(title: 'paypal'.tr, svg: 'assets/images/paypal_icon.svg'),
    ];
    super.onInit();
  }

  Future selectDate({required BuildContext context}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(selectedDate.month, selectedDate.day),
      lastDate: DateTime(2050),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: primaryBlackColor)),
        child: child!,
      ),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      expDateController.text = dateFormat.format(selectedDate);
      update();
    }
  }
}

class _PaymentModel {
  final String title;
  final String svg;

  _PaymentModel({required this.title, required this.svg});
}
