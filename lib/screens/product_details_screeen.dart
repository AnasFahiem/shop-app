import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/products_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/appbartheming.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = "productDetailsScreeen";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarTheming(),
        title: Text(
          loadedProduct.title,
        ),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Stack(
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
                      color: Theme.of(context).colorScheme.primary,
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
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
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
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 2,
                    color: Color.fromARGB(187, 0, 43, 91),
                  ),
                  right: BorderSide(
                    width: 2,
                    color: Color.fromARGB(187, 0, 43, 91),
                  ),
                  left: BorderSide(
                    width: 2,
                    color: Color.fromARGB(187, 0, 43, 91),
                  ),
                ),
                color: Colors.transparent,
              ),
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(13),
                      bottomRight: Radius.circular(13),
                    ),
                    color: Colors.black45,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "\$${loadedProduct.price}",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge
                                      .color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                loadedProduct.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleLarge
                                      .color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            cart.addItem(
                              loadedProduct.id,
                              loadedProduct.price,
                              loadedProduct.title,
                            );
                          },
                          iconSize: 35,
                          icon: Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 3,
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      loadedProduct.description,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
