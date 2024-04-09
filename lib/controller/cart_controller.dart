// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:ck_woocommerce_api/models/coupon_list_data_model.dart';
import 'package:ck_wordpress_api/model/apply_coupon/apply_coupon_model.dart';
import 'package:ck_wordpress_api/model/apply_coupon/remove_coupon_model.dart';
import 'package:ck_wordpress_api/model/cart/cart_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/screen/cart/model/cart_data_model.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  ScrollController scrollController = ScrollController();
  bool isHaveCoupon = false;
  TextEditingController couponCodeController = TextEditingController();
  List<CoupenListDataModel> couponList = [];
  int cartValue = 1;
  bool isLoading = false;
  double discount = 4.0;
  List<CartDataModel> cartList = [];
  ApplyCouponModel? applyCouponModel = ApplyCouponModel();
  RemoveCouponModel? removeCouponModel = RemoveCouponModel();
  Map<String, dynamic>? paymentIntent;

  // List<CartListModel> getCartList = [];
  int cartCount = 0;
  double cartSubTotal = 0;
  double total = 0;
  bool isRemove = false;
  bool cartIsEmpty = false;
  String couponCode = "";
  String discountAmount = "";

  addToCart({
    required String productName,
    required String productImage,
    required String productPrise,
    required int productCount,
    required String? selectedColor,
    required String? selectedSize,
  }) async {
    List<CartDataModel> cart = [];
    CartDataModel cartData = CartDataModel(
        name: productName,
        image: productImage,
        price: productPrise,
        description: productName,
        selectedColor: selectedColor,
        selectedSize: selectedSize,
        count: productCount);
    cartList.add(cartData);
    getStorage.write('cartList', cartList.map((e) => e.toJson()).toList());

    update();
  }

  updateCartCount(int index, int val) {
    final count =
    cartList.firstWhere((item) => item.name == cartList[index].name);
    count.count = val;
    count.countController.text = val.toString();
    update();
  }

  removeItem(int index) async {
    isRemove = true;
    update();
    final data = await getStorage.read('cartList');
    Future.delayed(const Duration(seconds: 2), () async {
      data.removeWhere((element) {
        return (element["name"] == cartList[index].name &&
            element["selectedColor"] == cartList[index].selectedColor &&
            element["selectedSize"] == cartList[index].selectedSize);
      });
      await cartOrderSummary();
      final newData = await getStorage.read('cartList');
      cartList.clear();
      await getStorage.remove("cartList");
      getStorage.write("cartList", newData);

      cartList = (newData as List<dynamic>)
          .map((e) => CartDataModel.fromJson(e))
          .toList();
      isRemove = false;
      update();
    });
  }

  cartOrderSummary() async {
    final data = await getStorage.read('cartList');
    double subTotal = 0.0;
    int countData = 0;

    for (int i = 0; i < data.length; i++) {
      String cleanedPriceString =
      data[i]["price"]!.replaceAll(RegExp('[^0-9.]'), '');
      double price = double.parse(cleanedPriceString);
      int count = data[i]["count"];
      countData += count;
      subTotal += (price * count);
    }
    cartCount = countData;
    print("cart Count:: $cartCount");
    cartSubTotal = subTotal;
    total = 0;
    total = cartSubTotal - discount;
    // double.parse(applyCouponModel?.coupondata?[0].amount.toString() ?? "");
    update();
  }

  Future<void> fetchCouponList() async {
    isLoading = true;
    update();
    await wooCommerceAPI.getCouponList().then((value) {
      if (value != null) {
        couponList = value;
      }
    });
    isLoading = false;
    update();
  }

  setCouponData() async {
    couponCode = await getStorage.read("couponCode");
    discountAmount = await getStorage.read("discountAmount");
    print("discount:: $discountAmount");
    update();
  }

  cartItemCountDecrement(int index) async {
    if (cartList[index].count > 1) {
      List data = await getStorage.read('cartList');

      final dataCount = data.where((element) {
        return (element["name"] == cartList[index].name &&
            element["selectedColor"] == cartList[index].selectedColor &&
            element["selectedSize"] == cartList[index].selectedSize);
      }).toList();

      dataCount[0]["count"]--;
      cartList[index].count--;
      cartOrderSummary();
      update();
      final newData = await getStorage.read('cartList');
      cartList.clear();
      await getStorage.remove("cartList");
      getStorage.write("cartList", newData);

      cartList = (newData as List<dynamic>)
          .map((e) => CartDataModel.fromJson(e))
          .toList();

      // widget.onChange(widget.cartData!.count);
      update();
    }
  }

  cartItemCountIncrement(int index) async {
    List data = await getStorage.read('cartList');

    final dataCount = data.where((element) {
      return (element["name"] == cartList[index].name &&
          element["selectedColor"] == cartList[index].selectedColor &&
          element["selectedSize"] == cartList[index].selectedSize);
    }).toList();

    dataCount[0]["count"]++;
    cartList[index].count++;
    cartOrderSummary();
    update();
    final newData = await getStorage.read('cartList');
    cartList.clear();
    await getStorage.remove("cartList");
    getStorage.write("cartList", newData);

    cartList = (newData as List<dynamic>)
        .map((e) => CartDataModel.fromJson(e))
        .toList();

    update();
  }

  Future<void> applyCoupon({required String couponCode}) async {
    isLoading = true;
    update();
    await ckWordPressAPI
        .applyCoupon(
      couponCode: couponCode,
      userId: int.parse(getStorage.read("id").toString()),
    )
        .then((value) {
      if (value != null) {
        applyCouponModel = value;
      }
    });
    isLoading = false;
    update();
  }

  Future<void> removeCoupon({required String couponCode}) async {
    isLoading = true;
    update();
    await ckWordPressAPI
        .removeCoupon(
      couponCode: couponCode,
      userId: int.parse(getStorage.read("id").toString()),
    )
        .then((value) {
      if (value != null) {
        removeCouponModel = value;
      }
    });
    isLoading = false;
    update();
  }

  Future<void> makePayment() async {
    try {
      final paymentIntent = await createPaymentIntent();

      var gpay = PaymentSheetGooglePay(
          merchantCountryCode: "US", testEnv: true, currencyCode: "USD");


      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            // customFlow: true,
            // customerId: paymentIntent["customer"],
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              //Gotten from payment intent
              // style: ThemeMode.dark,
              googlePay: gpay,
              merchantDisplayName: 'test'))
          .then((value) async {
        print("Make PAyment");
        displayPaymentSheet();
        // await Stripe.instance.presentPaymentSheet().then((value) {
        //   print("presentPaymentSheet ==> ");
        // });
      });

      //STEP 3: Display Payment sheet
    } catch (err) {
      print("make payment error:: $err");
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent() async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': total.toStringAsFixed(0),
        'currency': "USD",
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
          'Bearer sk_test_51MVlbaIKGm5xzOMe3BD4V9Zjtpudwqi1ulDAkWYYpXnjI9uAudYO7gKRj11NFbxOxvKPqHseFh7H0xOUGY5xidpU00SYYvxJaG',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print("createPaymentIntent ===> ${json.decode(response.body)}");
      return json.decode(response.body);
    } catch (err) {
      throw Exception("error :: ${err.toString()}");
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

// Future<void> getCartListData() async {
//   isLoading = true;
//   update();
//   await ckWordPressAPI
//       .getCartList(userID: int.parse(getStorage.read("id").toString()))
//       .then((value) {
//     if (value != null) {
//       getCartList = value;
//       isLoading = false;
//       update();
//     }
//   });
// }
}
