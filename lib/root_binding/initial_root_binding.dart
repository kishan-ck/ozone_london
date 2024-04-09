import 'package:get/get.dart';
import 'package:ozone_london/controller/address_controller.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/controller/checkout_controller.dart';
import 'package:ozone_london/controller/edit_profile_controller.dart';
import 'package:ozone_london/controller/forgot_password_controller.dart';
import 'package:ozone_london/controller/home_controller.dart';
import 'package:ozone_london/controller/order_controller.dart';
import 'package:ozone_london/controller/product_category_controller.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/controller/profile_controller.dart';
import 'package:ozone_london/controller/searchController.dart';
import 'package:ozone_london/controller/sign_in_controller.dart';
import 'package:ozone_london/controller/sign_up_controller.dart';
import 'package:ozone_london/controller/splash_controller.dart';
import 'package:ozone_london/controller/wishlist_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(HomeController());
    Get.put(ProductDetailController());
    Get.put(ProductListController());
    Get.put(ForgotPasswordController());
    Get.put(ProductCategoryController());
    Get.put(ProfileController());
    Get.put(CartController(), permanent: true);
    Get.put(EditProfileController());
    Get.put(AddressController());
    Get.put(CheckOutController());
    Get.put(OrderController());
    Get.put(searchController());
    Get.put(WishListController());
    // Get.lazyPut(() => ProductDetailController());
  }
}
