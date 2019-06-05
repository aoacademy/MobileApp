import 'package:flutter/material.dart';
import 'thing_project.dart';

class ThingProjectWithAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('اشیا'),
        ),
        body: ThingProject(),
      ),
    );
  }
}
