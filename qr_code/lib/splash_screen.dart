import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Anasayfa())));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.blueGrey.shade100),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 40,
                          child: Icon(
                            Icons.downloading,
                            color: Colors.white,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          "Sisteme Girişi",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text("Sistem Verileri Yükleniyor Lütfen Bekleyin."),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
