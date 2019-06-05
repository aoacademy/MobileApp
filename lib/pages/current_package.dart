import 'package:flutter/material.dart';
import 'package:iot_manager/pages/test.dart';
import 'package:iot_manager/pages/user_login_page.dart';
import 'thing.dart';
import 'project_manage.dart';
import 'project_view.dart';
import 'project_details.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:iot_manager/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:iot_manager/globals.dart' as globals;

class CurrentPackage extends StatefulWidget {
  CurrentPackageState createState() => CurrentPackageState();
}

class CurrentPackageState extends State<CurrentPackage>
    with AutomaticKeepAliveClientMixin<CurrentPackage> {
  @override
  bool get wantKeepAlive => true;

  Map<String, dynamic> fetchedData;

  bool isLoading = false;

  @override
  void initState() {
    print('isActive');
    print(globals.packageIsActive);

    print('globals.packageStartDate');
    print(globals.packageStartDate);

    isLoading = true;
//getCurrentPackage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getCurrentPackage,
        child: Column(
          children: <Widget>[
            !globals.isLoggedIn
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Expanded(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            margin: EdgeInsets.only(top: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0x91C8728591),
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(200, 200, 200, 1.0)),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 5.0),
                                      child: Text(
                                        'بسته فعال من',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      Text(
                                        'نام بسته',
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        'مدت زمان بسته',
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        'روزهای باقیمانده',
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        'تعداد پروژه‌ها',
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        'تعداد اشیا',
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(globals.packageName),
                                          globals.packageIsActive
                                              ? Container(
                                                  color: Colors.green,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.0,
                                                      vertical: 0.5),
                                                  margin: EdgeInsets.only(
                                                      right: 4.0),
                                                  child: Text(
                                                    'فعال',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : Container(
                                                  color: Colors.red,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.0,
                                                      vertical: 0.5),
                                                  margin: EdgeInsets.only(
                                                      right: 4.0),
                                                  child: Text(
                                                    'غیرفعال',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      Text(replaceFarsiNumber(
                                          globals.packageTime.toString())),
                                      Text(replaceFarsiNumber(packageRemainTime(
                                              globals.packageStartDate)
                                          .toString())),
                                      Text(replaceFarsiNumber(globals
                                          .packageProjectNum
                                          .toString())),
                                      Text(replaceFarsiNumber(
                                          globals.packageNodeNum.toString(),
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  String packageRemainTime(String time) {
    var now = new DateTime.now();
    var date = new DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    var difference = now.difference(date);
    var diff = difference.inDays.toString();
    return diff;
  }

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  Future<void> getCurrentPackage() async {
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/user';
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set(
        'Authorization',
        //Sarah
//        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1YzNkZjY4NWRmOWU0ODAwYjI3NWU2ODciLCJpc3MiOiJodHRwOi8vcGxhdGZvcm0uY2VpdC5hdXQuYWMuaXI6NTAwMDgvYXBpL3YxL2xvZ2luIiwiaWF0IjoxNTQ3ODc5OTQyLCJleHAiOjE1NDc5MDE1NDIsIm5iZiI6MTU0Nzg3OTk0MiwianRpIjoiS3Q1WW44T0xPc2VmbUQxdCJ9.12GwNnNX6c0OEjgApd4clK1l5wbaA7Zmevp3N1pI_cs');
        //Parham
        'Bearer ' + globals.userToken);
//    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    print('getProjects');
    print(response.statusCode);
    // TODO if (statusCode == 401) then call refresh endpoint
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if');
        fetchedData = data['result']['user'];
        print(fetchedData);
        setState(() {
          isLoading = false;
        });
      } else {
        print('else');
      }
    } else {}
  }
}
