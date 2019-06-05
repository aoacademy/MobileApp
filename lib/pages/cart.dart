import 'package:flutter/material.dart';
import 'current_package.dart' as current_package;
import 'buy_package.dart' as buy_package;

void main() {
  runApp(new MaterialApp(
    home: Cart(),
  ));
}

class Cart extends StatefulWidget {
  @override
  CartState createState() => new CartState();
}

class CartState extends State<Cart> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 55.0,
              child: TabBar(
                controller: controller,
                tabs: <Tab>[
                  Tab(text: 'بسته فعلی من'),
                  Tab(text: 'خرید بسته'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: controller, children: <Widget>[
        current_package.CurrentPackage(),
        buy_package.BuyPackage(),
      ]),
    );
  }
}
