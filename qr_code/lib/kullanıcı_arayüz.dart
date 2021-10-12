import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/barkod_oku.dart';
import 'package:todo_app/list.dart';
import 'package:todo_app/main.dart';
import 'data/userlar.dart';
import 'enum.dart';

class KullaniciArayuz extends StatefulWidget {
  final Users? user;

  const KullaniciArayuz({Key? key, this.user}) : super(key: key);

  @override
  _KullaniciArayuzState createState() => _KullaniciArayuzState(user);
}

class _KullaniciArayuzState extends State<KullaniciArayuz> {
  final Users? user;
  String isim="Emre Deniz";
  String mail="emre@gmail";
  _KullaniciArayuzState(this.user);

  Future<List<Users>?>? getDataa(String username) async {
    var response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/users?username=" +
            username.toString()));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => Users.fromJson(e))
          .toList();
    } else {
      CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        isim.toString(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      GestureDetector(
                        child: Text(
                          mail.toString(),
                          style: TextStyle(
                              fontSize: 14, color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset(
                            "assets/exit.png",
                            width: 60,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.blueGrey.shade600,
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BarcodeList()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/barkodlist.jpg",
                            width: 130,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("BarkodListesi",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.blueGrey.shade600,
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QRViewExample()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/barkod.jpg",
                            width: 110,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("Barkod Okuma",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 40,
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.blueGrey.shade600,
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChartsScreen()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/liste.png",
                            width: 90,
                            height: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("Hafta Liste",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.blueGrey.shade600,
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () {
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/mapp.jpg",
                            width: 130,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("Harita",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
