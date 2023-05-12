import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../screens/products_overview_screen.dart';
import '../widgets/appbartheming.dart';
import '../widgets/drawer.dart';
import '../widgets/order-item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orderScreen";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context).fetchAndSetOrders().then((_) {
        setState(() {
          _isLoading = false;
        });
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

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
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: order.orders.length,
                itemBuilder: (context, index) => OrderItem(order.orders[index]),
              ),
      ),
    );
  }
}
