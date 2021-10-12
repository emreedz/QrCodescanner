import 'package:flutter/material.dart';
import 'package:todo_app/entity/my_barcode.dart';
import 'package:todo_app/models/barkod_liste.dart';
import 'package:todo_app/utils/database_helper.dart';

import 'barkod_oku.dart';

class BarcodeList extends StatefulWidget {
  const BarcodeList({Key? key}) : super(key: key);

  @override
  _BarcodeListState createState() => _BarcodeListState();
}

class _BarcodeListState extends State<BarcodeList> {
  DatabaseHelper? _databaseHelper;
  List<Barkodlar>? allBarcodeList = [];
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    allBarcode();
  }

  allBarcode() async {
    _databaseHelper = DatabaseHelper();
    _databaseHelper!.tumBarkodlar().then((tumBarkodlariTutanMapListesi) {
      for (Map<String, dynamic> okunanBarcode in tumBarkodlariTutanMapListesi) {
        setState(() {
          allBarcodeList!.add(Barkodlar.dbdenOkumak(okunanBarcode));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Okunan Barkod Listesi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                shrinkWrap: true,
                itemCount: allBarcodeList!.length,
                itemBuilder: (context, index) {
                  Barkodlar barkod = allBarcodeList![index];
                  return Card(
                    child: ListTile(
                      trailing: GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: () {
                          barcodeSil(barkod.b_name.toString());
                        },
                      ),
                      title: Text(barkod.b_name.toString()),
                      subtitle: Text(barkod.date.toString()),
                    ),
                  );
                },
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(bottom: 30, right: 10),
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => QRViewExample()));
                    },
                    child: Image.asset(
                      'assets/giriss.png',
                      height: 50,
                    ),
                  ),
                  Text("Barkod sayfası için tıklayın")
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future barcodeSil(String barcode) async{
    var sonuc = await _databaseHelper!.barcodeSil(barcode);
    if (sonuc == 1) {
      scaffoldKey.currentState!.showSnackBar(SnackBar(
          duration: Duration(seconds: 2), content: Text("Kayıt Silindi")
      ));
      allBarcodeList!.clear();
      allBarcode();
    }
  }
}
