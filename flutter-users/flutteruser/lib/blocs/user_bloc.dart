import 'package:flutteruser/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserBloc{

  final _users = BehaviorSubject<List<User>>();
  
  Stream<List<User>> get contacts => _users.stream;

  Function(List<User>) get changeContacts => _users.sink.add;

  dispose(){
    _users.close();
  }

  Future<List<User>> fetchUsers()async{ 

    var uri = "https://assessment-users-backend.herokuapp.com/users.json";
    var response = await http.get(Uri.parse(uri));
    List<User> userList = (convert.jsonDecode(response.body) as List)
        .map((f) => User.fromJson(f))
        .toList();
    return userList;

  }

}