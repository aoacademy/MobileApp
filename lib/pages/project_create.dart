import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:iot_manager/globals.dart' as globals;

class ProjectCreate extends StatefulWidget {
  ProjectCreateState createState() => new ProjectCreateState();
}

class ProjectCreateState extends State<ProjectCreate> {
  final String nameHint = 'Name';
  final detailsHint = 'Details';
  bool createFailed = false;
  bool loading = false;

  final projectNameController = new TextEditingController();
  final projectDetailsController = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    projectNameController.dispose();
    projectDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ایجاد پروژه'),
        ),
        body:

        Column(
          children: <Widget>[
            Container(
              child: Expanded(
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
                                filled: true,
//                                hintText: nameHint,
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
                              controller: projectDetailsController,
                              decoration: InputDecoration(
//                                                  fillColor: Colors.yellow,
                                filled: true,
//                                hintText: detailsHint,
                              ),
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
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        child: RaisedButton(
                          color: Colors.red,
                          splashColor: Colors.redAccent,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'انصراف',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        splashColor: Colors.blueGrey,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'ذخیره',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          createProject();
                          Navigator.pop(context, true);
                        },
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createProject() async {
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/project';
    print('createProject');
    HttpClient httpClient = new HttpClient();
    Map jsonMap = {
      'name': projectNameController.text,
      'description': projectDetailsController.text
    };
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set(
        'Authorization',
        'Bearer ' + globals.userToken);
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if');
        if (mounted) {
          setState(() {
            loading = false;
            createFailed = false;
          });
        }
      } else {
        print('else');
        if (mounted) {
        setState(() {
          loading = false;
          createFailed = true;
        });
        }
      }
    } else {}
  }
}
