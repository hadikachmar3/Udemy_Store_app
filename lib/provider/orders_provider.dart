import 'package:ECommerceApp/models/orders_attr.dart';
import 'package:ECommerceApp/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OrdersProvider with ChangeNotifier {
  List<OrdersAttr> _orders = [];
  List<OrdersAttr> get getOrders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser;
    var _uid = _user.uid;
    print('the user Id is equal to $_uid');
    try {
      await FirebaseFirestore.instance
          .collection('order')
          .where('userId', isEqualTo: _uid)
          .get()
          .then((QuerySnapshot ordersSnapshot) {
        _orders.clear();
        ordersSnapshot.docs.forEach((element) {
          // print('element.get(productBrand), ${element.get('productBrand')}');
          _orders.insert(
              0,
              OrdersAttr(
                orderId: element.get('orderId'),
                productId: element.get('productId'),
                userId: element.get('userId'),
                price: element.get('price').toString(),
                quantity: element.get('quantity').toString(),
                imageUrl: element.get('imageUrl'),
                title: element.get('title'),
                orderDate: element.get('orderDate'),
              ));
        });
      });
    } catch (error) {
      print('Printing error wwhile fetching order $error');
    }
    notifyListeners();
  }
}
