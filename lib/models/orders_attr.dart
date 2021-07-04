import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrdersAttr with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String title;
  final String price;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;

  OrdersAttr({this.orderId, this.userId, this.productId, this.title, this.price,
      this.imageUrl, this.quantity, this.orderDate});
}
