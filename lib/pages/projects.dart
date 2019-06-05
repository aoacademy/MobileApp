import 'package:flutter/material.dart';
import 'package:iot_manager/pages/project_create.dart';
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

class Projects extends StatefulWidget {
  ProjectsState createState() => ProjectsState();
}

class ProjectsState extends State<Projects>{

  List fetchedData ;
  bool isLoading = false;
  bool isActive = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    this.getProjects();
  }


  @override
  Widget build(BuildContext context) {
    var buttonValue;
    return Scaffold(
      key: _scaffoldKey,
      body:
          RefreshIndicator(onRefresh: getProjects, child:
      Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment(1.0, -0.6),
            child: Text(
              'لیست پروژه‌ها',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Color.fromRGBO(100, 100, 100, 1.0),
              ),
            ),
          ),
          isLoading? Container():
          fetchedData.length > 0 ? Container (
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
                          'نام پروژه',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 7.0, top: 10.0, bottom: 10.0),
                        child: Text(
                          'وضعیت',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 7.0, top: 10.0, bottom: 10.0),
                        child: Text(
                          'امکانات',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child:               Text('لیست پروژه‌ها خالی است.'),
              ),
            ],
          ),
          isLoading ? Center(
            child: CircularProgressIndicator(),
          ):Flexible(
            child: ListView.builder(
                itemCount: fetchedData == null ? 0 : fetchedData.length,
                itemBuilder: (BuildContext context, i) {
                  return Stack(
                    children: <Widget>[
                    Container(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: Color.fromRGBO(200, 200, 200, 1.0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 110.0,
//                        color: Colors.red,
                        padding: EdgeInsets.only(
                            right: 7.0, top: 10.0, bottom: 10.0),
                        child: Text(
                          fetchedData[i]['name'],
                          style: TextStyle(
                            color: Color.fromRGBO(100, 100, 100, 1.0),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(children: <Widget>[
                          fetchedData[i]['active'] ? Container(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              'فعال',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ) : Container(
                          padding: EdgeInsets.all(3.0),
                            child: Text(
                              'غیرفعال',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
//                          Container(
//                            child: Text(
//                              'عدم پارس داده',
//                              style: TextStyle(
//                                  color: Colors.grey,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ),
                        ],
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text('عملیات'),
                          value: buttonValue,
                          onChanged: (newValue) {
                            buttonValue = newValue;
                            print(buttonValue);
                            if (buttonValue == 'نمایش') {
                              print(Map<String, dynamic>.from(fetchedData[i]));
                              Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ProjectView(Map<String, dynamic>.from(fetchedData[i])['_id']),
                                ),
                              ).then((bool value) {});
                            } else if (buttonValue == 'مدیریت') {
                              Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                    ProjectManage(Map<String, dynamic>.from(fetchedData[i])['name'], Map<String, dynamic>.from(fetchedData[i])['description'], Map<String, dynamic>.from(fetchedData[i])['active'], Map<String, dynamic>.from(fetchedData[i])['_id']),
                                ),
                              ).then((value)=>value ? getProjects() : null);
                            } else if (buttonValue == 'حذف') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        "حذف",
                                        style: TextStyle(
                                          fontFamily: 'Shabnam',
                                        ),
                                      ),
                                    ),
                                    content: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        "آیا شما از حذف این پروژه مطمئن هستید؟",
                                        style: TextStyle(
                                          fontFamily: 'Shabnam',
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          FlatButton(
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                "بلی",
                                                style: TextStyle(
                                                  fontFamily: 'Shabnam',
                                                ),
                                              ),
                                            ),
                                            onPressed: () async{
                                              deleteProject(Map<String, dynamic>.from(fetchedData[i])['_id']).then((_){
                                                getProjects();
                                              });
                                              _displaySnackBar(context);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                "خیر",
                                                style: TextStyle(
                                                  fontFamily: 'Shabnam',
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          items: <String>['نمایش', 'مدیریت', 'حذف']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    value,
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(100, 100, 100, 1.0)),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Shabnam',
                            decorationColor: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                    ],
                  );
                }
            ),
          ),
        ],
      ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            child: FloatingActionButton(
              heroTag: "addProject",
              onPressed: () {
                Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProjectCreate(),
                  ),
                ).then((value) => value ? getProjects() : null)
                ;
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blueAccent,
            ),
          ),


        ],
      ),

    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('پروژه با موفقیت حذف شد.',
      style: TextStyle(
        fontFamily: 'Shabnam',
      ),));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> getProjects() async{
print('userToken in PROJECTS');
print(globals.userToken);
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/project';
    HttpClient httpClient = new HttpClient();
//    Map jsonMap = {
//      'name': projectNameController.text,
//      'description': projectDetailsController.text
//    };
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set(
        'Authorization',
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
        fetchedData = data['result']['projects'];
        print(isLoading);
        setState(() {
          isLoading = false;
        });
      } else {
        print('else');
      }
    } else {}
  }

  Future<void> deleteProject(String projectId) async {
    print('deleteProject');
    print(projectId);
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/project/' + projectId;
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.deleteUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set(
        'Authorization',
        'Bearer ' + globals.userToken);
    HttpClientResponse response = await request.close();
    print('PROJECTS response.reasonPhrase');
    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data);
      if (data['code'] == 200) {
        print('if');
      } else {
        print('else');
      }
    } else {}
  }

 }
