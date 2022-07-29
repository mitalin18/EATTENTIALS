import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/items.dart';

class ItemsGrid extends StatelessWidget {
  final bool showFavorites;

  ItemsGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Items>(context);
    final items = productsData.items;

    return Container(
      height: 1000,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\₹${items[index].price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      items[index].title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\Status - ${items[index].status}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
