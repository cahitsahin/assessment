
import 'package:flutteruser/data/repository.dart';
import 'package:flutteruser/models/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {

  UserBloc(){
    fetchUsers();
  }

  final _users = BehaviorSubject<List<User>>();
  final Repository _repository=Repository();



  //Get Data
  Stream<List<User>> get user => _users.stream;

  //Set Data
  Function(List<User>) get changeUser => _users.sink.add;

  dispose(){
    _users.close();
  }

  fetchUsers() => _repository.fetchUsers().then((users) => changeUser(users));
  createUsers(String firstName,String lastName ) => _repository.createUser(firstName, lastName);
  updateUsers(String firstName,String lastName,int id, bool status) => _repository.updateUsers(firstName, lastName, id,status);
  deleteUsers(int id) => _repository.deleteUsers(id).then((users) => changeUser(users));

}
