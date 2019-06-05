import 'package:flutter/material.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
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
    home: ThingView(data),
  ));
}

class ThingView extends StatefulWidget {
  final String data;

  const ThingView(this.data);

  ThingViewState createState() => new ThingViewState();
}

class ThingViewState extends State<ThingView> {
//  List fetchedData;
  bool isLoading = false;
  bool isActive = false;
  Map<String, dynamic> fetchedData;

  @override
  void initState() {
    super.initState();
    getThingProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('مشاهده اشیا'),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Container(
                    child: Expanded(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            margin: EdgeInsets.only(top: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0x91C8728591),
                              border: Border(),
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
                                        'اطلاعات کلی',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
//                      color: Colors.blueGrey,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                                right: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                                left: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'Name',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'LoRaWAN MAC Version',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']['macVersion'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'LoRaWAN Regional Parameters revision',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']
                                            ['regParamsRevision'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'Max EIRP',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']['maxEIRP']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            margin: EdgeInsets.only(top: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0x91C8728591),
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
                                        'فعالسازی',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                                right: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                                left: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'Supports Join (OTAA)',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']
                                                ['supportsJoin']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'RX1 Delay',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']['rxDelay1']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'RX1 Data Rate Offset',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']['rxDROffset1']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'RX2 Data Rate',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']['rxDataRate2']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'RX2 Channel Frequency',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']['rxFreq2']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            margin: EdgeInsets.only(top: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0x91C8728591),
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
                                        'کلاس B',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                                right: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                                left: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'Supports Class-B',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']
                                                ['supportsClassB']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'Class-B Confirmed Downlink Timeout',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']
                                                ['classBTimeout']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'Class-B Ping-Slot Periodicity',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']
                                                ['pingSlotPeriod']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'Class-B Ping-Slot Data-Rate',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']['pingSlotDR']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'Class-B Ping-Slot Frequency (Hz)',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']
                                                ['pingSlotFreq']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            margin: EdgeInsets.only(top: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0x91C8728591),
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
                                        'کلاس C',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                                right: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                                left: BorderSide(
                                  width: 10.0,
                                  color: Color(0x91C8728591),
                                ),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'Supports Class-C',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']
                                                ['supportsClassC']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10.0, left: 5.0),
                                      child: Text(
                                        'Class-C Confirmed Downlink Timeout',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      color: Color(0x91C8728591),
                                      width: 190.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 1.0, vertical: 3.0),
                                      margin: EdgeInsets.only(
                                          top: 5.0, right: 5.0, bottom: 3.0),
                                      child: Text(
                                        fetchedData['parameters']
                                                ['classCTimeout']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
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

  Future<void> getThingProfileDetails() async {
    setState(() {
      isLoading = true;
    });
    String getUrl =
        'http://platform.ceit.aut.ac.ir:50008/api/v1/thing-profile/' +
            widget.data;
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
        fetchedData = data['result']['thing_profile'];
        print(fetchedData);
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
}
