import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;
import 'dart:math';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              tileColor: Color.fromARGB(255, 225, 234, 231),
              title: Text(
                "\$${widget.order.amount}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(187, 0, 43, 91),
                ),
              ),
              subtitle: Text(
                DateFormat("dd/MM/yyyy hh:mm").format(widget.order.dateTime),
              ),
              trailing: IconButton(
                color: Color.fromARGB(187, 0, 43, 91),
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
          ),
          if (_expanded)
            Container(
              color: Color.fromARGB(255, 207, 235, 225),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              height: min(widget.order.products.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            prod.title,
                            style: TextStyle(
                              color: Color.fromARGB(187, 0, 43, 91),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${prod.quantity}x \$${prod.price}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(187, 0, 43, 91),
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
