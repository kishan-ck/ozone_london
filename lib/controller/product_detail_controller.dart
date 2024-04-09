// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:ck_woocommerce_api/models/productDetailDataModel.dart';
import 'package:ck_woocommerce_api/models/product_review_data_model.dart';
import 'package:ck_wordpress_api/model/cart/add_to_cart.dart';
import 'package:ck_wordpress_api/model/product_question_answer/product_question_answer_model.dart';
import 'package:ck_wordpress_api/model/product_question_answer/submit_question_model.dart';
import 'package:ck_wordpress_api/model/wishlist/add_wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';
import 'package:ozone_london/screen/cart/widget/add_to_cart_dialog.dart';

class ProductDetailController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ScrollController scrollController = ScrollController();
  TextEditingController cartCountController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController askQuestionController = TextEditingController();

  String selectedSize = '';
  String selectedColor = '';
  int cartValue = 1;
  int currentImageIndex = 0;
  bool isLoading = false;
  int count = 1;
  ProductDetailsDataModel? productDetailModel;
  List<ProductReviewDataModel>? productReviewDataModel;
  List<ProductDetailsDataModel>? productDetailDataList;
  List<String> productDetailsColorList = [];
  List<ProductQuestionAnswerModel> productQuestionAnswerList = [];
  AddWishListModel? addWishListModel = AddWishListModel();
  SubmitQuestionModel? submitQuestionModel = SubmitQuestionModel();
  SubmitQuestionModel? questionModel = SubmitQuestionModel();
  AddToCartModel? addToCartModel = AddToCartModel();

  @override
  void onInit() {
    super.onInit();
    cartCountController = TextEditingController(text: cartValue.toString());
  }

  Future<void> productDetail(
      {required int productId, required List<int> productsId}) async {
    isLoading = true;
    update();

    await wooCommerceAPI.getProductDetails(id: productId).then((value) {
      if (value != null) {
        productDetailModel = value;
      }
    });

    await wooCommerceAPI
        .getProductReviewList(productId: productId)
        .then((value) {
      if (value != null) {
        productReviewDataModel = value;
      }
    });

    await wooCommerceAPI
        .getProductRelatedList(products: productsId)
        .then((value) {
      if (value != null) {
        productDetailDataList = value;
      }
    });

    await getProductQuestionAnswerList(productId: productId);

    isLoading = false;
    update();
  }

  Future<void> writeReview({required Map<String, dynamic> body}) async {
    isLoading = true;
    update();
    await wooCommerceAPI.createProductReview(body: body).then((value) {
      if (value != null) {
        reviewController.clear();
        productReviewDataModel?.add(value);
        isLoading = false;
        update();
      }
    });
  }

  String? isDiscount(String? price, String? salePrice) {
    if (price == null ||
        salePrice == null ||
        salePrice.toString().isEmpty ||
        price.toString().isEmpty) {
      return null;
    } else {
      double pr = double.parse(price.toString());
      double spr = double.parse(salePrice.toString());
      if (pr > 0 && spr > 0) {
        double temp = pr - spr;
        double temp2 = temp / pr;
        double temp3 = temp2 * 100;

        return temp3.toString().split(".").first;
      } else {
        return null;
      }
    }
  }

  addItemToCartWithColorAndSizeCheck() {
    Iterable<DefaultAttributes>? productSize = productDetailModel
        ?.defaultAttributes
        ?.where((element) => element.id == 1)
        .toList();
    print("size:: $productSize");

    Iterable<DefaultAttributes>? productColor = productDetailModel
        ?.defaultAttributes
        ?.where((element) => element.id == 2)
        .toList();
    print("Color:: ${productColor}");

    if (productSize!.isNotEmpty && productColor!.isEmpty) {
      if (selectedSize == "") {
        showCustomSnackBar("Please Select Size Product");
      } else {
        // addToCart(
        //     productId: productDetailModel?.id ?? 0,
        //     quantity: int.parse(cartCountController.text),
        //     color: null,
        //     size: int.parse(selectedSize));
        final cartValue = int.parse(cartCountController.text);
        Get.find<CartController>().addToCart(
            productName: productDetailModel?.name ?? "",
            productImage: productDetailModel?.images?[0].src ?? "",
            selectedColor: "",
            selectedSize: selectedSize,
            productPrise: productDetailModel?.price ?? "",
            productCount: cartValue);
        selectedColor = "";
        selectedSize = "";
        update();
        Get.dialog(
          Dialog(
              insetPadding: EdgeInsets.all(15),
              child: AddToCartDialog(
                  productName: productDetailModel!.name ?? "",
                  image: productDetailModel?.images?[0].src ?? "")),
        );
      }
    }
    if (productSize.isEmpty && productColor!.isNotEmpty) {
      if (selectedColor == "") {
        showCustomSnackBar("Please Select Color of Product");
      } else {
        // addToCart(
        //     productId: productDetailModel?.id ?? 0,
        //     quantity: int.parse(cartCountController.text),
        //     color: selectedColor.toLowerCase(),
        //     size: null);
        final cartValue = int.parse(cartCountController.text);
        Get.find<CartController>().addToCart(
            productName: productDetailModel?.name ?? "",
            productImage: productDetailModel?.images?[0].src ?? "",
            selectedColor: selectedColor,
            selectedSize: "",
            productPrise: productDetailModel?.price ?? "",
            productCount: cartValue);
        selectedColor = "";
        selectedSize = "";
        update();
        Get.dialog(
          Dialog(
              insetPadding: EdgeInsets.all(15),
              child: AddToCartDialog(
                  productName: productDetailModel!.name ?? "",
                  image: productDetailModel?.images?[0].src ?? "")),
        );
      }
    }

    if (productSize.isNotEmpty && productColor!.isNotEmpty) {
      if (selectedSize == "" || selectedColor == "") {
        showCustomSnackBar("Please Select Size and Color of Product");
      } else {
        // addToCart(
        //     productId: productDetailModel?.id ?? 0,
        //     quantity: int.parse(cartCountController.text),
        //     color: selectedColor.toLowerCase(),
        //     size: int.parse(selectedSize));
        final cartValue = int.parse(cartCountController.text);
        Get.find<CartController>().addToCart(
            productName: productDetailModel?.name ?? "",
            productImage: productDetailModel?.images?[0].src ?? "",
            selectedColor: selectedColor,
            selectedSize: selectedSize,
            productPrise: productDetailModel?.price ?? "",
            productCount: cartValue);
        selectedColor = "";
        selectedSize = "";
        update();
        Get.dialog(
          Dialog(
              insetPadding: EdgeInsets.all(15),
              child: AddToCartDialog(
                  productName: productDetailModel!.name ?? "",
                  image: productDetailModel?.images?[0].src ?? "")),
        );
      }
    } else if (productSize.isEmpty && productColor!.isEmpty) {
      // addToCart(
      //     productId: productDetailModel?.id ?? 0,
      //     quantity: int.parse(cartCountController.text),
      //     color: null,
      //     size: null);
      final cartValue = int.parse(cartCountController.text);
      Get.find<CartController>().addToCart(
          productName: productDetailModel?.name ?? "",
          productImage: productDetailModel?.images?[0].src ?? "",
          selectedSize: "",
          selectedColor: "",
          productPrise: productDetailModel?.price ?? "",
          productCount: cartValue);

      Get.dialog(
        Dialog(
            insetPadding: EdgeInsets.all(15),
            child: AddToCartDialog(
                productName: productDetailModel!.name ?? "",
                image: productDetailModel?.images?[0].src ?? "")),
      );
    }
    update();
  }

  Future<void> addWishListProduct(int productID) async {
    isLoading = true;
    update();
    await ckWordPressAPI
        .addWishList(
            userID: int.parse(getStorage.read("id").toString()),
            productID: productID)
        .then((value) {
      addWishListModel = value;
    });
    isLoading = false;
    update();
  }

  Future<void> submitQuestion({required int productID}) async {
    isLoading = true;
    update();
    await ckWordPressAPI
        .submitQuestion(
            userID: int.parse(getStorage.read("id").toString()),
            productID: productID,
            questionContent: askQuestionController.text)
        .then((value) {
      submitQuestionModel = value;
    });
    isLoading = false;
    update();
  }

  Future<void> questionReply(
      {required int productId, required int parentId}) async {
    isLoading = true;
    update();
    await ckWordPressAPI
        .questionReply(
            userID: int.parse(getStorage.read("id").toString()),
            productID: productId,
            parentID: parentId,
            questionContent: askQuestionController.text)
        .then((value) {
      questionModel = value;
    });
    isLoading = false;
    update();
  }

  Future<void> getProductQuestionAnswerList({required int productId}) async {
    isLoading = true;
    update();
    await ckWordPressAPI
        .getProductQuestionAnswerList(productID: productId)
        .then((value) {
      productQuestionAnswerList = value ?? [];
    });
    isLoading = false;
    update();
  }

  Future<void> addToCart(
      {required int productId,
      required int quantity,
      int? size,
      String? color}) async {
    print("add to cart value:: ${int.parse(getStorage.read("id").toString())}");
    print("add to cart value:: ${productId}");
    print("add to cart value:: ${quantity}");
    print("add to cart value:: ${size}");
    print("add to cart value:: ${color}");

    await ckWordPressAPI
        .addToCart(
            userID: int.parse(getStorage.read("id").toString()),
            productID: productId,
            quantity: quantity,
            size: size ?? 0,
            color: color ?? "")
        .then((value) {
      addToCartModel = value;
      print("add to cart:: $addToCartModel");
      print("add to cart value:: $value");
    });
  }
}
