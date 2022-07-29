import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/items.dart';
import '../widgets/user_item.dart';
import '../widgets/app_drawer2.dart';
import './edit_item_screen.dart';

class UserItemsScreen extends StatelessWidget {
  static const routeName = '/user-items';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Items>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Items>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Items'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditItemScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer2(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserItem(
                  productsData.items[i].id,
                  productsData.items[i].title,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
