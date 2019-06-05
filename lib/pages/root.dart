import 'package:flutter/material.dart';
import 'package:iot_manager/globals.dart' as globals;
import 'package:iot_manager/pages/home.dart';
import 'package:iot_manager/pages/user_login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  Widget currentWidget;
  bool connected = false;
  bool isLoggedIn = false;
  Map<String, dynamic> userData;

  @override
  void initState() {
    defaultWidget();
    isLogged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (connected) {
      if (isLoggedIn) {
        print('isLoggedIn ');
        print(isLoggedIn);
//        if (globals.isLoggedIn) {
        return Home();
      } else {
        return UserLoginPage();
      }
    } else {
      return Container(
        color: Colors.black38,
        width: 300.0,
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'اتصال به اینترنت برقرار نیست !',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<bool> defaultWidget() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      print(result[0]);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          connected = true;
          print('connected is set to --->');
          print(connected);
        });
      }
    } on SocketException catch (_) {
      setState(() {
        print('connected is set to FALSE');
        connected = false;
      });
    }
    print('connected is --->');
    print(connected);
  }

  Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString('userToken');
    print('userToken');
    print(userToken);

    globals.packageId = prefs.getString('packageId');

    globals.packageName = prefs.getString('packageName');

    globals.packageNodeNum = prefs.getInt('packageNodeNum');

    globals.packageTime = prefs.getDouble('packageTime');

    globals.packagePrice = prefs.getInt('packagePrice');

    globals.packageIsActive = prefs.getBool('packageIsActive');
    globals.tokenGetTime = prefs.getInt('tokenGetTime');

    globals.packageStartDate = prefs.getString('packageStartDate');
    globals.userName = prefs.getString('userName');

    globals.userToken = userToken;

    if (userToken != null) {
      refreshUser(globals.userToken)
          .then((data) {
        if (data) {
          setState(() {
            print('isLoggedIn is true now');
//            isLoggedIn = true;
          });
        }
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
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
      print('root alaki');
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
}
