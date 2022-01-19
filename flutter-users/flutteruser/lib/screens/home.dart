import 'package:flutter/material.dart';
import 'package:flutteruser/blocs/user_provider.dart';
import 'package:flutteruser/models/user.dart';
import 'package:flutteruser/screens/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bloc = UserProvider.of(context);
    List<User>? users;
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<User>>(
      future: bloc.fetchUsers(),
      builder: (context, result) {
        if (result.hasData){
          users = result.data;
          return ListView.builder(
          itemCount: users!.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(result.data?[index].firstName ?? "Blank"),
                leading: CircleAvatar(child: Icon(Icons.account_circle),),
                subtitle: Text(result.data?[index].lastName ?? "Blank"),
                trailing: Text(result.data?[index].id.toString() ?? "Blank"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserPage(
                                title: result.data?[index].firstName ?? "Blank",
                              )));
                },
              ),
            );
          },
        );
        }
        else return Center(child: CircularProgressIndicator());
        
      },
    ));
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final bloc = UserProvider.of(context);
      bloc.fetchUsers();
    });

    super.initState();
  }
}