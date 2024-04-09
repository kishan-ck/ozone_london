import 'package:ck_woocommerce_api/ck_woocommerce_api.dart';
import 'package:ck_wordpress_api/all_imports.dart';
import 'package:ozone_london/constant/api_url.dart';

ck_WooCommerceAPI wooCommerceAPI = ck_WooCommerceAPI(
    url: Repo.baseUrl,
    consumerKey: Repo.consumerKey,
    consumerSecret: Repo.consumerSecret);

CkWordPressAPI ckWordPressAPI = CkWordPressAPI(baseUrl: Repo.baseUrl);
