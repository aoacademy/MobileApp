import 'package:flutter/material.dart';
import 'thing_profile.dart';

class ThingProfileWithAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('پروفایل اشیا'),
        ),
        body: ThingProfile(),
      ),
    );
  }
}
