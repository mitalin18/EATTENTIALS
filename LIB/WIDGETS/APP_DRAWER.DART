import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/product_overview_screen.dart';
import '../screens/coperative_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
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
            title: Text('Menu'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Cooperative Store'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CoperativeScreen.routeName);
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
          )
        ],
      ),
    );
  }
}
