import 'package:flutter/material.dart';
import 'gateway.dart';

class GatewayWithAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('گذرگاه‌ها'),
        ),
        body: Gateway(),
      ),
    );
  }
}
