import 'package:flutter/material.dart';
import 'thing_profile.dart' as thing_profile;
import 'thing_project.dart' as thing_project;
import 'gateway.dart' as gateway;

void main() {
  runApp(new MaterialApp(
    home: Thing(),
  ));
}

class Thing extends StatefulWidget {
  @override
  ThingState createState() => new ThingState();
}

class ThingState extends State<Thing> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
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
                  Tab(text: 'پروفایل اشیا'),
                  Tab(text: 'اشیا'),
                  Tab(text: 'گذرگاه‌ها'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: controller, children: <Widget>[
         thing_profile.ThingProfile(),
         thing_project.ThingProject(),
         gateway.Gateway()
      ]),
    );
  }
}
