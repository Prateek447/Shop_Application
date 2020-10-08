import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapplication/providers/orders.dart' show Orders;
import 'package:shopapplication/widgets/drawer.dart';
import 'package:shopapplication/widgets/orders_item.dart' ;

class OrderScreen extends StatelessWidget {



  static final routeName  = 'orders-screen';


  @override
  Widget build(BuildContext context) {

    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(itemCount: ordersData.orders.length,itemBuilder:(ctx,index){
        return OrderItem(ordersData.orders[index]);
      },),
    );
  }
}
