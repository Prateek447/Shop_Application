import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapplication/providers/cart.dart';
import 'package:shopapplication/providers/products_provider.dart';
import 'package:shopapplication/screens/cart_screen.dart';
import 'package:shopapplication/widgets/badge.dart';
import 'package:shopapplication/widgets/drawer.dart';

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
  var _isInit = true;
  var _isLoading= false;

  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndGetProduct(); IT WON'T WORK IN THE INIT STATE
//     Future.delayed(Duration.zero).then((_){
//       Provider.of<Products>(context).fetchAndGetProduct();
//     });                       IT CAN WORK BECAUSE IT EXECUTE AFTER EVERYTHING WIRED UP
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit) {
      setState(() {
        _isLoading=true;
      });
      Provider.of<Products>(context).fetchAndGetProduct().then((value){
        setState(() {
          _isLoading=false;
        });
      });
    }
    _isInit=false;
    super.didChangeDependencies();
  }
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
          Consumer<Cart>(
            builder: (_, cartData, noReBuild) {
              return Badge(child: noReBuild, value: cartData.length.toString());
            },
            child: IconButton(
                icon: Icon(Icons.add_shopping_cart), onPressed:(){
                  Navigator.of(context).pushNamed(CartScreen.modalRoute);
            }),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator()):ProductsGrid(favOnly),
    );
  }
}
