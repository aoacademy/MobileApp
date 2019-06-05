import 'package:flutter/material.dart';
import 'package:iot_manager/pages/received_data.dart';
import 'package:iot_manager/pages/thing_project_with_app_bar.dart';
import 'projects_with_app_bar.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:iot_manager/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:iot_manager/globals.dart' as globals;
import 'package:shamsi_date/shamsi_date.dart';

class Profile extends StatefulWidget {
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  bool projectIsLoading = false;
  bool thingIsLoading = false;
  bool thingsDataIsLoading = false;
  bool isLoading = false;
  List fetchedProjectData;
  List fetchedThingData;
  List f;
  List fetchedData;
  var hasPicure = false;

  @override
  void initState() {
    getProjects();
    getThingProjects();
    getThingsData();
    userPictureGetter();
//    _StatefulWidgetDemoState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('ProfileState------->');
    print(globals.userName);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.up,

            //ROW 1
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: const [
                        Colors.purple,
                        Colors.blue,
                      ],
                    ),
                  ),
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      hasPicure
                          ? Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      'http://platform.ceit.aut.ac.ir:50008/' +
                                          globals.userPicture),
                                ),
                              ),
                            )
                          : Container(
                              child: Icon(
                                Icons.account_circle,
                                size: 60.0,
                                color: Colors.white,
                              ),
                            ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child:
//                      ScopedModelDescendant<UserModel>(
//                        builder: (context, child, model) =>

                            FutureBuilder<String>(
                          future: userNameGetter(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasError) {
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: FutureBuilder<String>(
                                  future: packageNameGetter(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    return Text(
                                      'بسته ' + snapshot.data,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.topCenter,
                ),
              ),
            ],
          ),
          Row(
            //ROW 2
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ButtonTheme(
                minWidth: 110.0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: RaisedButton(
                  color: Colors.blue,
                  splashColor: Colors.blueGrey,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        projectIsLoading
                            ? CircularProgressIndicator()
                            : Text(
                                replaceFarsiNumber(
                                        fetchedProjectData.length.toString()) +
                                    ' پروژه',
                                style: TextStyle(color: Colors.white),
                              ),
                      ],
                    ),
                  ),
                  onPressed: () => Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ProjectsWithAppBar(),
                        ),
                      ).then((bool value) {}),
                ),
              ),
              ButtonTheme(
                minWidth: 110.0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: RaisedButton(
                  color: Colors.blue,
                  splashColor: Colors.blueGrey,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        thingIsLoading
                            ? CircularProgressIndicator()
                            : Text(
                                replaceFarsiNumber(
                                        fetchedThingData.length.toString()) +
                                    ' شی',
                                style: TextStyle(color: Colors.white),
                              ),
                      ],
                    ),
                  ),
                  onPressed: () => Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ThingProjectWithAppBar(),
                        ),
                      ).then((bool value) {}),
                ),
              ),
            ],
          ),

          Column(
            children: <Widget>[
              thingsDataIsLoading
                  ? Container()
                  : f.length > 0
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
//          RefreshIndicator(
//            onRefresh: getThingsData,
//            child:
          thingsDataIsLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : f.length > 0
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
                                                dataExtractor(f[i]['data']);
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
//          ),
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

  Future<void> getProjects() async {
    setState(() {
      projectIsLoading = true;
    });
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/project';
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer ' + globals.userToken);

    HttpClientResponse response = await request.close();
    print('getProjectsINPROFILE');
    print(response.statusCode);
    // TODO if (statusCode == 401) then call refresh endpoint
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if');
        fetchedProjectData = data['result']['projects'];
        setState(() {
          projectIsLoading = false;
        });
      } else {
        print('else');
      }
    } else {}
  }

  Future<void> getThingProjects() async {
    setState(() {
      thingIsLoading = true;
    });
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/things';
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer ' + globals.userToken);

    HttpClientResponse response = await request.close();
    print('getThingProjects');
    print(response.statusCode);
    // TODO if (statusCode == 401) then call refresh endpoint
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if');
        fetchedThingData = data['result']['things'];
        print(fetchedThingData);
        if (mounted) {
          setState(() {
            thingIsLoading = false;
          });
        }
      } else {
        print('else');
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

  Future<String> userNameGetter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pack = (prefs.getString('userName') ?? 'userName');
    print('userNameGetter');
    print(pack);
    return pack;
  }

  Future<String> userTokenGetter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pack = (prefs.getString('userToken') ?? 'userToken');
    return pack;
  }

  Future<String> userPictureGetter() async {
    Set<String> keys;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    keys = prefs.getKeys();
    print(keys);
    String pack = (prefs.getString('userPicture') ?? 'userPicture');
    print('userPictureGetter');
    print(pack);
    if (pack != 'userPicture') {
      setState(() {
        hasPicure = true;
      });
    }
    return pack;
  }

  Future<String> packageNameGetter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pack = (prefs.getString('packageName') ?? 'packageName');
    return pack;
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

  String dataExtractor(Map<String, dynamic> data){
    String extracted = '';
    data.forEach((key, value) {
      extracted = extracted + key.toString() + ' : ' + value.toString() + '\n';
    });
    print(extracted);
    return extracted;
  }
}
