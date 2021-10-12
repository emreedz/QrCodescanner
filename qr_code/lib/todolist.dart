import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todo_app/data/todolar.dart';
import 'package:todo_app/data/userlar.dart';


class ToDoSayfa extends StatefulWidget {
  final Users? user;
  const ToDoSayfa({Key? key, this.user}) : super(key: key);


  @override
  _ToDoSayfaState createState() => _ToDoSayfaState(user);
}

class _ToDoSayfaState extends State<ToDoSayfa> {
  final Users? user;
  _ToDoSayfaState(this.user);

  Future<List<TodoVeri>?>? _tobirDo(int? userId) async {

    String uri= "https://jsonplaceholder.typicode.com/todos?userId=" +  userId.toString();
    print("REQUEST URI :"+ uri);
    var responses = await http.get(Uri.parse(uri));


    if (responses.statusCode == 200) {
      return (json.decode(responses.body) as List)
          .map((tooDoo) => TodoVeri.fromJson(tooDoo))
          .toList();
    } else {
      throw Exception("aaa");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(user!.name.toString() + " - " +user!.username.toString()),
        ),
        body: FutureBuilder(
            future: _tobirDo(user!.id),
            builder: (BuildContext context,
                AsyncSnapshot<List<TodoVeri?>?>? snapshot) {
              if (snapshot!.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Ink(
                        padding: EdgeInsets.all(12),
                        color: Colors.blueGrey.shade800,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade700,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          margin: EdgeInsets.all(7),
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: ExpansionTile(
                            trailing:  Icon(Icons.date_range),
                            leading: CircleAvatar(
                              child: Text(
                                  snapshot.data![index]!.userId!.toString()),
                            ),
                            title: Text(snapshot.data![index]!.title!,style: getStyle(snapshot.data![index]!.completed),),
                            children: [
                              Container(
                                color: index % 2 == 0
                                    ? Colors.teal.shade400
                                    : Colors.redAccent.shade400,
                                height: 100,
                                width: double.infinity,
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

 TextStyle getStyle(bool? completed) {
    if(completed!) {
     return TextStyle(decoration: TextDecoration.lineThrough);
    }else{
     return TextStyle();
    }
  }
}
