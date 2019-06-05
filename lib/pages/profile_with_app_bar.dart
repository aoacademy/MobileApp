import 'package:flutter/material.dart';
import 'profile.dart';

class ProfileWithAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('داشبورد'),
        ),
        body: Profile(),
      ),
    );
  }
}
