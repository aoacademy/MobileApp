//import 'dart:async';
//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
////import 'package:flutter_redux/flutter_redux.dart';
//import 'package:http/http.dart' as http;
////import 'package:redux/redux.dart';
////import 'package:shared_preferences/shared_preferences.dart';
////
////import '../../actions/fetched_user_action.dart';
////import '../../models/app_state.dart';
////import '../../widgets/login_failed.dart';
//
//class UserLoginPage extends StatefulWidget {
//  @override
//  UserLoginPageState createState() => UserLoginPageState();
//}
//
//class UserLoginPageState extends State<UserLoginPage> {
//  bool loading = false;
//  bool loginFailed = false;
//  final usernameController = new TextEditingController();
//  final passwordController = new TextEditingController();
//
//  @override
//  void dispose() {
//    usernameController.dispose();
//    passwordController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//    return Directionality(
//      child: Scaffold(
//        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
//        body: SafeArea(
//          child: Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  CloseButton(),
//                ],
//                mainAxisAlignment: MainAxisAlignment.end,
//              ),
//              Expanded(
//                child: ListView(
//                  children: <Widget>[
//                    Column(
//                      children: <Widget>[
//                        Image.asset(
//                          'images/logo_1.png',
//                          height: 64.0,
//                        ),
//                        SizedBox(height: 15.0),
//                        Text(
//                          'عضو طرفداری هستید؟',
//                          style: TextStyle(
//                            color: Color.fromRGBO(71, 79, 87, 1.0),
//                          ),
//                          textAlign: TextAlign.center,
//                        ),
//                        Text(
//                          'با استفاده از نام کاربری و رمز عبور خود وارد شوید.',
//                          style: TextStyle(
//                            color: Color.fromRGBO(143, 143, 143, 1.0),
//                            fontSize: 12.0,
//                          ),
//                          textAlign: TextAlign.center,
//                        ),
//                      ],
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                    ),
//                    SizedBox(height: 20.0),
//                    Column(
//                      children: <Widget>[
//                        Container(
//                          child: TextField(
//                            controller: usernameController,
//                            decoration: InputDecoration(
//                              fillColor: Colors.white,
//                              filled: true,
//                              labelText: 'ایمیل یا موبایل',
//                            ),
//                            keyboardType: TextInputType.emailAddress,
//                            style: TextStyle(
//                              color: Colors.black,
//                              // height: 0.5,
//                            ),
//                          ),
//                          padding: EdgeInsets.symmetric(horizontal: 10.0),
//                        ),
//                        SizedBox(height: 12.0),
//                        Container(
//                          child: TextField(
//                            controller: passwordController,
//                            decoration: InputDecoration(
//                              fillColor: Colors.white,
//                              filled: true,
//                              labelText: 'رمز عبور',
//                            ),
//                            obscureText: true,
//                            style: TextStyle(
//                              color: Colors.black,
//                              // height: 0.5,
//                            ),
//                          ),
//                          padding: EdgeInsets.symmetric(horizontal: 10.0),
//                        ),
//                      ],
//                    ),
//                    SizedBox(height: 12.0),
//                    loading
//                        ? Center(
//                            child: CircularProgressIndicator(),
//                          )
//                        : Container(
//                            child: RaisedButton(
//                              child: Text('ورود'),
//                              color: Color.fromRGBO(255, 155, 0, 1.0),
//                              onPressed: () {
//                                setState(() {
//                                  loading = true;
//                                });
//                                fetchUser();
//                              },
//                              textColor: Color.fromRGBO(255, 255, 255, 1.0),
//                            ),
//                            padding: EdgeInsets.symmetric(horizontal: 10.0),
//                          ),
//                    Divider(
//                      color: Color.fromRGBO(240, 240, 240, 1.0),
//                    ),
//                    loginFailed ? LoginFailed() : Container(),
//                    Container(
//                      child: FlatButton(
//                        child: Text('رمز عبور خود را فراموش کرده‌اید؟'),
//                        onPressed: () {},
//                      ),
//                      padding: EdgeInsets.symmetric(horizontal: 10.0),
//                    ),
//                  ],
//                ),
//              ),
//              MediaQuery.of(context).viewInsets.bottom == 0
//                  ? Column(
//                      children: <Widget>[
//                        Text(
//                          'عضو جدید هستید؟',
//                          style: TextStyle(
//                            color: Color.fromRGBO(71, 79, 87, 1.0),
//                          ),
//                          textAlign: TextAlign.center,
//                        ),
//                        Text(
//                          'برای پیوستن به طرفداری عضو شوید.',
//                          style: TextStyle(
//                            color: Color.fromRGBO(143, 143, 143, 1.0),
//                            fontSize: 12.0,
//                          ),
//                          textAlign: TextAlign.center,
//                        ),
//                        Container(
//                          child: RaisedButton(
//                            child: Text('عضویت در طرفداری'),
//                            color: Color.fromRGBO(0, 0, 0, 1.0),
//                            onPressed: () {},
//                            textColor: Color.fromRGBO(255, 255, 255, 1.0),
//                          ),
//                          padding: EdgeInsets.symmetric(horizontal: 10.0),
//                        ),
//                      ],
//                      mainAxisAlignment: MainAxisAlignment.end,
//                    )
//                  : Container()
//            ],
//          ),
//        ),
//      ),
//      textDirection: TextDirection.rtl,
//    );
//  }
//
//  Future<void> fetchUser() async {
//    Store<AppState> store = StoreProvider.of<AppState>(context);
//    final prefs = await SharedPreferences.getInstance();
//    String getUrl =
//        'https://www.tarafdari.com/api/user/auth/?api_key=public&username=' +
//            usernameController.text +
//            '&password=' +
//            passwordController.text;
//    final response = await http.get(getUrl);
//    if (response.statusCode == 200) {
//      final Map<String, dynamic> meta = json.decode(response.body)['meta'];
//      if (meta['error_key'] == null) {
//        store.dispatch(new SetFetchedUser(
//          fetchedUser: json.decode(response.body),
//        ));
//        prefs.setString('fetchedUser', response.body);
//        setState(() {
//          loading = false;
//          loginFailed = false;
//        });
//        Navigator.pop(context, 'login_successful');
//      } else {
//        setState(() {
//          loading = false;
//          loginFailed = true;
//        });
//      }
//    } else {
//      throw Exception('Failed to load User');
//    }
//  }
//}
