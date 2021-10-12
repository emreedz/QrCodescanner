import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_app/data/userlar.dart';
import 'package:todo_app/splash_screen.dart';
import 'package:todo_app/todo_users.dart';
import 'package:http/http.dart' as http;

import 'kullanıcı_arayüz.dart';

void main() {
  runApp(MyApp());
}

class MyRoute extends MaterialPageRoute {
  MyRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => Duration(seconds: 2);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String? username;
  late String password;
  bool flag = false;

  final _formKey = GlobalKey<FormState>();

  Future<List<Users>?> getData() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((tooDoo) => Users.fromJson(tooDoo))
          .toList();
    } else {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey.shade100,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment(0.1, -0.5),
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dst),
                image: AssetImage("assets/giriss.png"))),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    /*Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        child: Text("To do Sayfası için tıkla"), onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>ToDoSayfa()));
                    }),
                  ),*/
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8, left: 8, top: 10),
                      child: TextFormField(
                          initialValue: 'Sincere@april.biz',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Kullanıcı Adı Giriniz";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (Value) {
                            username = Value!;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              labelText: "Kullanıcı Adı",
                              hintText: "Kullanıcı Adını Giriniz",
                              hintStyle: TextStyle(color: Colors.black),
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8, left: 8, top: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Sifre Giriniz";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (Value) {
                          password = Value!;
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            labelText: "Şifre ",
                            hintText: "Şifre Giriniz",
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    //  Container(
                    //   child: ElevatedButton(
                    //       child: Text("User Sayfası için tıkla"),
                    //       onPressed: () {
                    //         Navigator.of(context).push(MaterialPageRoute(
                    //             builder: (context) => ToDoUsers()));
                    //       }),
                    // ),
                    Container(
                      child: ElevatedButton(
                          child: Text("Kullanıcı Giriş "),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              var users = await getData();
                              users!.forEach((value) {
                                if (username == value.email &&
                                    password == value.name) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => KullaniciArayuz(
                                        user: value,
                                      ),
                                    ),
                                  );
                                } else {
                                  if (!flag) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Kullanıcı Adı veya Şifre yanlış"),
                                      ),
                                    );
                                  }
                                  flag = true;
                                }
                              });
                            }
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
