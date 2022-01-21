import 'dart:convert';

import 'package:flutteruser/models/user.dart';
import 'package:http/http.dart';
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
  
  Future<void> deleteUser(int id) async {
    var uri = "https://assessment-users-backend.herokuapp.com/user";
    Response res = await delete(Uri.parse("$uri/$id"));

    if (res.statusCode == 200) {
      print("DELETED");
    } else {
      throw res.body.toString();
    }
  }

  Future<http.Response> createUser(String firstName, String lastName,) async{
    var uri = "https://assessment-users-backend.herokuapp.com/users";
    var body = jsonEncode({"first_name": firstName, "last_name": lastName,"status":"active"});

    http.Response response = await http.post(Uri.parse(uri),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: body);
    return response;
  }

}