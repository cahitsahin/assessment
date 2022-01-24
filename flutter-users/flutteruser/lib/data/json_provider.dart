import 'dart:convert';
import 'package:flutteruser/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class JsonProvider {

  Future<List<User>> fetchUsers() async {
    var uri = "https://assessment-users-backend.herokuapp.com/users.json";
    var response = await http.get(Uri.parse(uri));
    List<User> userList = (jsonDecode(response.body) as List)
        .map((f) => User.fromJson(f))
        .toList();
    return userList;
  }

  Future<List<User>> deleteUser(int id) async {
    var uri = "https://assessment-users-backend.herokuapp.com/users";
    Response res = await http.delete(Uri.parse("$uri/$id"));
    var uri2 = "https://assessment-users-backend.herokuapp.com/users.json";
    var response = await http.get(Uri.parse(uri2));
    List<User> userList = (jsonDecode(response.body) as List)
        .map((f) => User.fromJson(f))
        .toList();
    return userList;
  }

  Future createUser(String firstName, String lastName) async {
    var uri = "https://assessment-users-backend.herokuapp.com/users";
    return http.post(Uri.parse(uri), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode({'first_name': firstName,'last_name': lastName,})).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        return "Error while fetching data $statusCode";
      }
      return "User Created Successfully";
    });
  }

  Future<String> updateUser(String firstName, String lastName, int id) async {
    var uri = "https://assessment-users-backend.herokuapp.com/users/$id";
    var body = jsonEncode(
        {"first_name": firstName, "last_name": lastName, "status": "active"});

    http.Response response = await http.put(Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    return response.statusCode.toString();
  }
}
