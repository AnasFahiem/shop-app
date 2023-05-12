import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../screens/products_overview_screen.dart';

class Splash_Screeen extends StatefulWidget {
  const Splash_Screeen({Key key}) : super(key: key);

  @override
  State<Splash_Screeen> createState() => _Splash_ScreeenState();
}

class _Splash_ScreeenState extends State<Splash_Screeen> {
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.of(context)
          .pushReplacementNamed(ProductsOverviewScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(187, 0, 43, 91), Colors.teal],
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("images/2.png"),
              width: 250,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "SHOPP APP",
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.titleLarge.color,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SpinKitWave(
              color: Colors.tealAccent,
              size: 60,
            )
          ],
        ),
      ),
    );
  }
}
