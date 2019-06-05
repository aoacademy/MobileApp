import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:iot_manager/globals.dart' as globals;

class ThingProfileCreate extends StatefulWidget {
  ThingProfileCreateState createState() => new ThingProfileCreateState();
}

class ThingProfileCreateState extends State<ThingProfileCreate> {
//  final String nameHint = 'Name';
//  final detailsHint = 'Details';
//  bool createFailed = false;
  bool loading = false;
  bool _valueSupportB = false;
  bool _valueSupportC = false;

  final ThingProfileNameController = new TextEditingController();
  final ThingProfileMaxERIPController = new TextEditingController(); //
  final ThingProfileRX1DelayController = new TextEditingController();
  final ThingProfileRX1DataRateOffsetController = new TextEditingController();
  final ThingProfileRX2DataRateController = new TextEditingController();
  final ThingProfileRX2ChannelFrequencyController = new TextEditingController();
  final ThingProfileClassBPingPeriodicController = new TextEditingController();
  final ThingProfileClassBTimeoutController = new TextEditingController();
  final ThingProfileClassCTimeoutController = new TextEditingController();
  final ThingProfileClassBPingFrequencyController = new TextEditingController();
  final ThingProfileClassBPingDataRateController = new TextEditingController();
  var ThingProfileMacVersion = '1.0.0';
  var ThingProfileReginalParams = 'A';
  var ThingProfileSupportsJoin = 'ABP';
  var selected;
  var selectedOTAA;
  var selectedMAC;

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      ThingProfileNameController.dispose();
      super.dispose();
    }

    var buttonValue;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ساخت پروفایل شی'),
        ),
        body: Column(
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
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
//                              padding: EdgeInsets.symmetric(
//                                  horizontal: 1.0, vertical: 3.0),
                                margin: EdgeInsets.only(
                                    top: 5.0, right: 5.0, bottom: 3.0),
                                child: Row(
                                  textDirection: TextDirection.ltr,
                                  children: <Widget>[
                                    Container(
//                                    margin: EdgeInsets.only(top: 2.0, left: 5.0),
                                      width: 190.0,
//                                    height: 30.0,
                                      child: TextField(
                                        controller: ThingProfileNameController,
                                        decoration: InputDecoration(
                                          filled: true,
//                                hintText: nameHint,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
//                                padding: EdgeInsets.symmetric(
//                                    horizontal: 1.0, vertical: 3.0),
                                margin: EdgeInsets.only(
                                    top: 5.0, right: 5.0, bottom: 3.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text(ThingProfileMacVersion),
                                    value: selectedMAC,
                                    onChanged: (newValue) {
                                      selectedMAC = newValue;
                                      setState(() {
                                        ThingProfileMacVersion = newValue;
                                      });
                                      print(buttonValue);
                                    },
                                    items: <String>[
                                      '1.0.0',
                                      '1.0.1',
                                      '1.0.2',
                                      '1.1.0'
                                    ].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Text(
                                              value,
                                              style: TextStyle(
//                                                  color: Color.fromRGBO(
//                                                      100, 100, 100, 1.0),
                                                  ),
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
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text(ThingProfileReginalParams),
                                    onChanged: (newValue) {
                                      selected = newValue;
                                      setState(() {
                                        ThingProfileReginalParams = newValue;
                                      });
                                    },
                                    value: selected,
                                    items:
                                        <String>['A', 'B'].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Text(
                                              value,
                                              style: TextStyle(
//                                                  color: Color.fromRGBO(
//                                                      100, 100, 100, 1.0)
                                                  ),
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
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: ThingProfileMaxERIPController,
                                  decoration: InputDecoration(
                                    filled: true,
//                                hintText: nameHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text(ThingProfileSupportsJoin),
                                    value: selectedOTAA,
                                    onChanged: (newValue) {
                                      selectedOTAA = newValue;
                                      setState(() {
                                        ThingProfileSupportsJoin = newValue;
                                      });
                                      if (buttonValue == 'OTAA') {}
                                    },
                                    items: <String>['OTAA', 'ABP']
                                        .map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Text(
                                              value,
                                              style: TextStyle(
//                                                  color: Color.fromRGBO(
//                                                      100, 100, 100, 1.0),
                                                  ),
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
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: ThingProfileRX1DelayController,
                                  decoration: InputDecoration(
                                    filled: true,
//                                hintText: nameHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      ThingProfileRX1DataRateOffsetController,
                                  decoration: InputDecoration(
                                    filled: true,
//                                hintText: nameHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: ThingProfileRX2DataRateController,
                                  decoration: InputDecoration(
                                    filled: true,
//                                hintText: nameHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      ThingProfileRX2ChannelFrequencyController,
                                  decoration: InputDecoration(
                                    filled: true,
//                                hintText: nameHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
                                child: Text(
                                  'Supports Class-B',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Checkbox(
                                value: _valueSupportB,
                                onChanged: (bool value) {
                                  setState(() {
                                    _valueSupportB = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      ThingProfileClassBTimeoutController,
                                  decoration: InputDecoration(
                                    filled: true,
//                                hintText: nameHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      ThingProfileClassBPingPeriodicController,
                                  decoration: InputDecoration(
                                    filled: true,
//                                hintText: nameHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      ThingProfileClassBPingDataRateController,
                                  decoration: InputDecoration(
                                    filled: true,
//                                hintText: nameHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      ThingProfileClassBPingFrequencyController,
                                  decoration: InputDecoration(
                                    filled: true,
//                                hintText: nameHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
                                child: Text(
                                  'Supports Class-C',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
//                              new Checkbox(value: _value1, onChanged: _supportClassCChanged),
//                              new Checkbox(value: _value3, onChanged: _value1Changed),
                              Checkbox(
                                value: _valueSupportC,
                                onChanged: (bool value) {
                                  setState(() {
                                    _valueSupportC = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10.0, left: 5.0),
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
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      ThingProfileClassCTimeoutController,
                                  decoration: InputDecoration(
                                    filled: true,
//                                hintText: nameHint,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          child: RaisedButton(
                            onPressed: () async {
                              if (ThingProfileNameController.text.length == 0) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        content: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Container(
                                            child: Text(
                                              "واردکردن نام الزامی است.",
                                              style: TextStyle(
                                                  fontFamily: 'Shabnam',
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                print(ThingProfileNameController.text);
                                createThingProfile();
                              }
                            },
                            child: Text(
                              'ذخیره',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createThingProfile() async {
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/thing-profile';
    print('createThingProfile');
    HttpClient httpClient = new HttpClient();

    var classBTimeout; //---------------------
    var classCTimeout; //---------------------
    var factoryPresetFreqs;
    var macVersion; //----------------------
    var maxDutyCycle;
    var maxEIRP; //----------------------
    var pingSlotDR; //----------------------
    var pingSlotFreq; //----------------------
    var pingSlotPeriod; //---------------------
    var regParamsRevision;
    var rfRegion;
    var rxDROffset1; //----------------------
    var rxDataRate2;
    var rxDelay1;
    var rxFreq2; //----------------------
    var supports32bitFCnt;
    var supportsClassB; //********************
    var supportsClassC; //********************
    var supportsJoin; //********************

    ThingProfileMaxERIPController.text.length > 0
        ? maxEIRP = ThingProfileMaxERIPController.text
        : maxEIRP = 0;

    ThingProfileRX1DelayController.text.length > 0
        ? rxDelay1 = ThingProfileRX1DelayController.text
        : rxDelay1 = 0;

    ThingProfileRX1DataRateOffsetController.text.length > 0
        ? rxDROffset1 = ThingProfileRX1DataRateOffsetController.text
        : rxDROffset1 = 0;

    ThingProfileRX2DataRateController.text.length > 0
        ? rxDataRate2 = ThingProfileRX2DataRateController.text
        : rxDataRate2 = 0;

    ThingProfileRX2ChannelFrequencyController.text.length > 0
        ? rxFreq2 = ThingProfileRX2ChannelFrequencyController.text
        : rxFreq2 = 0;

    ThingProfileClassBTimeoutController.text.length > 0
        ? classBTimeout = ThingProfileClassBTimeoutController.text
        : classBTimeout = 0;

    ThingProfileClassBPingPeriodicController.text.length > 0
        ? pingSlotPeriod = ThingProfileClassBPingPeriodicController.text
        : pingSlotPeriod = 0;

    ThingProfileClassBPingDataRateController.text.length > 0
        ? pingSlotDR = ThingProfileClassBPingDataRateController.text
        : pingSlotDR = 0;

    ThingProfileClassBPingFrequencyController.text.length > 0
        ? pingSlotFreq = ThingProfileClassBPingFrequencyController.text
        : pingSlotFreq = 0;

    ThingProfileClassCTimeoutController.text.length > 0
        ? classCTimeout = ThingProfileClassCTimeoutController.text
        : classCTimeout = 0;

    ThingProfileSupportsJoin == 'ABP' ? supportsJoin = 0 : supportsJoin = 1;
    _valueSupportB ? supportsClassB = 1 : supportsClassB = 0;
    _valueSupportC ? supportsClassC = 1 : supportsClassC = 0;

    Map jsonMap = {
      'name': ThingProfileNameController.text,
      'macVersion': macVersion,
      'rfRegion': ThingProfileReginalParams,
      'maxEIRP': maxEIRP,
      'supportsJoin': supportsJoin,
      'rxDelay1': rxDelay1,
      'rxDROffset1': rxDROffset1,
      'rxDataRate2': rxDataRate2,
      'rxFreq2': rxFreq2,
      'supportsClassB': supportsClassB,
      'classBTimeout': classBTimeout,
      'pingSlotPeriod': pingSlotPeriod,
      'pingSlotDR': pingSlotDR,
      'pingSlotFreq': pingSlotFreq,
      'supportsClassC': supportsClassC,
      'classCTimeout': classCTimeout,
    };

    HttpClientRequest request = await httpClient.postUrl(Uri.parse(getUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set(
        'Authorization',
        //Sarah
//        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI1YzNkZjY4NWRmOWU0ODAwYjI3NWU2ODciLCJpc3MiOiJodHRwOi8vcGxhdGZvcm0uY2VpdC5hdXQuYWMuaXI6NTAwMDgvYXBpL3YxL2xvZ2luIiwiaWF0IjoxNTQ3NzIzMTkwLCJleHAiOjE1NDc3NDQ3OTAsIm5iZiI6MTU0NzcyMzE5MCwianRpIjoiWjRkMGVjRHJqNko2VXh5TSJ9.O1Hp_FWBn6hqrQKw8V5DU63BMIlM6DXMgG_wJHhgsfo');
        //Parham
        'Bearer ' + globals.userToken);
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data);
      if (data['code'] == 200) {
        print('if');
        if (mounted) {
          setState(() {
            loading = false;
//            createFailed = false;
          });
        }
      } else {
        print('else');
        if (mounted) {
          setState(() {
            loading = false;
//            createFailed = true;
          });
        }
      }
    } else {}
  }
}
