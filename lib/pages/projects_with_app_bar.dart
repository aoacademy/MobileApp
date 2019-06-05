import 'package:flutter/material.dart';
import 'projects.dart';

class ProjectsWithAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:
        AppBar(
          title:  Text('پروژه‌ها'),
        ),
        body: Projects(),
      )
    );
  }
}
