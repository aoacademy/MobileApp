import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:iot_manager/models/user_model.dart';
import 'package:iot_manager/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login_failed.dart';
import '../models/app_state.dart';
import '../actions/current_user_actions.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:iot_manager/globals.dart' as globals;

class UserLoginPage extends StatefulWidget {
  @override
  UserLoginPageState createState() => UserLoginPageState();
}

class UserLoginPageState extends State<UserLoginPage> {
  bool loading = false;
  bool loginFailed = false;
  Map<String, dynamic> userData;

//  String userData;
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Directionality(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 15.0),
                        Text(
                          'عضو سامانه هستید؟',
                          style: TextStyle(
                            color: Color.fromRGBO(71, 79, 87, 1.0),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'با استفاده از ایمیل و رمز عبور خود وارد شوید.',
                          style: TextStyle(
                            color: Color.fromRGBO(143, 143, 143, 1.0),
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: <Widget>[
                        Container(
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'ایمیل',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.black,
                              // height: 0.5,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        SizedBox(height: 12.0),
                        Container(
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'رمز عبور',
                            ),
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    ScopedModel<UserModel>(
                      model: UserModel(),
                      child: Column(
                        children: [
                          loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ScopedModelDescendant<UserModel>(
                                  builder: (context, child, model) => Container(
                                        child: RaisedButton(
                                          child: Text('ورود'),
                                          color: Colors.blue,
                                          onPressed: () async {
                                            setState(() {
                                              loading = true;
                                            });
                                            model.changeUser(
                                                'Sarahhhhhhhhhh Vaseei'
//                                                  userData['user']['name']
                                                );
                                            fetchUser().then((_) {
                                              print('BEFORE NAVIGATION');
                                              Navigator.of(this.context)
                                                  .pushReplacementNamed(
                                                      '/home');
//                                              Navigator.push<bool>(
//                                                this.context,
//                                                MaterialPageRoute(
//                                                  builder:
//                                                      (BuildContext context) =>
//                                                          Home(),
//                                                ),
//                                              );
                                              print('AFTER NAVIGATION');
                                            });
                                          },
                                          textColor: Color.fromRGBO(
                                              255, 255, 255, 1.0),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                      ),
                                ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Color.fromRGBO(240, 240, 240, 1.0),
                    ),
                    loginFailed ? LoginFailed() : Container(),
                  ],
                ),
              ),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Column(
                      children: <Widget>[
                        Text(
                          'عضو جدید هستید؟',
                          style: TextStyle(
                            color: Color.fromRGBO(71, 79, 87, 1.0),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'برای پیوستن به سامانه عضو شوید.',
                          style: TextStyle(
                            color: Color.fromRGBO(143, 143, 143, 1.0),
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          child: RaisedButton(
                            child: Text('عضویت'),
                            color: Colors.lightBlueAccent,
                            onPressed: () {},
                            textColor: Color.fromRGBO(255, 255, 255, 1.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    )
                  : Container()
            ],
          ),
        ),
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Future<void> fetchUser() async {
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/login';
    HttpClient httpClient = new HttpClient();
    Map jsonMap = {
      'email': usernameController.text,
      'password': passwordController.text

//      'email': 'parham.alvani@gmail.com',
//      'password': '123123'
    };
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();

    if (response.statusCode == 200) {
      print('2000000000000');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      if (data['code'] == 200) {
        print('if');
        if (mounted) {
          setState(() {
            loading = false;
            loginFailed = false;
          });
        }
        userData = new Map<String, dynamic>.from(data['result']);
//        userData = data['result'];
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
         prefs.setDouble('packageTime', userData['user']['package']['time']);
        globals.packageTime = prefs.getDouble('packageTime');

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
      } else {
        print('else');
        setState(() {
          loading = false;
          loginFailed = true;
        });

        return 'First else';
      }
    } else {
      return 'Failed to load Use';
    }
  }
}
