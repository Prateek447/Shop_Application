import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapplication/providers/auth.dart';
import 'package:shopapplication/providers/cart.dart';
import 'package:shopapplication/providers/orders.dart';
import 'package:shopapplication/providers/products_provider.dart';
import 'package:shopapplication/screens/auth_screen.dart';
import 'package:shopapplication/screens/cart_screen.dart';
import 'package:shopapplication/screens/edit_product_screen.dart';
import 'package:shopapplication/screens/orders_screen.dart';
import 'package:shopapplication/screens/product_overview_screen.dart';
import 'package:shopapplication/screens/splashScreen.dart';
import 'package:shopapplication/screens/user_product_screen.dart';

import './screens/product_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(),
          update: (_, auth, prev) => prev..update(auth.token, auth.userId),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'CapRion',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResSnapshot) =>
                        authResSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.modalRoute: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (_) => UserProductsScreen(),
              EditProductScreen.routeName: (_) => EditProductScreen(),
            }),
      ),
    );
  }
}
