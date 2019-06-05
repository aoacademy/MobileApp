import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_manager/pages/root.dart';
import './pages/home.dart';
import 'package:iot_manager/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iot_manager/globals.dart' as globals;
import 'package:iot_manager/user_login_page.dart';


void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp(
      userModel: UserModel(),
    ));
  });
}

class MyApp extends StatelessWidget {
//  final appTitle = 'مدیریت اینترنت اشیا';
  final UserModel userModel;

  const MyApp({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'مدیریت اینترنت اشیا',
        home: MyHomePage(title: 'مدیریت اینترنت اشیا'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        MaterialApp(
      theme: ThemeData(fontFamily: 'Shabnam', accentColor: Colors.deepPurple),
      home: RootPage() ,
          routes: <String, WidgetBuilder> {
            '/home': (BuildContext context) => new Home(),
          },
    )
        ;
  }




  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0);
    await prefs.setInt('counter', counter);
  }
}
