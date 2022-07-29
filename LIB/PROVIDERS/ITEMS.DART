import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import './item.dart';

class Items with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items {
    return [..._items];
  }

  Item findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://eattentials1-57f44-default-rtdb.firebaseio.com/items.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Item> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Item(
          id: prodId,
          title: prodData['title'],
          status: prodData['status'],
          price: prodData['price'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addProduct(Item product) async {
    const url =
        'https://eattentials1-57f44-default-rtdb.firebaseio.com/items.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'status': product.status,
          'price': product.price,
        }),
      );
      final newProduct = Item(
        title: product.title,
        status: product.status,
        price: product.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(String id, Item newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://eattentials1-57f44-default-rtdb.firebaseio.com/items/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'status': newProduct.status,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://eattentials1-57f44-default-rtdb.firebaseio.com/items/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
