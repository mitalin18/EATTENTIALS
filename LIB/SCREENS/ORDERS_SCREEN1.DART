import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer2.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item1.dart';

class OrdersScreen1 extends StatefulWidget {
  static const routeName = '/orders1';

  @override
  _OrdersScreen1State createState() => _OrdersScreen1State();
}

class _OrdersScreen1State extends State<OrdersScreen1> {
  Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders1();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer2(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              print(dataSnapshot.error);
              return Center(
                child: Text('An error occurred'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
