  sdk: ">=2.0.0-dev.68.0 <3.0.0"
TextField(
//                                            controller: projectNameController,
//                                            decoration: InputDecoration(
//                                              fillColor: Colors.red,
//                                              filled: true,
//                                              hintText:
//                                                  'Please enter a search term',
////                                              labelText: 'ایمیل یا موبایل',
//
//                                            ),
//                                          ),



Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    margin: EdgeInsets.only(top: 15.0),
                    decoration: BoxDecoration(
                      color: Color(0x91C8728591),
                      border: Border(
                        bottom: BorderSide(
                            width: 1.0,
                            width: 1.0,
                            color: Color.fromRGBO(200, 200, 200, 1.0)),
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
                  
                  
                  
                  
                  
                  
                  Container(
                    margin: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      children: <Widget>[
                        Row(
                          textDirection: TextDirection.rtl,
//                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
//                            Center(
//                              child:
                            Container(
//                              alignment: FractionalOffset(0.5, 0.5),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1.0),
//                                  color: Colors.purple,
                                  ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    textDirection: TextDirection.rtl,
//                                    mainAxisAlignment: MainAxisAlignment.start,
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text('نام پروژه:'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text('kjsbdkjasbajh'),
//                                      Column(
//                                        children: <Widget>[
//                                          Container(
////                                              alignment: Alignment.center,
//                                            width: 310.0,
//                                            child: TextField(
//                                              controller: projectNameController,
//                                              decoration: InputDecoration(
////                                                  fillColor: Colors.yellow,
//                                                filled: true,
//                                                hintText: 'sdfdsfdfdsafs',
//                                              ),
//                                            ),
//                                          ),
//                                        ],
//                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
//                            ),
                          ],
                        ),
                      ],
                    ),
                  ),




Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Container(
//                                              alignment: Alignment.center,
                                            width: 310.0,
                                            child: TextField(
                                              controller: projectNameController,
                                              decoration: InputDecoration(
//                                                  fillColor: Colors.yellow,
                                                filled: true,
                                                hintText: 'sdfdsfdfdsafs',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    //1
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text('توضیحات:'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    //1
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text('وضعیت:'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),