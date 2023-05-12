import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:http/http.dart' as http;

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String prodId, double price, String title) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity + 1,
                price: existingCartItem.price,
              ));
    } else {
      _items.putIfAbsent(
        prodId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity - 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

//make this code better :
  Future<void> addCartItem(String prodId, double price, String title,
      int quantity, Product updated) async {
    final url = Uri.parse(
        'https://sshoopp-aapppp22-default-rtdb.firebaseio.com/cart.json');
    final responsePost = await http.post(url,
        body: json.encode({
          'id': prodId,
          'title': title,
          'quantity': quantity,
          'price': price,
        }));
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity + quantity,
                price: existingCartItem.price,
              ));
    } else {
      _items.putIfAbsent(
        prodId,
        () => CartItem(
          id: json.decode(responsePost.body)['name'],
          title: title,
          quantity: quantity + 1,
          price: price,
        ),
      );
      notifyListeners();
    }
  }

//fix this code :
//   Future<void> fetchAndSetCartItem() async {
//     final url = Uri.parse(
//         'https://sshoopp-aapppp22-default-rtdb.firebaseio.com/orders.json');
//     final response = await http.get(url);
//     final Map<String, CartItem> loadedCartItems = {};
//     final extractedData = json.decode(response.body) as Map<String, dynamic>;
//     if (extractedData == null) {
//       print("no data");
//       return;
//     }
//     extractedData.forEach((prodId, prodData) {
//       loadedCartItems.putIfAbsent(
//           prodId,
//           () => CartItem(
//                 id: prodId,
//                 title: prodData['title'],
//                 price: prodData['price'],
//               ));
//     });
//     _items = loadedCartItems;
//     if (response.body == null) {
//       print("no data");
//       return;
//     }
//     notifyListeners();
//   }
}
