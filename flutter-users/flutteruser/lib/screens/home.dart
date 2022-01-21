import 'package:flutter/material.dart';
import 'package:flutteruser/blocs/user_provider.dart';
import 'package:flutteruser/models/user.dart';
import 'package:flutteruser/screens/user.dart';
import 'package:intl/intl.dart';

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
        appBar: AppBar(
          title: const Text("Users"),
          leading: IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              User tempUser = User(-1, "", "", "", true, "", "");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserPage(
                            user: tempUser,
                          )));
            },
          ),
        ),
        body: FutureBuilder<List<User>>(
          future: bloc.fetchUsers(),
          builder: (context, result) {
            if (result.hasData) {
              users = result.data;
              users!.sort((b, a) => a.createdAt.compareTo(b.createdAt));
              return ListView.builder(
                itemCount: users!.length,
                itemBuilder: (context, index) {
                  DateTime time =
                      DateTime.parse(result.data?[index].createdAt ?? "");
                  String formattedDate =
                      DateFormat('yyyy-MM-dd, kk:mm:ss').format(time);
                  String name = result.data?[index].firstName ?? "";
                  String surName = result.data?[index].lastName ?? "";
                  String capitalize(String s) =>
                      s[0].toUpperCase() + s.substring(1);
                  name = capitalize(name);
                  surName = capitalize(surName);
                  return Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(name),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            surName,
                            style: TextStyle(color: Colors.grey[600]),
                          )
                        ],
                      ),
                      leading: const CircleAvatar(
                        child: Icon(Icons.account_circle),
                      ),
                      subtitle: Text(formattedDate),
                      trailing: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          bloc.deleteUser(result.data![index].id);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserPage(
                                      user: result.data![index],
                                    )));
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
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
