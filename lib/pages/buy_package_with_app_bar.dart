import 'package:flutter/material.dart';
import 'buy_package.dart';

class BuyPackageWithAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('خرید بسته'),
        ),
        body: BuyPackage(),
      ),
    );
  }
}
