import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/orders_screen1.dart';
import '../screens/product_overview_screen1.dart';

import '../screens/coperative_screen1.dart';
import '../screens/user_products_screen.dart';
import '../screens/user_items_screen.dart';

class AppDrawer2 extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Eattentials'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewScreen1.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('View Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen1.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Store Items'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserItemsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Cooperative Store'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CoperativeScreen1.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              _signOut();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
