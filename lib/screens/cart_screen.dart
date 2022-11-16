import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../screens/order_screen.dart';
import '../screens/products_overview_screen.dart';
import '../widgets/appbartheming.dart';
import '../widgets/badge.dart';

import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cartScreen";

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: AppBarTheming(),
          title: Text("your cart"),
          actions: [
            Consumer<Orders>(
              builder: (_, order, ch) => Badge(
                child: ch,
                value: order.itemCount.toString(),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(OrdersScreen.routeName);
                },
                icon: Icon(
                  Icons.shopping_bag,
                ),
              ),
            ),
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
          child: Column(
            children: [
              Card(
                color: Color.fromARGB(255, 225, 234, 231),
                elevation: 7,
                margin: EdgeInsets.only(right: 6, left: 6, top: 25, bottom: 8),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(187, 0, 43, 91)),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(
                          "\$${cart.totalAmount}",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color),
                        ),
                        backgroundColor: Color.fromARGB(187, 0, 43, 91),
                      ),
                      TextButton(
                        onPressed: () {
                          order.addOrder(
                              cart.items.values.toList(), cart.totalAmount);
                          cart.clearCart();
                        },
                        child: Text(
                          "Order Now!",
                          style: TextStyle(
                            color: Color.fromARGB(187, 0, 43, 91),
                            fontWeight: FontWeight.bold,
                          ),
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
                  itemCount: cart.itemCount,
                  itemBuilder: (context, index) => CartItem(
                    cart.items.values.toList()[index].id,
                    cart.items.keys.toList()[index],
                    cart.items.values.toList()[index].price,
                    cart.items.values.toList()[index].quantity,
                    cart.items.values.toList()[index].title,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
