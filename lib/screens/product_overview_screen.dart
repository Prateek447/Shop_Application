import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapplication/widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caprion'),
      ),
      body: ProductsGrid(),
    );
  }
}
