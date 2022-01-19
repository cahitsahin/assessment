import 'package:flutter/material.dart';
import 'package:flutteruser/blocs/user_bloc.dart';

class UserProvider extends InheritedWidget{
  final UserBloc bloc;

  UserProvider({required Key key, required Widget child})
    :bloc = UserBloc(),
    super(key:key,child:child);

    bool updateShouldNotify(_) => true;

    static UserBloc of (BuildContext context){
      return(context.dependOnInheritedWidgetOfExactType<UserProvider>() as UserProvider)
      .bloc;
    }
}