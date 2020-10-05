import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FavoriteOptions {
  onlyFavorites,
  showAll,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var favOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CapRion'),
        actions: [
          PopupMenuButton(
            onSelected: (FavoriteOptions selectedItem) {
              setState(() {
                if (selectedItem == FavoriteOptions.onlyFavorites) {
                  favOnly = true;
                } else {
                  favOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorites Only'),
                value: FavoriteOptions.onlyFavorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FavoriteOptions.showAll,
              ),
            ],
          ),
        ],
      ),
      body: ProductsGrid(favOnly),
    );
  }
}
