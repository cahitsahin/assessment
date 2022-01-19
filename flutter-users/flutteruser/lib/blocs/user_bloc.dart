import 'package:flutteruser/models/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc{

  final _contacts = BehaviorSubject<List<User>>();
  
  Stream<List<User>> get contacts => _contacts.stream;

  Function(List<User>) get changeContacts => _contacts.sink.add;

  dispose(){
    _contacts.close();
  }

}