import 'package:flutter/material.dart';
import './screens/product_detail_screen.dart';
import 'screens/product_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caprion',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.deepOrange
      ),
      home: ProductOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName:(ctx) => ProductDetailScreen(),
      },
    );
  }
}
