import 'package:flutter/material.dart';
import 'package:iot_manager/models/user_model.dart';
import 'package:iot_manager/pages/buy_package_with_app_bar.dart';
import 'package:iot_manager/pages/gateway_with_app_bar.dart';
import 'package:iot_manager/pages/profile_with_app_bar.dart';
import 'package:iot_manager/pages/projects.dart';
import 'package:iot_manager/pages/projects_with_app_bar.dart';
import 'package:iot_manager/pages/root.dart';
import 'package:iot_manager/pages/thing_profile.dart';
import 'package:iot_manager/pages/thing_profile_with_app_bar.dart';
import 'package:iot_manager/pages/thing_project_with_app_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'cart.dart';
import 'user_login_page.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;
import 'thing.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:iot_manager/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int index = 0;
  Map<String, dynamic> userData;

  @override
  void initState() {
    var now = new DateTime.now();
    var date = new DateTime.fromMillisecondsSinceEpoch((globals.tokenGetTime));
    var difference = now.difference(date);
    var diff = difference.inSeconds;
    print('globals.tokenGetTime');
    print(globals.tokenGetTime);
    print('difference');
    print(diff.toString());

    if (diff > 7200){
      refreshUser(globals.userToken);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'مدیریت اینترنت اشیا',
            style: new TextStyle(fontSize: 14.0, fontFamily: 'Shabnam'),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 100.0,
                child: DrawerHeader(
                  child: Text(
                    globals.userName,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text(
                  'داشبورد',
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  Navigator.pop(context, false);
                  Navigator.push(
                      context,
                      new PageRouteBuilder(pageBuilder:
                          (BuildContext context, _, __) {
                        return ProfileWithAppBar();
                      }, transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return new FadeTransition(
                            opacity: animation, child: child);
                      }));
                },
              ),
              ListTile(
                title: Text(
                  'پروژه‌ها',
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  Navigator.pop(context, false);
                  Navigator.push(
                      context,
                      new PageRouteBuilder(pageBuilder:
                          (BuildContext context, _, __) {
                        return new ProjectsWithAppBar();
                      }, transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return new FadeTransition(
                            opacity: animation, child: child);
                      }));
                },
              ),
              ListTile(
                title: Text(
                  'اشیا',
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  Navigator.pop(context, false);
                  Navigator.push(
                    context,
                    new PageRouteBuilder(
                      pageBuilder: (BuildContext context, _, __) {
                        return new ThingProjectWithAppBar();
                      },
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return new FadeTransition(
                            opacity: animation, child: child);
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'پروفایل اشیا',
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  Navigator.pop(context, false);
                  Navigator.push(
                      context,
                      new PageRouteBuilder(pageBuilder:
                          (BuildContext context, _, __) {
                        return ThingProfileWithAppBar();
                      }, transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return new FadeTransition(
                            opacity: animation, child: child);
                      }));
                },
              ),
              ListTile(
                title: Text(
                  'گذرگاه‌ها',
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  Navigator.pop(context, false);
                  Navigator.push(
                    context,
                    new PageRouteBuilder(
                      pageBuilder: (BuildContext context, _, __) {
                        return GatewayWithAppBar();
                      },
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return new FadeTransition(
                            opacity: animation, child: child);
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'خرید بسته',
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  Navigator.pop(context, false);
                  Navigator.push(
                    context,
                    new PageRouteBuilder(
                      pageBuilder: (BuildContext context, _, __) {
                        return new BuyPackageWithAppBar();
                      },
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return new FadeTransition(
                            opacity: animation, child: child);
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Text(
                      'خروج',
                      textDirection: TextDirection.rtl,
                    ),
                    IconButton(
                      iconSize: 20.0,
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Color.fromRGBO(
                          100,
                          100,
                          100,
                          1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
//                  Navigator.pop(context, false);
                  logOut().then((_){
                    Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            RootPage(),
                      ),
                    ).then((bool value) {});
                  });

                  print('**************** EXIT **************** ');
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            new Offstage(
              // home
              offstage: index != 0,
              child: new TickerMode(
                enabled: index == 0,
                child: Profile(),
              ),
            ),
            new Offstage(
              //projects
              offstage: index != 1,
              child: new TickerMode(
                enabled: index == 1,
                child: Projects(),
              ),
            ),
            new Offstage(
              //things
              offstage: index != 2,
              child: new TickerMode(
                enabled: index == 2,
                child: Thing(),
              ),
            ),
            new Offstage(
              // cart
              offstage: index != 3,
              child: new TickerMode(
                enabled: index == 3,
                child: Cart(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index, // this will be set when a new tab is tapped
          onTap: (int index) {
            setState(() {
              this.index = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('خانه'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.library_books),
              title: new Text('پروژه'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_input_antenna),
              title: Text('اشیا'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.shopping_cart),
              title: new Text('سبد خرید'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> userNameGetter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = (prefs.getString('userName') ?? 'pppppppppp');
    return name;
  }

  Future<bool> refreshUser(lastToken) async {
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/refresh';
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.putUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer ' + lastToken);

    HttpClientResponse response = await request.close();

    if (response.statusCode == 200) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print('home alaki');
      print(data);
      if (data['code'] == 200) {
        userData = new Map<String, dynamic>.from(data['result']);
        print(userData['user']);
        print(userData['user']['package']);
        print(userData['token']);

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.remove('packageId');
        prefs.setString('packageId', userData['user']['package']['_id']);
        globals.packageId = prefs.getString('packageId');

        prefs.remove('packageName');
        prefs.setString('packageName', userData['user']['package']['name']);
        globals.packageName = prefs.getString('packageName');

        prefs.remove('packageNodeNum');
        prefs.setInt('packageNodeNum', userData['user']['package']['node_num']);
        globals.packageNodeNum = prefs.getInt('packageNodeNum');

        prefs.remove('packageProjectNum');
        prefs.setInt(
            'packageProjectNum', userData['user']['package']['project_num']);
        globals.packageProjectNum = prefs.getInt('packageProjectNum');

        prefs.remove('packageTime');
        prefs.setInt('packageTime', userData['user']['package']['time']);
        globals.packageTime = prefs.getInt('packageTime');

        prefs.remove('packagePrice');
        prefs.setInt('packagePrice', userData['user']['package']['price']);
        globals.packagePrice = prefs.getInt('packagePrice');

        prefs.remove('packageIsActive');
        prefs.setBool(
            'packageIsActive', userData['user']['package']['is_active']);
        globals.packageIsActive = prefs.getBool('packageIsActive');

        prefs.remove('packageStartDate');
        prefs.setString(
            'packageStartDate',
            userData['user']['package']['start_date']['\$date']
            ['\$numberLong']);
        globals.packageStartDate = prefs.getString('packageStartDate');

        prefs.remove('userName');
        globals.userName =
            prefs.setString('userName', userData['user']['name']);
        globals.userName = prefs.getString('userName');

        prefs.remove('userToken');
        prefs.setString('userToken', userData['token']);
        globals.userToken = prefs.getString('userToken');
        print('userToken in USER LOGIN');
        print(globals.userToken);

        prefs.remove('userPicture');
        if (userData['user']['picture'] != null) {
          prefs.setString('userPicture', userData['user']['picture']);
          globals.userPicture = prefs.getString('userPicture');
        }

        var now = new DateTime.now().millisecondsSinceEpoch;
        prefs.setInt('tokenGetTime', now);
        globals.tokenGetTime = prefs.getInt('tokenGetTime');

        globals.isLoggedIn = true;
        setState(() {});
        return true;
      } else if (data['result'] ==
          'Token has expired and can no longer be refreshed') {
        return false;
      }
    } else {
      return false;
    }
  }


  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('packageId');
    globals.packageId = '';

    prefs.remove('packageName');
    globals.packageName = '';

    prefs.remove('packageNodeNum');
    globals.packageNodeNum = '';

    prefs.remove('packageProjectNum');
    globals.packageProjectNum = '';

    prefs.remove('packageTime');
    globals.packageTime = '';

    prefs.remove('packagePrice');
    globals.packagePrice = '';

    prefs.remove('packageIsActive');
    globals.packageIsActive = '';

    prefs.remove('packageStartDate');
    globals.packageStartDate = '';

    prefs.remove('userName');
    globals.userName = '';

    prefs.remove('userToken');
    globals.userToken = '';

    prefs.remove('userPicture');
      globals.userPicture = '';

    prefs.remove('tokenGetTime');
    globals.tokenGetTime = '';

    globals.isLoggedIn = false;
    setState(() {});

  }

}
