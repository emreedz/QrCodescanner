import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:todo_app/models/barkod_liste.dart';
import 'package:todo_app/utils/database_helper.dart';

class EarningsTimeline {
  List<String> day = [];
  int earning;

  EarningsTimeline({
    required this.day,
    required this.earning,
  });
}

class ChartsScreen extends StatefulWidget {
  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  DatabaseHelper? _databaseHelper;
  List<Barkodlar>? BarkodListesi;

  @override
  void initState() {
    super.initState();
    barkodGun();
  }


  barkodGun() {
    _databaseHelper = DatabaseHelper();
    _databaseHelper!
        .BarkodChart(simdi.toString(), once.toString())
        .then((BarkodlariTutanBolum) {
      var test = BarkodlariTutanBolum.where((element) => element.date == '27');
      debugPrint(test.length.toString());
      return test;
    });
  }

  var simdi = DateTime.now().day;
  var once = DateTime.now().add(new Duration(days: -6)).day;

  @override
  Widget build(BuildContext context) {
    final List<EarningsTimeline> listEarnings = [
      EarningsTimeline(day: ["${simdi - 3}"], earning: 5),
      EarningsTimeline(day: ["${simdi- 2}"], earning: 8),
      EarningsTimeline(day: ["${simdi - 1}"], earning: 9),
      EarningsTimeline(day: ["${simdi}"], earning: 15),
      EarningsTimeline(day: ["${simdi + 1}"], earning: 6),
      EarningsTimeline(day: ["${simdi + 2}"], earning: 5),
      EarningsTimeline(day: ["${simdi + 3}"], earning: 8),
    ];
    List<charts.Series<EarningsTimeline, String>> timeline = [
      charts.Series(
        id: "Subscribers",
        data: listEarnings,
        domainFn: (EarningsTimeline timeline, _) => timeline.day[0],
        measureFn: (EarningsTimeline timeline, _) => timeline.earning,
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Flutter Charts Sample")),
      body: Center(
          child: Container(
        height: 400,
        padding: EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Günlere Göre Barkod Sayısı ",
                ),
                Expanded(
                  child: charts.BarChart(timeline, animate: true),
                ),
                Text(
                  "GÜNLER",
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
