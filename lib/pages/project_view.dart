import 'package:flutter/material.dart';
import 'package:iot_manager/pages/received_data.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:shamsi_date/shamsi_date.dart';
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

void main() {
  String data;
  runApp(new MaterialApp(
    home: ProjectView(data),
  ));
}

class ProjectView extends StatefulWidget {
  final String data;

  const ProjectView(this.data);

  ProjectViewState createState() => new ProjectViewState();
}


class ProjectViewState extends State<ProjectView> {
  var buttonValue;
  List fetchedData ;
  bool isLoading = false;
  bool isActive = false;
  Map<String, dynamic> passingData;
  List f;
  bool thingsDataIsLoading = false;


  @override
  void initState() {
    print('ProjectViewState-----> ');
    print(globals.userName);
    this.getThings();
//    this.getThingsData();

  }
  final TextEditingController textFromEditingController =
      TextEditingController(text: '1397/10/30');
  final TextEditingController textToEditingController =
      TextEditingController(text: '1397/10/30');
  final TextEditingController rangeTextEditingController =
      TextEditingController(text: '--------------');
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("نمایش پروژه"),
//"${widget.data}"
        ),
        body: Column(
          children: <Widget>[
//            Container(
//              child: Expanded(
//                child: ListView(
//                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      margin: EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                        color: Color(0x91C8728591),
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(200, 200, 200, 1.0),
                          ),
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
                                  'دریافت داده',
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
                              margin: EdgeInsets.only(top: 8.0, right: 5.0),
                              child: Text(
                                'شی ارسال‌کننده:',
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('انتخاب کنید'),
                                value: buttonValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    buttonValue = newValue;
                                  });
                                  print(buttonValue);
                                  if (buttonValue == 'نمایش') {
                                  } else if (buttonValue == 'مدیریت') {
                                  } else if (buttonValue == 'حذف') {}
                                },
                                items: <String>[
                                  'شی دانشکده کامپیوتر',
                                  'شی دانشکده هوافضا',
                                  'شی دانشکده عمران'
                                ].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child:
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                         Text(
                                          value,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  100, 100, 100, 1.0,
                                              ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                ).toList(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Shabnam',
                                  decorationColor: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
//                        Row(
//                          textDirection: TextDirection.rtl,
//                          children: <Widget>[
//                            Container(
//                              margin: EdgeInsets.only(top: 10.0, right: 5.0),
//                              child: Text(
//                                'زمان داده:',
//                                textDirection: TextDirection.rtl,
//                              ),
//                            ),
//                          ],
//                        ),

//                        Row(
//                          textDirection: TextDirection.ltr,
//                          children: <Widget>[
//                            DropdownButtonHideUnderline(
//                              child: DropdownButton<String>(
//                                hint: Text('انتخاب کنید'),
//                                value: buttonValue,
//                                onChanged: (newValue) {
//                                  buttonValue = newValue;
//                                  print(buttonValue);
////                                  if (buttonValue == 'یک ساعت اخیر') {
////                                  } else if (buttonValue == 'پنج ساعت اخیر') {
////                                  } else if (buttonValue == 'ده ساعت اخیر') {
////                                  } else if (buttonValue == 'یک روز اخیر') {
////                                  } else if (buttonValue == 'یک هفته اخیر') {}
//                                },
//                                items: <String>['یک ساعت اخیر', 'پنج ساعت اخیر', 'ده ساعت اخیر', 'یک روز اخیر', 'یک هفته اخیر']
//                                    .map((String value) {
//                                  return new DropdownMenuItem<String>(
//                                    value: value,
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.center,
//                                      children: <Widget>[
//                                        new Text(
//                                          value,
//                                          style: TextStyle(
//                                              color: Color.fromRGBO(
//                                                  100, 100, 100, 1.0)),
//                                        )
//                                      ],
//                                    ),
//                                  );
//                                }).toList(),
//                                style: TextStyle(
//                                  color: Colors.black,
//                                  fontFamily: 'Shabnam',
//                                  decorationColor: Colors.blue,
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 0.0, right: 5.0),
                              child: Text(
                                ' انتخاب زمان شروع:',
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return PersianDatePicker(
                                        controller: textFromEditingController,
                                      );
                                    });
                                print(textFromEditingController);
                              },
                              child: Container(
                                width: 100.0,
                                child: TextField(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PersianDatePicker(
                                            controller:
                                                textFromEditingController,
                                          );
                                        });
                                  },
                                  controller: textFromEditingController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 0.0, right: 5.0),
                              child: Text(
                                ' انتخاب زمان پایان:',
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return PersianDatePicker(
                                        controller: textToEditingController,
                                      );
                                    });
                                print(textToEditingController);
                              },
                              child: Container(
                                width: 100.0,
                                child: TextField(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PersianDatePicker(
                                            controller: textToEditingController,
                                          );
                                        });
                                  },
                                  controller: textToEditingController,
                                ),
                              ),
                            ),
                          ],
                        ),

// TODO CHART

//                        Row(
//                          children: <Widget>[
//                            Container(
//                              margin: EdgeInsets.only(top: 10.0, right: 5.0),
//                              child: Text(
//                                'نوع نمودار:',
//                                textDirection: TextDirection.rtl,
//                              ),
//                            ),
//                          ],
//                        ),
//                        Row(
//                          textDirection: TextDirection.ltr,
//                          children: <Widget>[
//                            DropdownButtonHideUnderline(
//                              child: DropdownButton<String>(
//                                hint: Text('انتخاب کنید'),
//                                value: buttonValue,
//                                onChanged: (newValue) {
//                                  buttonValue = newValue;
//                                  print(buttonValue);
//                                  if (buttonValue == 'خطی') {
//                                  } else if (buttonValue == 'میله‌ای') {}
//                                },
//                                items: <String>['خطی', 'میله‌ای']
//                                    .map((String value) {
//                                  return new DropdownMenuItem<String>(
//                                    value: value,
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.center,
//                                      children: <Widget>[
//                                        new Text(
//                                          value,
//                                          style: TextStyle(
//                                              color: Color.fromRGBO(
//                                                  100, 100, 100, 1.0)),
//                                        )
//                                      ],
//                                    ),
//                                  );
//                                }).toList(),
//                                style: TextStyle(
//                                  color: Colors.black,
//                                  fontFamily: 'Shabnam',
//                                  decorationColor: Colors.blue,
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
                        Row(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0 , vertical: 5.0),
                              child: RaisedButton(
                                color: Colors.green,
                                splashColor: Colors.greenAccent,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        ' دریافت اطلاعات',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  print(textFromEditingController.text);
                                  getThingsData();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
//                  ],
//                ),
//              ),
//            ),



            Column(
              children: <Widget>[
                thingsDataIsLoading
                    ? Container()
                    :  f==null ? Container() : f.length > 0
                    ? Container(
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
                      Container(
                        padding: EdgeInsets.only(
                            right: 7.0, top: 10.0, bottom: 10.0),
                        child: Text(
                          "شناسه فرستنده",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: 15.0, top: 10.0, bottom: 10.0),
                        child: Text(
                          "زمان دریافت داده",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 7.0, top: 10.0, bottom: 10.0),
                        child: Text(
                          "داده دریافت شده",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
                    : Text(' '),
              ],
            ),
            thingsDataIsLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : f ==null ? Container() : f.length > 0
                ? Expanded(
              child: ListView.builder(
                  itemCount: f == null ? 0 : f.length,
                  itemBuilder: (BuildContext context, i) {
                    return Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 105.0,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 3.0),
                                  child: Text(f[i]['_id']),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 3.0),
                                  child: Text(
                                    replaceFarsiNumber(dateConvertor(
                                        f[i]['timestamp'])) +
                                        ' - ' +
                                        replaceFarsiNumber(timePicker(
                                            f[i]['timestamp'])),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'Shabnam',
                                    ),
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: ButtonTheme(
                                    minWidth: 50.0,
                                    height: 35.0,
                                    child: RaisedButton(
                                      child: Text(
                                        'مشاهده',
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                      color: Colors.blue,
                                      elevation: 4.0,
                                      splashColor: Colors.cyan,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          child: new AlertDialog(
                                            title: new Text(
                                              "داده ",
                                              textAlign:
                                              TextAlign.right,
                                              style: TextStyle(
                                                  fontFamily: 'Shabnam',
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            content: Text(
                                                dataExtractor(f[i]['data'])
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            )
                : Text(' داده‌ای موجود نیست'),
          ],
        ),
      ),
    );
  }

  Future<void> getThings() async{
    setState(() {
      isLoading = true;
    });
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/project/' + widget.data + '/things';
    HttpClient httpClient = new HttpClient();

    HttpClientRequest request = await httpClient.getUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set(
        'Authorization',
        //Sarah
//        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1YzNkZjY4NWRmOWU0ODAwYjI3NWU2ODciLCJpc3MiOiJodHRwOi8vcGxhdGZvcm0uY2VpdC5hdXQuYWMuaXI6NTAwMDgvYXBpL3YxL2xvZ2luIiwiaWF0IjoxNTQ3ODc5OTQyLCJleHAiOjE1NDc5MDE1NDIsIm5iZiI6MTU0Nzg3OTk0MiwianRpIjoiS3Q1WW44T0xPc2VmbUQxdCJ9.12GwNnNX6c0OEjgApd4clK1l5wbaA7Zmevp3N1pI_cs');
        //Parham
        'Bearer ' + globals.userToken);
    HttpClientResponse response = await request.close();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if');
//        fetchedData = data['result']['projects'];
//        print(isLoading);
        print(data['result']);
        setState(() {
          isLoading = false;
        });
      } else {
        print('else');
//        setState(() {
//          loading = false;
//          createFailed = true;
//        });
      }
    } else {}
  }

  Future<void> getThingsData() async {
    setState(() {
      thingsDataIsLoading = true;
    });
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/things/data';
    HttpClient httpClient = new HttpClient();
    Map jsonMap = {
      'since': '1100649440',
      'limit': '20',
      'offset': '0',
      'thing_ids': '{"ids":["5bac5fe9df9e48000a194f9b"]}',
      'project_id': '5bac5dd0df9e48000b4d4fb3'
    };

    HttpClientRequest request = await httpClient.postUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer ' + globals.userToken);

    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    print('getThingsData');
    print(response.statusCode);
    // TODO if (statusCode == 401) then call refresh endpoint
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if getThingsData');
        f = data['result']['data'];
        print(f);
        print(f.length);
        if (mounted) {
          setState(() {
            thingsDataIsLoading = false;
          });
        }
      } else {
        print('else');
      }
    } else {}
    setState(() {});
  }

  String dateConvertor(String apiDate) {
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
    List array = apiTime.split('.');
    List dateTime = array[0].split('T');
    return dateTime[1];
  }

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }
  String dataExtractor(Map<String, dynamic> data){
    String extracted = '';
    data.forEach((key, value) {
      extracted = extracted + key.toString() + ' : ' + value.toString() + '\n';
    });
    print(extracted);
    return extracted;
  }

}
