import 'package:flutter/material.dart';
import '../screens/order_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/products_overview_screen.dart';

class DrawerBuild extends StatelessWidget {
  const DrawerBuild({Key key}) : super(key: key);

  Widget drawerListTile(
      BuildContext context, String title, IconData icon, String goToScreeen) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryTextTheme.headline6.color),
      ),
      trailing: Icon(
        icon,
        size: 26,
        color: Colors.white,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(goToScreeen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(187, 0, 43, 91), Colors.tealAccent],
          ),
        ),
        child: Column(
          children: [
            Material(
              elevation: 5,
              child: Container(
                width: double.infinity,
                height: 88,
                color: Color.fromARGB(187, 0, 43, 91),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Shop App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Divider(),
            drawerListTile(context, "My orders", Icons.shopping_bag,
                OrdersScreen.routeName),
            Divider(),
            drawerListTile(context, "Home Page", Icons.home,
                ProductsOverviewScreen.routeName),
            Divider(),
            drawerListTile(context, "Manage products", Icons.settings,
                UserProductsScreen.routeName),
            Divider(),
          ],
        ),
      ),
    );
  }
}
