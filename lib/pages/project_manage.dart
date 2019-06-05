import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:iot_manager/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:iot_manager/globals.dart' as globals;

void main() {
  String name;
  String description;
  bool isActive;
  String id;
  runApp(new MaterialApp(
    home: ProjectManage(name, description, isActive, id),
  ));
}

class ProjectManage extends StatefulWidget {
  final String name;
  final String description;
  final bool isActive;
  final String id;

  const ProjectManage(this.name, this.description, this.isActive, this.id);

  ProjectManageState createState() => new ProjectManageState();
}

class ProjectManageState extends State<ProjectManage> {
  final String nameHint = 'Name';
  final detailsHint = 'Details';
  final projectNameController = new TextEditingController();
  final projectDescriptionController = new TextEditingController();

  List fetchedData;

  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      projectNameController.text = widget.name;
      projectDescriptionController.text = widget.description;
    });
//    getThingProjects();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    projectNameController.dispose();
    projectDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("مدیریت پروژه"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child:
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Text(
                                  'تغییر اطلاعات پروژه',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10.0, right: 5.0),
                              child: Text(
                                'نام پروژه:',
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 2.0, left: 5.0),
                              width: 310.0,
                              child: TextField(
                                controller: projectNameController,
                                decoration: InputDecoration(
//                                                  fillColor: Colors.yellow,
                                  filled: true,
                                  hintText: nameHint,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10.0, right: 5.0),
                              child: Text(
                                'توضیحات:',
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 2.0, left: 5.0),
                              width: 310.0,
                              child: TextField(
                                maxLines: 3,
                                controller: projectDescriptionController,
                                decoration: InputDecoration(
//                                                  fillColor: Colors.yellow,
                                  filled: true,
                                  hintText: detailsHint,
                                ),
//                                style: TextStyle(                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10.0, right: 5.0),
                              child: Text(
                                'وضعیت:',
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            widget.isActive
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 2.0),
                                    margin: EdgeInsets.only(left: 10.0),
                                    decoration:
                                        BoxDecoration(color: Colors.green),
                                    child: Text(
                                      'فعال',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 2.0),
                                    margin: EdgeInsets.only(left: 10.0),
                                    decoration:
                                        BoxDecoration(color: Colors.red),
                                    child: Text(
                                      'غیرفعال',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
                          child: RaisedButton(
                            color: Colors.blue,
                            splashColor: Colors.blueGrey,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'ثبت اطلاعات',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () async {
                              updateProject().then((data) {
                                Navigator.pop(context, true);
                              });
                            },
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
                          child: RaisedButton(
                            color: Colors.yellow,
                            splashColor: Colors.yellowAccent,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'غیرفعال‌سازی پروژه',
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
//                    Directionality(
//                      textDirection: TextDirection.rtl,
//                      child: Column(
//                        children: <Widget>[
////                          Row(children: <Widget>[
////
////                          ],),
////                          Container(
////                            padding: EdgeInsets.symmetric(
////                                vertical: 10.0, horizontal: 5.0),
////                            margin: EdgeInsets.only(top: 15.0),
////                            decoration: BoxDecoration(
////                              color: Color(0x91C8728591),
////                              border: Border(
////                                bottom: BorderSide(
////                                    width: 1.0,
////                                    color: Color.fromRGBO(200, 200, 200, 1.0)),
////                              ),
////                            ),
////                            child: Row(
////                              textDirection: TextDirection.rtl,
////                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                              children: <Widget>[
////                                Row(
////                                  mainAxisAlignment: MainAxisAlignment.start,
////                                  children: <Widget>[
////                                    Container(
////                                      padding: EdgeInsets.only(right: 5.0),
////                                      child: Text(
////                                        'اشیا متصل شده به پروژه',
////                                        style: TextStyle(color: Colors.white),
////                                      ),
////                                    ),
////                                  ],
////                                ),
////                              ],
////                            ),
////                          ),
//                          isLoading
//                              ? Container()
//                              : fetchedData.length > 0
//                                  ? Container(
//                                      padding: EdgeInsets.symmetric(
//                                          vertical: 10.0, horizontal: 5.0),
//                                      margin: EdgeInsets.only(top: 15.0),
//                                      decoration: BoxDecoration(
//                                        color: Color(0x91C8728591),
//                                        border: Border(
//                                          bottom: BorderSide(
//                                            width: 1.0,
//                                            color: Color.fromRGBO(
//                                                200, 200, 200, 1.0),
//                                          ),
//                                        ),
//                                      ),
//                                      child: Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceBetween,
//                                        children: <Widget>[
//                                          Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.start,
//                                            children: <Widget>[
//                                              Container(
//                                                padding:
//                                                    EdgeInsets.only(right: 5.0),
//                                                child: Text(
//                                                  'نام شی',
//                                                  style: TextStyle(
//                                                      color: Colors.white),
//                                                ),
//                                              ),
//                                            ],
//                                          ),
////                                          Row(
////                                            mainAxisAlignment:
////                                                MainAxisAlignment.start,
////                                            children: <Widget>[
////                                              Container(
////                                                padding: EdgeInsets.only(
////                                                    right: 40.0),
////                                                child: Text(
////                                                  'پروژه',
////                                                  style: TextStyle(
////                                                      color: Colors.white),
////                                                ),
////                                              ),
////                                            ],
////                                          ),
//                                          Row(
////                          mainAxisAlignment: MainAxisAlignment.end,
//                                            children: <Widget>[
//                                              Container(
//                                                padding: EdgeInsets.only(
//                                                    right: 10.0),
//                                                child: Text(
//                                                  'نوع',
//                                                  style: TextStyle(
//                                                      color: Colors.white),
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                          Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.end,
//                                            children: <Widget>[
//                                              Container(
//                                                child: Text(
//                                                  'اطلاعات',
//                                                  style: TextStyle(
//                                                      color: Colors.white),
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        ],
//                                      ),
//                                    )
//                                  : Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.center,
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.center,
//                                      children: <Widget>[
//                                        Container(
//                                          padding: EdgeInsets.all(20.0),
//                                          child: Text('لیست اشیا خالی است.'),
//                                        ),
//                                      ],
//                                    ),
//                          isLoading
//                              ? Center(
//                                  child: CircularProgressIndicator(),
//                                )
//                              : Flexible(
//                                  child: ListView.builder(
//                                    itemCount: fetchedData == null
//                                        ? 0
//                                        : fetchedData.length,
//                                    itemBuilder: (BuildContext context, i) {
//                                      return Stack(
//                                        children: <Widget>[
//                                          Container(
//                                            padding: EdgeInsets.symmetric(
//                                                horizontal: 5.0),
//                                            decoration: BoxDecoration(
//                                              border: Border(
//                                                bottom: BorderSide(
//                                                    width: 1.0,
//                                                    color: Color.fromRGBO(
//                                                        200, 200, 200, 1.0,
//                                                    ),
//                                                ),
//                                              ),
//                                            ),
//                                            child: Row(
//                                              mainAxisAlignment:
//                                                  MainAxisAlignment
//                                                      .spaceBetween,
//                                              children: <Widget>[
//                                                Row(
//                                                  mainAxisAlignment:
//                                                      MainAxisAlignment.start,
//                                                  children: <Widget>[
//                                                    Container(
//                                                      width: 80.0,
//                                                      child: Text(
//                                                        fetchedData[i]['name'],
//                                                        style: TextStyle(
//                                                          color: Color.fromRGBO(
//                                                              100,
//                                                              100,
//                                                              100,
//                                                              1.0),
//                                                        ),
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
////                                                Row(
//////                          mainAxisAlignment: MainAxisAlignment.center,
////                                                  children: <Widget>[
////                                                    Container(
////                                                      padding:
////                                                          EdgeInsets.symmetric(
////                                                              horizontal: 2.0,
////                                                              vertical: 2.0),
////                                                      decoration: BoxDecoration(
////                                                          color: Colors.white),
////                                                      child: Text(
////                                                        fetchedData[i]
////                                                            ['project']['name'],
////                                                        style: TextStyle(
////                                                          color: Color.fromRGBO(
////                                                              100,
////                                                              100,
////                                                              100,
////                                                              1.0),
////                                                        ),
////                                                      ),
////                                                    ),
////                                                  ],
////                                                ),
//                                                Row(
//                                                  mainAxisAlignment:
//                                                      MainAxisAlignment.center,
//                                                  children: <Widget>[
//                                                    Container(
//                                                      padding:
//                                                          EdgeInsets.symmetric(
//                                                              horizontal: 2.0,
//                                                              vertical: 2.0),
//                                                      child: Text(
//                                                        fetchedData[i]
//                                                            ['activation'],
//                                                        style: TextStyle(
//                                                          color: Color.fromRGBO(
//                                                              100,
//                                                              100,
//                                                              100,
//                                                              1.0),
//                                                        ),
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                                Row(
//                                                  mainAxisAlignment:
//                                                      MainAxisAlignment.end,
//                                                  children: <Widget>[
//                                                    Container(
//                                                      child: IconButton(
//                                                        iconSize: 20.0,
//                                                        icon: Icon(
//                                                          Icons.info,
//                                                          color: Color.fromRGBO(
//                                                              100,
//                                                              100,
//                                                              100,
//                                                              1.0,
//                                                          ),
//                                                        ),
//                                                        onPressed: () {
//                                                          showDialog(
//                                                            context: context,
//                                                            child: AlertDialog(
//                                                              content:
//                                                                  Container(
//                                                                height: 250.0,
//                                                                child: Column(
//                                                                  children: <
//                                                                      Widget>[
//                                                                    Container(
//                                                                      padding: EdgeInsets.symmetric(
//                                                                          vertical:
//                                                                              10.0,
//                                                                          horizontal:
//                                                                              3.0),
//                                                                      decoration:
//                                                                          BoxDecoration(
//                                                                        border:
//                                                                            Border(
//                                                                          bottom:
//                                                                              BorderSide(
//                                                                            width:
//                                                                                1.0,
//                                                                            color: Color.fromRGBO(
//                                                                                200,
//                                                                                200,
//                                                                                200,
//                                                                                1.0),
//                                                                          ),
//                                                                        ),
//                                                                      ),
//                                                                      child:
//                                                                          Column(
//                                                                        children: <
//                                                                            Widget>[
//                                                                          Row(
//                                                                            textDirection:
//                                                                                TextDirection.rtl,
//                                                                            mainAxisAlignment:
//                                                                                MainAxisAlignment.start,
//                                                                            children: <Widget>[
//                                                                              Text(
//                                                                                'آدرس',
//                                                                                textAlign: TextAlign.right,
//                                                                                style: TextStyle(
//                                                                                  fontFamily: 'Shabnam',
//                                                                                ),
//                                                                              ),
//                                                                            ],
//                                                                          ),
//                                                                          Row(
//                                                                            textDirection:
//                                                                                TextDirection.rtl,
//                                                                            mainAxisAlignment:
//                                                                                MainAxisAlignment.end,
//                                                                            children: <Widget>[
//                                                                              Text(
//                                                                                fetchedData[i]['dev_eui'],
//                                                                                textAlign: TextAlign.right,
//                                                                                style: TextStyle(
//                                                                                  fontFamily: 'Shabnam',
//                                                                                ),
//                                                                              ),
//                                                                            ],
//                                                                          ),
//                                                                        ],
//                                                                      ),
//                                                                    ),
//                                                                    fetchedData[i]['last_parsed_at'] !=
//                                                                            0
//                                                                        ? Container(
//                                                                            padding:
//                                                                                EdgeInsets.symmetric(
//                                                                              vertical: 10.0,
//                                                                              horizontal: 3.0,
//                                                                            ),
//                                                                            decoration:
//                                                                                BoxDecoration(
//                                                                              border: Border(
//                                                                                bottom: BorderSide(
//                                                                                  width: 1.0,
//                                                                                  color: Color.fromRGBO(
//                                                                                    200,
//                                                                                    200,
//                                                                                    200,
//                                                                                    1.0,
//                                                                                  ),
//                                                                                ),
//                                                                              ),
//                                                                            ),
//                                                                            child:
//                                                                                Column(
//                                                                              children: <Widget>[
//                                                                                Row(
//                                                                                  textDirection: TextDirection.rtl,
//                                                                                  mainAxisAlignment: MainAxisAlignment.start,
//                                                                                  children: <Widget>[
//                                                                                    Text(
//                                                                                      'آخرین زمان پارس داده',
//                                                                                      textAlign: TextAlign.right,
//                                                                                      style: TextStyle(
//                                                                                        fontFamily: 'Shabnam',
//                                                                                      ),
//                                                                                    ),
//                                                                                  ],
//                                                                                ),
//                                                                                Container(
//                                                                                  margin: EdgeInsets.only(top: 5.0),
//                                                                                  child: Row(
//                                                                                    textDirection: TextDirection.rtl,
//                                                                                    mainAxisAlignment: MainAxisAlignment.end,
//                                                                                    children: <Widget>[
//                                                                                      Text(
//                                                                                        replaceFarsiNumber(dateConvertor(fetchedData[i]['last_parsed_at'])) + ' - ' + replaceFarsiNumber(timePicker(fetchedData[i]['last_parsed_at'])),
//                                                                                        textAlign: TextAlign.right,
//                                                                                        style: TextStyle(
//                                                                                          fontFamily: 'Shabnam',
//                                                                                        ),
//                                                                                      ),
//                                                                                    ],
//                                                                                  ),
//                                                                                ),
//                                                                              ],
//                                                                            ),
//                                                                          )
//                                                                        : Container(),
//                                                                    Container(
//                                                                      padding:
//                                                                          EdgeInsets
//                                                                              .symmetric(
//                                                                        vertical:
//                                                                            10.0,
//                                                                        horizontal:
//                                                                            3.0,
//                                                                      ),
//                                                                      decoration:
//                                                                          BoxDecoration(
//                                                                        border:
//                                                                            Border(
//                                                                          bottom:
//                                                                              BorderSide(
//                                                                            width:
//                                                                                1.0,
//                                                                            color: Color.fromRGBO(
//                                                                                200,
//                                                                                200,
//                                                                                200,
//                                                                                1.0),
//                                                                          ),
//                                                                        ),
//                                                                      ),
//                                                                      child:
//                                                                          Column(
//                                                                        children: <
//                                                                            Widget>[
//                                                                          Row(
//                                                                            textDirection:
//                                                                                TextDirection.rtl,
//                                                                            mainAxisAlignment:
//                                                                                MainAxisAlignment.start,
//                                                                            children: <Widget>[
//                                                                              Text(
//                                                                                'وضعیت',
//                                                                                style: TextStyle(
//                                                                                  fontFamily: 'Shabnam',
//                                                                                ),
//                                                                                textAlign: TextAlign.right,
//                                                                              ),
//                                                                            ],
//                                                                          ),
//                                                                          Row(
//                                                                            textDirection:
//                                                                                TextDirection.rtl,
//                                                                            mainAxisAlignment:
//                                                                                MainAxisAlignment.end,
//                                                                            children: <Widget>[
//                                                                              Container(
//                                                                                margin: EdgeInsets.symmetric(vertical: 1.0),
//                                                                                padding: EdgeInsets.symmetric(horizontal: 3.0),
//                                                                                decoration: BoxDecoration(color: Colors.green),
//                                                                                child: Text(
//                                                                                  'فعال',
//                                                                                  style: TextStyle(
//                                                                                    fontFamily: 'Shabnam',
//                                                                                    color: Colors.white,
//                                                                                  ),
//                                                                                  textAlign: TextAlign.right,
//                                                                                ),
//                                                                              ),
//                                                                            ],
//                                                                          ),
//                                                                          fetchedData[i]['last_parsed_at'] == 0
//                                                                              ? Row(
//                                                                                  textDirection: TextDirection.rtl,
//                                                                                  mainAxisAlignment: MainAxisAlignment.end,
//                                                                                  children: <Widget>[
//                                                                                    Container(
//                                                                                      margin: EdgeInsets.symmetric(vertical: 1.0),
//                                                                                      padding: EdgeInsets.symmetric(horizontal: 3.0),
//                                                                                      color: Colors.grey,
//                                                                                      child: Text(
//                                                                                        'عدم پارس داده',
//                                                                                        textAlign: TextAlign.right,
//                                                                                        style: TextStyle(color: Colors.white, fontFamily: 'Shabnam'),
//                                                                                      ),
//                                                                                    ),
//                                                                                  ],
//                                                                                )
//                                                                              : Container(),
//                                                                        ],
//                                                                      ),
//                                                                    ),
//                                                                  ],
//                                                                ),
//                                                              ),
//                                                            ),
//                                                          );
//                                                        },
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                              ],
//                                            ),
//                                          ),
//                                        ],
//                                      );
//                                    },
//                                  ),
//                                ),
//                        ],
//                      ),
//                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateProject() async {
    String getUrl =
        'http://platform.ceit.aut.ac.ir:50008/api/v1/project/' + widget.id;
    HttpClient httpClient = new HttpClient();
    Map jsonMap = {
      'name': projectNameController.text,
      'description': projectDescriptionController.text
    };
    HttpClientRequest request = await httpClient.patchUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set(
        'Authorization',
        'Bearer ' + globals.userToken);
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    print('PROJECT_MANAGE updateProject');
    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if');
//        fetchedData = data['result']['projects'];
        setState(() {
//          isLoading = false;
        });
      } else {
        print('else');
      }
    } else {}
  }

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  String dateConvertor(String apiDate) {
    print('apiDate');
    print(apiDate);
    List array = apiDate.split('.');
    List dateTime = array[0].split('T');
    List date = dateTime[0].split('-');
    String jalal =
        Gregorian(int.parse(date[0]), int.parse(date[1]), int.parse(date[2]))
            .toJalali()
            .toString();
    return jalal;
  }

  String timePicker(String apiTime) {
    print('apiTime');
    print(apiTime);
    List array = apiTime.split('.');
    List dateTime = array[0].split('T');
    return dateTime[1];
  }

  Future<void> getThingProjects() async {
    isLoading = true;
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/things';
    HttpClient httpClient = new HttpClient();
//    Map jsonMap = {
//      'name': projectNameController.text,
//      'description': projectDetailsController.text
//    };
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer ' + globals.userToken);
//    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    print('getThingProjects in manager');
    print(response.statusCode);
    // TODO if (statusCode == 401) then call refresh endpoint
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if');
        fetchedData = data['result']['things'];
        print(fetchedData);
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('else');
      }
    } else {}
  }
}
