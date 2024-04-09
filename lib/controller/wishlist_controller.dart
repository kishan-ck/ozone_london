import 'package:ck_wordpress_api/model/wishlist/wishlist_model.dart';
import 'package:get/get.dart';
import 'package:ozone_london/config/api_config.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';

class WishListController extends GetxController {
  bool isLoading = false;

  List<WishListModel> wishList = [];

  Future<void> getWishList() async {
    isLoading = true;
    update();
    await ckWordPressAPI
        .getWishList(userID: int.parse(getStorage.read("id").toString()))
        .then((value) {
      if (value != null) {
        wishList = value;
        isLoading = false;
        update();
      }
    });
  }

  Future<void> removeWishList({required int productID}) async {
    isLoading = true;
    update();
    await ckWordPressAPI
        .removeWishList(
            userID: int.parse(getStorage.read("id").toString()),
            productID: productID)
        .then((value) {
      if (value != null) {
        value.status == 1
            ? showCustomSnackBar(value.message, isError: false)
            : showCustomSnackBar(value.message);
        isLoading = false;
        update();
      }
    });
  }
}
