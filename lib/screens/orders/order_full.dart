import 'package:ECommerceApp/inner_screens/product_details.dart';
import 'package:ECommerceApp/models/orders_attr.dart';
import 'package:ECommerceApp/provider/cart_provider.dart';
import 'package:ECommerceApp/provider/dark_theme_provider.dart';
import 'package:ECommerceApp/services/global_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class OrderFull extends StatefulWidget {
  @override
  _OrderFullState createState() => _OrderFullState();
}

class _OrderFullState extends State<OrderFull> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final orderAttrProvider = Provider.of<OrdersAttr>(context);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: orderAttrProvider.productId),
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(orderAttrProvider.imageUrl),
                  //  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            orderAttrProvider.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            // splashColor: ,
                            onTap: () {
                              globalMethods.showDialogg(
                                  'Remove order!', 'Order wwill be deleted!',
                                  () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await FirebaseFirestore.instance
                                    .collection('order')
                                    .doc(orderAttrProvider.orderId)
                                    .delete();
                               
                              }, context);
                              //
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: _isLoading
                                  ? CircularProgressIndicator()
                                  : Icon(
                                      Entypo.cross,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Price:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${orderAttrProvider.price}\$',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Quantity:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'x${orderAttrProvider.quantity}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(child: Text('Order ID:')),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            'x${orderAttrProvider.orderId}',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
