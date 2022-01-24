

import 'package:flutteruser/models/user.dart';
import 'json_provider.dart';

class Repository {
  final JsonProvider jsonProvider=JsonProvider();

  Future<List<User>> fetchUsers() async => await jsonProvider.fetchUsers();
  Future<String> updateUsers(String firstName,String lastName,int id,bool status) async =>  await jsonProvider.updateUser(firstName, lastName, id);
  Future<List<User>> deleteUsers(int id) async =>  await jsonProvider.deleteUser(id);
  Future<String> createUser(String firstName,String lastName) async =>  await jsonProvider.createUser(firstName, lastName);

}