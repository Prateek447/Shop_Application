import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapplication/providers/cart.dart';
import 'package:shopapplication/providers/orders.dart';
import 'package:shopapplication/providers/products_provider.dart';
import 'package:shopapplication/screens/cart_screen.dart';
import 'package:shopapplication/screens/edit_product_screen.dart';
import 'package:shopapplication/screens/orders_screen.dart';
import 'package:shopapplication/screens/product_overview_screen.dart';
import 'package:shopapplication/screens/user_product_screen.dart';

import './screens/product_detail_screen.dart';

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
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
          title: 'CapRion',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.modalRoute: (ctx) => CartScreen(),
            OrderScreen.routeName:(_) => OrderScreen(),
            UserProductsScreen.routeName:(_) => UserProductsScreen(),
            EditProductScreen.routeName:(_) => EditProductScreen(),
          }),
    );
  }
}
