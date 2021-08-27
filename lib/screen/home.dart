import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String? scanResult;
bool checkLineUrl = false;
bool checkFacebookUrl = false;
bool checkYoutubeUrl = false;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRcode & Barcode'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Card(
            child: Column(
              children: [
                Text('ผลการแสกน', style: TextStyle(fontSize: 20.0)),
                Text(scanResult ??= "ยังไม่มีข้อมูล", style: TextStyle(fontSize: 18.0)),
                checkLineUrl
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (await canLaunch(scanResult!)) {
                                await launch(scanResult!);
                              }
                            },
                            child: Text('เปิดใน Line'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green, onPrimary: Colors.white)),
                      )
                    : new Container(),
                checkFacebookUrl
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (await canLaunch(scanResult!)) {
                                await launch(scanResult!);
                              }
                            },
                            child: Text('เปิดใน Facebook'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[900], onPrimary: Colors.white)),
                      )
                    : new Container(),
                checkYoutubeUrl
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (await canLaunch(scanResult!)) {
                                await launch(scanResult!);
                              }
                            },
                            child: Text('เปิดใน Youtube'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red[900], onPrimary: Colors.white)),
                      )
                    : new Container(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.qr_code_scanner),
        onPressed: startScan,
      ),
    );
  }

  startScan() async {
    //- ----------------- อ่านข้อมูลqrcode ------------------ //

    String? cameraScanResult = await scanner.scan();
    setState(() {
      checkLineUrl = false;
      checkFacebookUrl = false;
      checkYoutubeUrl = false;
      scanResult = cameraScanResult;
    });
    if (scanResult!.contains('line.me')) {
      checkLineUrl = true;
    } else if (scanResult!.contains('facebook.com')) {
      checkFacebookUrl = true;
    } else if (scanResult!.contains('youtube.com')) {
      checkYoutubeUrl = true;
    }
  }
}
