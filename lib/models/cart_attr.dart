import 'package:flutter/material.dart';

class CartAttr with ChangeNotifier {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartAttr({this.id, this.title, this.quantity, this.price, this.imageUrl});
}
