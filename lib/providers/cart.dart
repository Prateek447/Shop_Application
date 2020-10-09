import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get length {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartI) {
      total += cartI.quantity * cartI.price;
    });
    return total;
  }

  void addItem(String id, String title, int quantity, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (existValue) => CartItem(
              id: existValue.id,
              title: existValue.title,
              price: existValue.price,
              quantity: existValue.quantity + 1));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String proId) {
    _items.remove(proId);
    notifyListeners();
  }

  void removeSingleItem(String proId) {
    if (!_items.containsKey(proId)) return;

    if(_items[proId].quantity>1) {
      _items.update(
          proId,
              (existValue) =>
              CartItem(
                  id: existValue.id,
                  title: existValue.title,
                  price: existValue.price,
                  quantity: existValue.quantity - 1));
    }
    else
      _items.remove(proId);

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
