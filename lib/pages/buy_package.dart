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

class BuyPackage extends StatefulWidget {
  BuyPackageState createState() => BuyPackageState();
}

class BuyPackageState extends State<BuyPackage> with AutomaticKeepAliveClientMixin<BuyPackage> {
  @override
  bool get wantKeepAlive => true;

  bool isLoading = false;
  List fetchedData;


  @override
  void initState() {
    isLoading = true;
    getPackages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getPackages,
        child: Column(
          children: <Widget>[
            isLoading
                ? Container()
                : Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Text(
                                'بسته‌ها',
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
                            Column(
                              children: <Widget>[

                                Container(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          textDirection: TextDirection.rtl,
                                          children: <Widget>[
                                            Text(
                                              'نام بسته',
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Text(
                                              'مبلغ قابل پرداخت',
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Text(
                                              'تعداد سنسور',
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Text(
                                              'تعداد پروژه‌',
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Text(
                                              'مهلت بسته',
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 10.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          textDirection: TextDirection.rtl,
                                          children: <Widget>[
                                            Text(fetchedData[i]['name']),
                                            Text(replaceFarsiNumber(fetchedData[i]['price'].toString())
                                                   +
                                                ' تومان'),
                                            Text(replaceFarsiNumber(
                                                fetchedData[i]['node_num']
                                                    .toString()),
                                                style: TextStyle(
                                                    )),
                                            Text(replaceFarsiNumber(
                                                fetchedData[i]['project_num']
                                                    .toString())),
                                            Text(replaceFarsiNumber(
                                              fetchedData[i]['time'].toString()),

                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ButtonTheme(
                                  minWidth: 10.0,
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: RaisedButton(
                                    color: Colors.blue,
                                    splashColor: Colors.blueGrey,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'خرید',
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                          Icon(
                                            Icons.add_shopping_cart,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            content: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child:
                                              Container(
                                                child: Text(
                                                  "در حال حاضر خرید بسته فقط از طریق سایت امکان‌پذیر است.",
                                                  style: TextStyle(
                                                      fontFamily: 'Shabnam',
                                                      fontSize: 14.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
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

  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  Future<void> getPackages() async {
    String getUrl = 'http://platform.ceit.aut.ac.ir:50008/api/v1/packages';
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
    print('getPackages');
    print(response.statusCode);
    // TODO if (statusCode == 401) then call refresh endpoint
    if (response.statusCode == 200) {
      print('first if');
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['code']);
      if (data['code'] == 200) {
        print('if');
        fetchedData = data['result']['packages'];
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
