import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todo_app/data/userlar.dart';
import 'package:todo_app/todolist.dart';

class ToDoUsers extends StatefulWidget {
  const ToDoUsers({Key? key}) : super(key: key);

  @override
  _ToDoUsersState createState() => _ToDoUsersState();
}

class _ToDoUsersState extends State<ToDoUsers> {
  Future<List<Users?>?> _toDoUsers() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    //id.toString()));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((tooDoo) => Users.fromJson(tooDoo))
          .toList();
    } else {
      throw Exception("aaa");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Listesi"),
      ),
      body: FutureBuilder(
          future: _toDoUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Users?>?>? snapshot) {
            if (snapshot!.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Users? user = snapshot.data![index]!;
                    return Container(
                      color: Colors.blueGrey,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ToDoSayfa(user: user)));
                        },
                        title: Text(user.name!),
                        subtitle: Text(user.username.toString()),
                        leading: CircleAvatar(child: Text(user.id.toString())),
                        trailing: Text(user.phone!),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
