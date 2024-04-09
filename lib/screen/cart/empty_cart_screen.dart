// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';
import 'package:ozone_london/screen/cart/widget/empty_cart_widget.dart';
import 'package:ozone_london/screen/cart/widget/saved_for_later_widget.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (context, value, child) {
        if (value == ConnectivityResult.none) {
          return Scaffold(
            body: InternetError(),
          );
        }
        return child;
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            EmptyCartWidget(),
            // Divider(height: 0),
            // SavedForLaterWidget(),
            // Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
