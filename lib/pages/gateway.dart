import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:iot_manager/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:iot_manager/globals.dart' as globals;

class Gateway extends StatefulWidget {
  GatewayState createState() => GatewayState();
}

class GatewayState extends State<Gateway>
    with AutomaticKeepAliveClientMixin<Gateway> {
  @override
  bool get wantKeepAlive => true;

  List fetchedData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getGateways();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getGateways,
        child: Column(
          children: <Widget>[
            isLoading
                ? Container()
                : fetchedData.length > 0
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
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
//                          mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 40.0),
                                  child: Text(
                                    'شناسه',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'اطلاعات',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Text('لیست گذرگاه‌ها خالی است.')
                          ),
                        ],
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
                                    color: Color.fromRGBO(200, 200, 200, 1.0),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 90.0,
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
//                          mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.0, vertical: 2.0),
                                        child: Text(
                                          macDivider(fetchedData[i]['mac']),
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
                                      Container(
                                        child: IconButton(
                                          iconSize: 20.0,
                                          icon: Icon(
                                            Icons.info,
                                            color: Color.fromRGBO(
                                                100, 100, 100, 1.0),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                content: Container(
                                                  height: 200.0,
                                                  child: Column(
                                                    children: <Widget>[
                                                      fetchedData[i][
                                                                  'description'] !=
                                                              null
                                                          ? Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10.0,
                                                                      horizontal:
                                                                          3.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    width: 1.0,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            200,
                                                                            200,
                                                                            200,
                                                                            1.0),
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        'توضیحات',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Shabnam'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        fetchedData[i]
                                                                            [
                                                                            'description'],
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Shabnam'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : Container(),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 3.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              width: 1.0,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      200,
                                                                      200,
                                                                      200,
                                                                      1.0),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Row(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'وضعیت',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Shabnam'),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                fetchedData[i]['last_seen_at']
                                                                            [
                                                                            'status'] ==
                                                                        'red'
                                                                    ? Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                1.0),
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 3.0),
                                                                        decoration:
                                                                            BoxDecoration(color: Colors.red),
                                                                        child:
                                                                            Text(
                                                                          'غیرفعال',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontFamily: 'Shabnam'),
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                1.0),
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 3.0),
                                                                        decoration:
                                                                            BoxDecoration(color: Colors.green),
                                                                        child:
                                                                            Text(
                                                                          'فعال',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Shabnam',
                                                                            color:
                                                                                Colors.white,
                                                                          ),
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
                                            );
                                          },
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
      ),
    );
  }

  String macDivider(String apiMac) {
    List macs = apiMac.split('');
    String mac = macs[0] +
        macs[1] +
        ':' +
        macs[2] +
        macs[3] +
        ':' +
        macs[4] +
        macs[5] +
        ':' +
        macs[6] +
        macs[7] +
        ':' +
        macs[8] +
        macs[9] +
        ':' +
        macs[10] +
        macs[11] +
        ':' +
        macs[12] +
        macs[13] +
        ':' +
        macs[14] +
        macs[15];
    return mac;
  }

  Future<void> getGateways() async {
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/gateway';
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
    print('getGateways');
    print(response.statusCode);
    // TODO if (statusCode == 401) then call refresh endpoint
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if');
        fetchedData = data['result']['gateways'];
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
