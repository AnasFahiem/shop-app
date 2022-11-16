import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../screens/products_overview_screen.dart';
import '../widgets/appbartheming.dart';
import '../widgets/drawer.dart';
import '../widgets/order-item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orderScreen";
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);
    return Scaffold(
      drawer: DrawerBuild(),
      appBar: AppBar(
        flexibleSpace: AppBarTheming(),
        title: Text("your orders"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewScreen.routeName);
            },
            icon: Icon(Icons.home_outlined),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(187, 0, 43, 91), Colors.teal],
          ),
        ),
        child: ListView.builder(
          itemCount: order.orders.length,
          itemBuilder: (context, index) => OrderItem(order.orders[index]),
        ),
      ),
    );
  }
}
