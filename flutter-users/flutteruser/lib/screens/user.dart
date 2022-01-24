import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteruser/blocs/user_provider.dart';
import 'package:flutteruser/data/repository.dart';
import 'package:flutteruser/models/user.dart';
import 'home.dart';

class UserPage extends StatefulWidget implements HomePage  {
  final User user;

  const UserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final Repository rep = Repository();
    final formKey = GlobalKey<FormState>();
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    bool status = widget.user.status;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Icon(
                Icons.account_circle,
                size: 160,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: firstNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Enter first name',
                    labelText: 'First Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: lastNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Enter last name',
                    labelText: 'Last Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Status :  "),
                    SizedBox(
                      width: 10,
                    ),
                    Text(widget.user.status ? "Active" : "Locked"),
                    SizedBox(
                      width: 10,
                    ),
                    Checkbox(
                      checkColor: Colors.greenAccent,
                      activeColor: Colors.red,
                      value: status,
                      onChanged: (bool? value) {
                        setState(() {
                          status = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    widget.user.id == -1
                        ? await rep.createUser(
                            firstNameController.text, lastNameController.text)
                        : await rep.updateUsers(
                            firstNameController.text,
                            lastNameController.text,
                            widget.user.id,
                            status);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  },
                  child: widget.user.id == -1
                      ? const Text('Create')
                      : const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: widget.user.id == -1
            ? const Text('New User')
            : const Text('User Details'),
      ),
    );
  }
}
