import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to remove this item from the cart?"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "No!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).errorColor),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      "Yes!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(
          productId,
        );
      },
      key: ValueKey(id),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Theme.of(context).errorColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            Text(
              "Delete",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryTextTheme.headline6.color,
              ),
            )
          ],
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 8),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
      ),
      child: Card(
        color: Color.fromARGB(255, 207, 235, 225),
        elevation: 2,
        margin: EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.zero,
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Color.fromARGB(187, 0, 43, 91),
              foregroundColor:
                  Theme.of(context).primaryTextTheme.headline6.color,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: FittedBox(
                  child: Text("\$$price"),
                ),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text("Price: \$${(price * quantity)}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
