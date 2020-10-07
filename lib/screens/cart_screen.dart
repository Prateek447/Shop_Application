import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapplication/providers/cart.dart' show Cart;
import 'package:shopapplication/widgets/cart_item.dart';


class CartScreen extends StatelessWidget {
  static final modalRoute = 'Cart-Screen';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartData.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.pink,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'ORDER NOW',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return CartItem(
                  proId: cartData.items.keys.toList()[index],
                  title: cartData.items.values.toList()[index].title,
                  id: cartData.items.values.toList()[index].id,
                  price: cartData.items.values.toList()[index].price,
                  quantity: cartData.items.values.toList()[index].quantity,
                );
              },
              itemCount: cartData.length,
            ),
          ),
        ],
      ),
    );
  }
}
