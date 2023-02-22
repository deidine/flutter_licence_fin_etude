import 'package:flutter/material.dart';
class User {
  const User(this.id,this.name);

  final String name;
  final int id;
}
class DropDawn extends StatefulWidget {
  const DropDawn({Key? key}) : super(key: key);

  @override
  State createState() => MyAppState();
}

class MyAppState extends State<DropDawn> {
  late User selectedUser;
  List<User> users = <User>[const User(1,'Item 1'), const User(2,'Item 2'), const User(3,'Item 3'),const User(4,'Item 4'),
    const User(5,'Item 6')];

  @override
  void initState() {
    selectedUser=users[0];
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Center(
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<User>(//dropdownColor: Colors.white38,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.blue, fontSize: 20),
                  value: selectedUser,
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectedUser = newValue!;
                    });
                  },
                  items: users.map((User user) {
                    return DropdownMenuItem<User>(
                      value: user,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Text(
                          user.name,

                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Text("selected user name is ${selectedUser.name} : and Id is : ${selectedUser.id}"),
          ],
        ),
      ),
    );
  }
}