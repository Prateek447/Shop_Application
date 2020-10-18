import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapplication/providers/products_provider.dart';
import 'package:shopapplication/widgets/drawer.dart';

import '../widgets/user_product_item.dart';

import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProd(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndGetProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding again....');
    final productsData = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _refreshProd(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshProd(context),
                      child: Consumer<Products>(
                        builder: (ctx, prodData, _) => Padding(
                          padding: EdgeInsets.all(8),
                          child: ListView.builder(
                            itemCount: productsData.items.length,
                            itemBuilder: (_, i) => Column(
                              children: [
                                UserProductItem(
                                  productsData.items[i].id,
                                  productsData.items[i].title,
                                  productsData.items[i].imageUrl,
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
