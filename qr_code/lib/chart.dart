// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:intl/intl.dart';
// import 'package:todo_app/enum.dart';
// import 'package:todo_app/models/barkod_liste.dart';
// import 'package:todo_app/utils/database_helper.dart';
//
// class BarChartSample2 extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => BarChartSample2State();
// }
//
//
// class BarChartSample2State extends State<BarChartSample2> {
//
//
//
//   DatabaseHelper? _databaseHelper;
//   List<Barkodlar>? BarkodListe;
//   List GunListe= [];
//
//    barkodGun(int barkodSayi){
//     _databaseHelper=DatabaseHelper();
//     _databaseHelper!.tumBarkodlar().then((tumBarkodlariTutanMapListesi) {
//       for (Map<String, dynamic> barkods in tumBarkodlariTutanMapListesi) {
//         setState(() {
//           BarkodListe!.add(Barkodlar.dbdenOkumak(barkods));
//         });
//       }
//     });
//   }
//
//
//   final Color leftBarColor = const Color(0xff53fdd7);
//   final double width = 7;
//
//   late List<BarChartGroupData> rawBarGroups;
//   late List<BarChartGroupData> showingBarGroups;
//
//   int touchedGroupIndex = -1;
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     final barGroup1 = makeGroupData(Day.MN.toString(), 5);
//     final barGroup2 = makeGroupData(Day.TS.toString(), 1);
//     final barGroup3 = makeGroupData(Day.WD.toString(), 3);
//     final barGroup4 = makeGroupData(Day.THS.toString(), 2);
//     final barGroup5 = makeGroupData(Day.FR.toString(), 9);
//     final barGroup6 = makeGroupData(Day.STD.toString(), 7);
//     final barGroup7 = makeGroupData(Day.SD.toString(), 10);
//
//     final items = [
//       barGroup1,
//       barGroup2,
//       barGroup3,
//       barGroup4,
//       barGroup5,
//       barGroup6,
//       barGroup7,
//     ];
//
//     rawBarGroups = items;
//
//     showingBarGroups = rawBarGroups;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Card(
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//         color: const Color(0xff2c4260),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   makeTransactionsIcon(),
//                   const SizedBox(
//                     width: 50,
//                   ),
//                   const Text(
//                     'Günlük Okunan',
//                     style: TextStyle(color: Colors.white, fontSize: 22),
//                   ),
//                   const SizedBox(
//                     width: 4,
//                   ),
//                   const Text(
//                     'Barkod',
//                     style: TextStyle(color: Color(0xff77839a), fontSize: 22),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 38,
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: BarChart(
//                     BarChartData(
//                       maxY: 25,
//                       barTouchData: BarTouchData(
//                           touchTooltipData: BarTouchTooltipData(
//                             tooltipBgColor: Colors.grey,
//                           ),
//                           touchCallback: (response) {
//                             if (response.spot == null) {
//                               setState(() {
//                                 touchedGroupIndex = -1;
//                                 showingBarGroups = List.of(rawBarGroups);
//                               });
//                               return;
//                             }
//                             touchedGroupIndex = response.spot!.touchedBarGroupIndex;
//                             // setState(() {
//                             //   if (response.touchInput is PointerExitEvent ||
//                             //       response.touchInput is PointerUpEvent) {
//                             //     touchedGroupIndex = -1;
//                             //     showingBarGroups = List.of(rawBarGroups);
//                             //   } else {
//                             //     showingBarGroups = List.of(rawBarGroups);
//                             //     if (touchedGroupIndex != -1) {
//                             //       var sum = 0.0;
//                             //       for (var rod in showingBarGroups[touchedGroupIndex].barRods) {
//                             //         sum += rod.y;
//                             //       }
//                             //       final avg =
//                             //           sum / showingBarGroups[touchedGroupIndex].barRods.length;
//                             //
//                             //       showingBarGroups[touchedGroupIndex] =
//                             //           showingBarGroups[touchedGroupIndex].copyWith(
//                             //             barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
//                             //               return rod.copyWith(y: avg);
//                             //             }).toList(),
//                             //           );
//                             //     }
//                             //   }
//                             // });
//                           }),
//                       titlesData: FlTitlesData(
//                         show: true,
//                         bottomTitles: SideTitles(
//                           showTitles: true,
//                           getTextStyles: (context, value) => const TextStyle(
//                               color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
//                           margin: 20,
//                           getTitles: (double value) {
//                             switch (value.toInt()) {
//                               case 0:
//                                 return 'Ptesi';
//                               case 1:
//                                 return 'Salı';
//                               case 2:
//                                 return 'Çrşm';
//                               case 3:
//                                 return 'Prşm';
//                               case 4:
//                                 return 'Cuma';
//                               case 5:
//                                 return 'Ctesi';
//                               case 6:
//                                 return 'Pazar';
//                               default:
//                                 return '';
//                             }
//                           },
//                         ),
//                         leftTitles: SideTitles(
//                           showTitles: true,
//                           getTextStyles: (context, value) => const TextStyle(
//                               color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
//                           margin: 32,
//                           reservedSize: 14,
//                           getTitles: (value) {
//                             if (value == 0) {
//                               return '0';
//                             } else if (value == 10) {
//                               return '10';
//                             } else if (value == 20) {
//                               return '20';
//                             } else {
//                               return '';
//                             }
//                           },
//                         ),
//                       ),
//                       borderData: FlBorderData(
//                         show: false,
//                       ),
//                       barGroups: showingBarGroups,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   BarChartGroupData makeGroupData(String x, double y1) {
//     return BarChartGroupData(barsSpace: 4, x:0, barRods: [
//       BarChartRodData(
//         y: y1,
//         colors: [leftBarColor],
//         width: width,
//       ),
//     ],);
//   }
//
//
//
//   Widget makeTransactionsIcon() {
//     const width = 4.5;
//     const space = 8.5;
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           width: width,
//           height: 10,
//           color: Colors.white.withOpacity(0.4),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 28,
//           color: Colors.white.withOpacity(0.8),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 42,
//           color: Colors.white.withOpacity(1),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 28,
//           color: Colors.white.withOpacity(0.8),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 10,
//           color: Colors.white.withOpacity(0.4),
//         ),
//       ],
//     );
//   }
// }
//
