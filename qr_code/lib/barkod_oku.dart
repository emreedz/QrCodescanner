import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:todo_app/entity/my_barcode.dart';
import 'package:todo_app/kullan%C4%B1c%C4%B1_aray%C3%BCz.dart';
import 'package:todo_app/models/barkod_liste.dart';
import 'package:todo_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

import 'list.dart';


class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  //List<String> bcode = [];
  //List<DateTime> date = [];
  List<MyBarcode> myBarcodes = [];
  //DateTime now= DateTime.now();
  String? selectedBarcode;
  String? writeBarcode;
  DatabaseHelper db1 = DatabaseHelper();

  // String todayDate(DateTime time) {
  //   var formatter = DateFormat('dd/MM/yyyy HH:mm');
  //   return formatter.format(time);
  // }

  TextEditingController? textEditingController = TextEditingController();

  Color colorr = Colors.transparent;
  @override
  void initState() {
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Container(
            // flex: 1,
            child: Column(
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Lütfen Barkod Numarasını Giriniz"),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)))),
                                  controller: textEditingController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Barkod Gir";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (valuee) {
                                    writeBarcode = valuee;
                                  },
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    writeBarcode = textEditingController!.text;
                                   // bcode.insert(0, writeBarcode.toString());
                                   //  date.insert(0, DateTime.now());
                                    myBarcodes.insert(0,MyBarcode(writeBarcode.toString(), DateTime.now().toString()));
                                    db1.barcodeEkle(Barkodlar(writeBarcode.toString(), DateTime.now().day.toString()));
                                    Navigator.pop(context);
                                  },
                                  child: Text("Onayla ")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("İptal"))
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Kod Girmek İçin Tıkla",
                      style: TextStyle(color: Colors.black),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return Text('Flash: ${snapshot.data}');
                            },
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Text(
                                    'Ön Kamera İçin Dokun');
                              } else {
                                return Text('loading');
                              }
                            },
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: myBarcodes.length,
              shrinkWrap: false,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Card(
                    color: selectedBarcode == myBarcodes[i].barcode ? colorr : Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ListTile(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Barcod Silinsin mi"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            myBarcodes.removeAt(i);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text("Sil")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Vazgeç"))
                                  ],
                                );
                              },
                            );
                            setState(() {});
                          },
                          onTap: () {
                            setState(() {
                              colorr = Colors.green.shade500;
                              selectedBarcode = myBarcodes[i].barcode;
                       //       db1.barcodeEkle(Barkodlar(bcode[i], date[i]));
                              dbdenVeriGetir();
                            });
                          },
                          title: Text("Okunan Barkod: "),
                          subtitle: Text("${myBarcodes[i].day}"),
                          trailing: Text("${myBarcodes[i].barcode}"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    child: ListTile(
                  title: Text("Barkod Okutuldu "),
                  leading: Container(
                    child: Text(
                      myBarcodes.length.toString(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                ))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BarcodeList()));
                    },
                    child: Text("Devam Et"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade300),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>KullaniciArayuz()));
                    },
                    child: Text("Geri"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 280.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        var contain = myBarcodes.map((e) => e.barcode).toList().where((element) => element == result!.code);
        if (contain.isEmpty) {
          //bcode.insert(0, result!.code);
          //date.insert(0, DateTime.now());
          myBarcodes.insert(0,MyBarcode(result!.code, DateTime.now().toString()));
          db1.barcodeEkle(Barkodlar(result!.code, DateTime.now().day.toString()));
        } else {
          return;
        }
        /*if(karsikod==result!.code){
          return;
        }else{
          bcode.add(result!.code);
        }*/
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void dbdenVeriGetir() async {
    var sonuc = await db1.tumBarkodlar();
    debugPrint(sonuc.toString());
  }

}
