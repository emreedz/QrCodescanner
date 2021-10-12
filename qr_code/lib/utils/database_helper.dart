import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/barkod_liste.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String? _barcodeTablo = "barcode";
  String? _columnID = 'id';
  String? _columnBarcode = "b_name";
  String? _columnDate = "date";

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper =
          DatabaseHelper._internal(); //databaseHelper oluşturulacak
      return _databaseHelper!;
    } else {
      return _databaseHelper!; //dbhelper var var olan kullanılacak
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await initializeDatabese(); //Database oluşturulacak
      return _database!;
    } else {
      return _database!; //db var var olan kullanılacak
    }
  }

  initializeDatabese() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String dbPath = join(klasor.path, "bark_createDb");

    var barcodeDB = openDatabase(dbPath, version: 1, onCreate: _createDb);
    return barcodeDB;
  }

  Future<void> _createDb(Database db, int version) async {
    db.execute(
        'CREATE TABLE $_barcodeTablo($_columnID INTEGER PRIMARY KEY AUTOINCREMENT,$_columnBarcode TEXT, $_columnDate TEXT)');
  }

  Future<int> barcodeEkle(Barkodlar barkod) async {
    var db = await _getDatabase();
    var sonuc = await db.insert(_barcodeTablo, barkod.dbYazmak());
    debugPrint("Barkod eklendi" + sonuc.toString());
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> tumBarkodlar() async {
    var db = await _getDatabase();
    var sonuc = db.query(_barcodeTablo, orderBy: '$_columnID DESC');
    return sonuc;
  }

  // Future<List<Map>> tumBarkodlar() async {
  //   var db = await _getDatabase();
  //   List<Map> sonuc = db.rawQuery();
  //   sonuc.forEach((element) { });
  //   return sonuc;
  // }

  Future<int?> barcodeSil(String barcode) async {
    var db = await _getDatabase();
    int sonuc = await db.delete(_barcodeTablo,
        where: '$_columnBarcode=?', whereArgs: [barcode]);
    return sonuc;
  }

//   Future<List<Map<String, dynamic>>?> BarkodChart(String start_date, String end_date) async {
//     var db = await _getDatabase();
//     db.query("'SELECT COUNT($_columnBarcode), $_columnDate FROM $_barcodeTablo where $_columnDate` BETWEEN '{$start_date}' AND '{$end_date}'");
//   }
// }

  Future<List<Barkodlar>> BarkodChart(String start_date, String end_date) async {
    List<Barkodlar> barkodList=[];
    var db = await _getDatabase();
    var result = await db.rawQuery(
        "SELECT * FROM $_barcodeTablo where $_columnDate >= '$end_date' and   $_columnDate <= '$start_date' ");
      result.forEach((value) {
        barkodList.add(Barkodlar.dbdenOkumak(value));
      }
    );
    return barkodList;


  }
}
