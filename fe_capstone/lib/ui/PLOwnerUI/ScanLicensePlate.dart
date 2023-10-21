import 'dart:io';

import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanLicensePlate extends StatefulWidget {
  final void Function() updateUI;
  const ScanLicensePlate({Key? key, required this.updateUI}) : super(key: key);

  @override
  State<ScanLicensePlate> createState() => _ScanLicensePlateState();
}

class _ScanLicensePlateState extends State<ScanLicensePlate> {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'KIỂM TRA BIỂN SỐ XE',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top :40 * fem),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10 * fem),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 30,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10 * fem),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    scannedText,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 42 * fem,
                      width: 80 * fem,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(9 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x82000000),
                            offset: Offset(0 * fem, 4 * fem),
                            blurRadius: 10 * fem,
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String? accessToken = prefs.getString('access_token');
                          if (accessToken != null) {
                            try {
                              await ParkingAPI.checkinReservationWithLicensePlate(
                                  accessToken, scannedText);
                              widget.updateUI();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Check-in thành công'),
                                ),
                              );
                              setState(() {
                                imageFile = null;
                                scannedText = "";
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Có lỗi xảy ra khi thực hiện check-in'),
                                ),
                              );
                            }
                          }
                        },
                        child: Center(
                          child: Text(
                            'Xe vào',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.175 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 80 * fem,
                      height: 42 * fem,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(9 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x82000000),
                            offset: Offset(0 * fem, 4 * fem),
                            blurRadius: 10 * fem,
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String? accessToken = prefs.getString('access_token');
                          if (accessToken != null) {
                            try {
                              await ParkingAPI.checkoutReservationWithLicensePlate(
                                  accessToken, scannedText);
                              widget.updateUI();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Check-out thành công'),
                                ),
                              );
                              setState(() {
                                imageFile = null;
                                scannedText = "";
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Có lỗi xảy ra khi thực hiện check-out'),
                                ),
                              );
                            }
                          }
                        },
                        child: Center(
                          child: Text(
                            'Xe ra',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.175 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );

}

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    String scannedText = recognizedText.text;
    scannedText = scannedText.replaceAll(RegExp(r"\s+"), "");
    textRecognizer.close();
    setState(() {
      this.scannedText = scannedText;
      textScanning = false;
    });
  }}
