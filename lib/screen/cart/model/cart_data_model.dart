import 'package:flutter/material.dart';

class CartDataModel {
  final String? name;
  final String? image;
  final String? description;
  final String? price;
  final String? selectedColor;
  final String? selectedSize;
  int count;
  TextEditingController countController = TextEditingController();

  CartDataModel(
      {this.name,
      this.image,
      this.count = 1,
      this.description,
      this.price,
      this.selectedColor = "",
      this.selectedSize = ""}) {
    countController = TextEditingController(text: count.toString());
  }

  CartDataModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        image = json["image"] as String?,
        description = json["description"] as String?,
        price = json["price"] as String?,
        selectedColor = json["selectedColor"] as String?,
        selectedSize = json["selectedSize"] as String?,
        // countController = json["countController"],
        count = json['count'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        "image": image,
        "selectedSize": selectedSize,
        "selectedColor": selectedColor,
        // "countController": countController,
        'count': count,
      };
}
