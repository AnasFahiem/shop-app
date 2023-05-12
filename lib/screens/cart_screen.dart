import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../screens/order_screen.dart';
import '../screens/products_overview_screen.dart';
import '../widgets/appbartheming.dart';
import '../widgets/badge.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class OrderButton extends StatefulWidget {
  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return TextButton(
      onPressed: (cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await order.addOrder(
                  cart.items.values.toList(), cart.totalAmount);
              cart.clearCart();
              _isLoading = false;
            },
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              "Order Now!",
              style: TextStyle(
                color: Color.fromARGB(187, 0, 43, 91),
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}

class _CartScreenState extends State<CartScreen> {
  var _isLoading = false;
  var _isInit = true;
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
              builder: (_, order, ch) => Stack(
                alignment: Alignment.center,
                children: [
                  ch,
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      // color: Theme.of(context).accentColor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        cart.itemCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
                ],
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
                      OrderButton(),
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
