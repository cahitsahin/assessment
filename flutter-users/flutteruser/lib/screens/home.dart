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
      appBar: AppBar(),
      body: FutureBuilder<List<User>>(
      future: bloc.fetchUsers(),
      builder: (context, result) {
        if (result.hasData){
          users = result.data;
          users!.sort((b,a) => a.createdAt.compareTo(b.createdAt));
          return ListView.builder(
          itemCount: users!.length,
          itemBuilder: (context, index) {
            DateTime time = DateTime.parse(result.data?[index].createdAt ?? "");
            String formattedDate = DateFormat('yyyy-MM-dd, kk:mm:ss').format(time);
            String name = result.data?[index].firstName  ?? "" ;
            String surName = result.data?[index].lastName  ?? "" ;
            String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
            name = capitalize(name);
            surName = capitalize(surName);
            return Card(
              child: ListTile(
                title: Row(
                  children: [
                    Text(name),
                    const SizedBox(width: 10,),
                    Text(surName,style: TextStyle(color: Colors.grey[600]),)
                  ],
                ),
                leading: const CircleAvatar(child: Icon(Icons.account_circle),),
                subtitle: Text(formattedDate),
                trailing: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    _showPopupMenu(details.globalPosition);
                  },
                  child: const Icon(Icons.settings),
                ),
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

  void _showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,

      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        const PopupMenuItem<String>(
            child:  Icon(Icons.edit),),
        const PopupMenuItem<String>(
            child:  Icon(Icons.delete,color: Colors.redAccent,)),
      ],
      elevation: 8.0,
    );
  }

}