import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/user_model.dart';

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // First, create a `ScopedModel` widget. This will provide
    // the `model` to the children that request it.
    return new ScopedModel<UserModel>(
        model: new UserModel(),
        child: new Column(children: [
          // Create a ScopedModelDescendant. This widget will get the
          // CounterModel from the nearest ScopedModel<CounterModel>.
          // It will hand that model to our builder method, and rebuild
          // any time the CounterModel changes (i.e. after we
          // `notifyListeners` in the Model).
          new ScopedModelDescendant<UserModel>(
            builder: (context, child, model) => new Text('${model.user}'),
          ),
          new Text("Another widget that doesn't depend on the CounterModel")
        ])
    );
  }
}