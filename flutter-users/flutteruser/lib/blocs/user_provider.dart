import 'package:flutter/material.dart';
import 'package:flutteruser/blocs/user_bloc.dart';
export 'package:flutteruser/blocs/user_bloc.dart';

class UserProvider extends InheritedWidget {
  final UserBloc bloc = UserBloc();

  UserProvider({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static UserBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<UserProvider>())!.bloc;
  }
}