import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart.dart';
import '../screens/edit_product_screen.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/appbartheming.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = "ProductOverView";
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavorite = false;
  var _isInit = false;
  var _isLoading = false;
  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((value) {
  //     Provider.of<Products>(context).fetchAndSetProducts();
  //   });

  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Products>(context, listen: false).fetchAndSetProducts();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        flexibleSpace: AppBarTheming(),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedVal) {
              setState(() {
                if (selectedVal == FilterOptions.Favorites) {
                  _showFavorite = true;
                } else {
                  _showFavorite = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Favorites",
                      style: TextStyle(
                        color: Color.fromARGB(187, 0, 43, 91),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Color.fromARGB(187, 0, 43, 91),
                    ),
                  ],
                ),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Show all",
                      style: TextStyle(
                        color: Color.fromARGB(187, 0, 43, 91),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.all_inbox,
                      color: Color.fromARGB(187, 0, 43, 91),
                    )
                  ],
                ),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
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
      drawer: DrawerBuild(),
      body: Container(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(_showFavorite),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(187, 0, 43, 91),
              Colors.teal,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_circle_outline,
          color: Colors.tealAccent,
        ),
        backgroundColor: Color.fromARGB(187, 0, 43, 91),
        onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName);
        },
        elevation: 8,
      ),
    );
  }
}
