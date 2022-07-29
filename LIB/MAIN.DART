import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';
import './screens/auth_screen1.dart';
import './screens/orders_screen1.dart';
import './screens/coperative_screen.dart';
import './screens/coperative_screen1.dart';
import './screens/product_overview_screen1.dart';
import './screens/product_overview_screen.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/items.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/user_items_screen.dart';
import './screens/edit_item_screen.dart';
import './screens/landing_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Items(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
          title: 'Eattentials',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.pink,
            fontFamily: 'Satisfy',
          ),
          home: LandingScreen(),
          routes: {
            ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
            ProductsOverviewScreen1.routeName: (ctx) =>
                ProductsOverviewScreen1(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CoperativeScreen.routeName: (ctx) => CoperativeScreen(),
            CoperativeScreen1.routeName: (ctx) => CoperativeScreen1(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            OrdersScreen1.routeName: (ctx) => OrdersScreen1(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            UserItemsScreen.routeName: (ctx) => UserItemsScreen(),
            EditItemScreen.routeName: (ctx) => EditItemScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            AuthScreen1.routeName: (ctx) => AuthScreen1(),
          }),
    );
  }
}
