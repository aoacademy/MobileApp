import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

  String _user = 'John Doe';

//  static UserModel of(BuildContext context) =>
//      ScopedModel.of<UserModel>(context);

  void changeUser(String user){
    this._user = user;
    print(this._user);
    notifyListeners();
  }


  String get user => _user;

}