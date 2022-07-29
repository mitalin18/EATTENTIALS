import 'package:flutter/foundation.dart';

class Item with ChangeNotifier {
  final String id;
  final String title;
  final String status;
  final double price;

  Item({
    @required this.id,
    @required this.title,
    @required this.status,
    @required this.price,
  });
}
