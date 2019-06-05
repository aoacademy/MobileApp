import 'package:flutter/foundation.dart';
//import 'package:tarafdari/models/filter.dart';

class AppState {
//  final Map<int, List<Map<String, dynamic>>> contentIndexDataItemsList;
//  final Map<int, Map<int, List<Filter>>> contentIndexMetaFiltersList;
//  final Map<int, Map<String, dynamic>> contentIndexMetaList;
  final Map<String, dynamic> currentUser;
//  final List<Map<String, dynamic>> navigationMenuDataItems;
//  final List<Map<String, dynamic>> navigationNewsDataItems;

  AppState({
//    @required this.contentIndexDataItemsList,
//    @required this.contentIndexMetaFiltersList,
//    @required this.contentIndexMetaList,
    @required this.currentUser,
//    @required this.navigationNewsDataItems,
//    @required this.navigationMenuDataItems,
  });

  AppState.initalState():
//       contentIndexDataItemsList = Map<int, List<Map<String, dynamic>>>(),
//        contentIndexMetaFiltersList = Map<int, Map<int, List<Filter>>>(),
//        contentIndexMetaList = Map<int, Map<String, dynamic>>(),
        currentUser = Map<String, dynamic>()
//        ,navigationMenuDataItems = [],
//        navigationNewsDataItems = []
 ;
}
