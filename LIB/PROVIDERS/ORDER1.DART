import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import './cart.dart';

class OrderItem {
  String email;
  final String id;
  var oid;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.email,
    @required this.id,
    @required this.oid,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  FirebaseAuth mAuth2 = FirebaseAuth.instance;
  Future<FirebaseUser> currentuser2 = FirebaseAuth.instance.currentUser();

  Future<String> inputdata() async {
    final FirebaseUser user = await mAuth2.currentUser();
    final uid = user.uid;
    print(uid);
    return uid;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var email = user.email;
    var url =
        "https://eattentials1-57f44-default-rtdb.firebaseio.com/orders/adminorders.json";
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          email: orderData[email],
          id: orderId,
          oid: orderData['oid'],
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(
      List<CartItem> cartProducts, double total, var oid) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var email = user.email;
    var url =
        "https://eattentials1-57f44-default-rtdb.firebaseio.com/orders/adminorders.json";
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'oid': oid,
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        email: email,
        oid: oid,
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
