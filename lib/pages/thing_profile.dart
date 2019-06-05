import 'package:flutter/material.dart';
import 'package:iot_manager/pages/thing_profile_create.dart';
import 'package:iot_manager/pages/thing_view.dart';
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

class ThingProfile extends StatefulWidget {
  ThingProfileState createState() => ThingProfileState();
}

class ThingProfileState extends State<ThingProfile>
    with AutomaticKeepAliveClientMixin<ThingProfile> {

  @override
  bool get wantKeepAlive => true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List fetchedData;

  bool isLoading = false;
  bool isActive = false;
  List<Map<String, dynamic>> passingData;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getThingProfiles();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var buttonValue;
    return Scaffold(
      key: _scaffoldKey,
      body: RefreshIndicator(
        onRefresh: getThingProfiles,
        child: Column(
          children: <Widget>[
            isLoading
                ? Container()
                : Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              margin: EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                color: Color(0x91C8728591),
                border: Border(
                  bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0),
                  ),
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
                          'عنوان',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'شناسه پروفایل',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'امکانات',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Flexible(
                child: ListView.builder(
                    itemCount: fetchedData == null ? 0 : fetchedData.length,
                    itemBuilder: (BuildContext context, i) {
                      return Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
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
                                      width: 100.0,
                                      child: Text(
                                        fetchedData[i]['name'],
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                              100, 100, 100, 1.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        replaceFarsiNumber(fetchedData[i]['thing_profile_slug']
                                            .toString()),
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                              100, 100, 100, 1.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: Text('عملیات'),
                                        value: buttonValue,
                                        onChanged: (newValue) {
                                          buttonValue = newValue;
                                          print(buttonValue);
                                          if (buttonValue == 'نمایش') {
                                            Navigator.push<bool>(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (
                                                      BuildContext context) =>
                                                  ThingView(
                                                      Map < String, dynamic>.
                                                      from(fetchedData[i
                                                      ])['_id']),
                                            ),)
                                              .
                                          then
                                          (
                                          (
                                          bool
                                          value
                                          )
                                          {
                                          }
                                          );
                                          }
                                          else
                                          if
                                          (
                                          buttonValue
                                          ==
                                         "حذف"
                                          )
                                          {
                                          showDialog(
                                          context: context,
                                          builder: (BuildContext
                                          context)
                                          {
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
                                          "آیا شما از حذف این شی مطمئن هستید؟",
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
                                          onPressed: () {
                                          deleteThingProfile(Map<String, dynamic>.from(fetchedData[i])['_id']).then((_){
                                          getThingProfiles();
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
                                          }
                                          ,
                                          );
                                          }
                                        },
                                        items: <String>['نمایش', 'حذف'].map((
                                            String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: <Widget>[
                                                new Text(
                                                  value,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          100, 100, 100, 1.0)),
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
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                ),
            ),
          ],
        ),
      ), floatingActionButton: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 50.0,
          height: 50.0,
          child: FloatingActionButton(
            heroTag: "addThing",
            onPressed: () {
              Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ThingProfileCreate(),
                ),
              ).then((value) => value ? getThingProfiles() : null);
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blueAccent,
          ),
        ),


      ],
    ),
    );
  }

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }
  Future<void> getThingProfiles() async {
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/thing-profile';
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
    print('getThingProfiles');
    print(response.statusCode);
    // TODO if (statusCode == 401) then call refresh endpoint
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if');
        fetchedData = data['result']['thing_profiles'];
        print(fetchedData);

        setState(() {
          isLoading = false;
        });
      } else {
        print('else');
      }
    } else {}
  }
  Future<void> deleteThingProfile(String thingProfileId) async {
    print('deleteProject');
    print(thingProfileId);
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/thing-profile/' + thingProfileId;
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.deleteUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set(
        'Authorization',
        'Bearer ' + globals.userToken);
    HttpClientResponse response = await request.close();
    print('thingProfileId response.reasonPhrase');
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
  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('شی با موفقیت حذف شد.',
      style: TextStyle(
        fontFamily: 'Shabnam',
      ),));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
