import 'package:flutter/material.dart';


class ReceivedData extends StatefulWidget{
  State<StatefulWidget> createState() {
    return ReceivedDataState();
  }
}

class ReceivedDataState extends State<ReceivedData>{

  @override
  void setState(fn) {
    super.setState(fn);
  }



//Widget _buildDataItem(BuildContext context, int index){
//    return Card(
////                margin: EdgeInsets.symmetric(horizontal: 1.0),
////      decoration: BoxDecoration(
////        color: Colors.white,
////        border: Border(
////          bottom: BorderSide(
////              width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
////        ),
////      ),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Container(
//                width: 100.0,
////                      decoration: BoxDecoration(color: Colors.red),
//                padding: EdgeInsets.symmetric(
//                    horizontal: 2.0, vertical: 3.0),
//                child: Text(
//                    "ccccccccccccccsdsdsdsشی تست"),
//              ),
//            ],
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.symmetric(
//                    horizontal: 2.0, vertical: 3.0),
//                child: Text("18:49:20 1397/6/29"),
//              ),
//            ],
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.symmetric(horizontal: 3.0),
//                child: ButtonTheme(
//                  minWidth: 40.0,
//                  height: 35.0,
//                  child: RaisedButton(
//                    child: Text(
//                      'مشاهده',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    color: Colors.blue,
//                    elevation: 2.0,
//                    splashColor: Colors.cyan,
//                    onPressed: () {
//                      showDialog(
//                          context: context,
//                          child: new AlertDialog(
//                            title: new Text(
//                              "داده",
//                              textAlign: TextAlign.right,
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold),
//                            ),
//                            content: Text("{"
//                                "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
//                                "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
//                                "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
//                                "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
//                                "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
//                                "200 OK"
//                                "}"),
//                          ));
//                    },
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//}

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ListView(
        children: <Widget>[
//                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Color(0x91C8728591),
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding:
                  EdgeInsets.only(right: 7.0, top: 10.0, bottom: 10.0),
                  child: Text(
                    "شی فرستنده",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0),
                  child: Text(
                    "زمان دریافت داده",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.only(left: 7.0, top: 10.0, bottom: 10.0),
                  child: Text(
                    "داده دریافت شده",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
//                ])
          ,
//                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("شی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("شی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 40.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text(
                          "ffdfdasccccccccccccc ccccccccccccccsdsdsdsشی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 40.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 2.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("شی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("شی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 40.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text(
                          "ffdfdasccccccccccccc ccccccccccccccsdsdsdsشی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 40.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 2.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("شی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("شی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 40.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text(
                          "ffdfdasccccccccccccc ccccccccccccccsdsdsdsشی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 40.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 2.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("شی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("شی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 40.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text(
                          "ffdfdasccccccccccccc ccccccccccccccsdsdsdsشی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 40.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 2.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("شی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("شی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 40.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 4.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
//                margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(200, 200, 200, 1.0)),
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
//                      decoration: BoxDecoration(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text(
                          "ffdfdasccccccccccccc ccccccccccccccsdsdsdsشی تست"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 3.0),
                      child: Text("18:49:20 1397/6/29"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: ButtonTheme(
                        minWidth: 40.0,
                        height: 35.0,
                        child: RaisedButton(
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          elevation: 2.0,
                          splashColor: Colors.cyan,
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: new Text(
                                    "داده",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text("{"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdata:sarahdataarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "data: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarahdata: sarah"
                                      "200 OK"
                                      "}"),
                                ));
                          },
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
    );
  }

}

