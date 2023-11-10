import 'dart:convert';
import 'dart:io';

import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/constant/base_constant.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ReservationDetail.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CheckOutByLicensePlate extends StatefulWidget {
  final void Function() updateUI;

  const CheckOutByLicensePlate({Key? key, required this.updateUI})
      : super(key: key);

  @override
  State<CheckOutByLicensePlate> createState() => _ScanLicensePlateState();
}

class _ScanLicensePlateState extends State<CheckOutByLicensePlate> {
  bool textScanning = false;
  bool status = false;
  XFile? imageFile;

  String scannedText = "";
  late Future<ReservationByLicensePlate> reservationByLicensePlate;

  WebSocketChannel channel = IOWebSocketChannel.connect(
      BaseConstants.WEBSOCKET_PRIVATE_RESERVATION_URL);
  late int reservationIDByScan;

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
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Kiểm tra biển số xe',
          style: TextStyle(
            fontSize: 30 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: const Color(0xffffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 40 * fem),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null)
                  Container(
                    padding: EdgeInsets.only(left: 20 * fem, right: 20 * fem),
                    // Đặt padding cho phía bên trái và phải là 20
                    child: Image.file(File(imageFile!.path)),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10 * fem),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
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
                               const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (status)
                      FutureBuilder(
                        future: reservationByLicensePlate,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            ReservationByLicensePlate data = snapshot.data!;
                            reservationIDByScan = data.reservationID;
                            final checkStatus = data.status;
                            print('status : $checkStatus');
                            if (checkStatus == 0) {
                              return Container(
                                width: 300 * fem,
                                height: 100 * fem,
                                margin: EdgeInsets.only(top: 30 * fem),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 25 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.175 * ffem / fem,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    children: <TextSpan>[
                                     const TextSpan(
                                        text: 'Biển số ',
                                      ),
                                      TextSpan(
                                        text: scannedText,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                     const TextSpan(
                                        text: ' không có trong giao dịch nào',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              List<String> parts;
                              String hours = '';
                              String date = '';
                              if (data.checkIn != "") {
                                parts = data.checkIn.split(' - ');
                                hours = parts[0];
                                date = parts[1];
                              }

                              return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 35 * fem),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(data.licensePlate,
                                              style: TextStyle(
                                                  fontSize: 35 * fem)),
                                        ],
                                      ),
                                   const SizedBox(height: 10.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Tên: ',
                                              style: TextStyle(
                                                  fontSize: 25 * fem,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          Text(data.customerName,
                                              style: TextStyle(
                                                  fontSize: 25 * fem)),
                                        ],
                                      ),
                                     const SizedBox(height: 10.0),
                                      if (checkStatus == 2 || checkStatus == 3)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Giờ xe vào: ',
                                                style: TextStyle(
                                                    fontSize: 25 * fem,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                            Text(hours,
                                                style: TextStyle(
                                                    fontSize: 25 * fem)),
                                          ],
                                        ),
                                     const SizedBox(height: 10.0),
                                      if (checkStatus == 2 || checkStatus == 3)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Ngày xe vào: ',
                                                style: TextStyle(
                                                    fontSize: 25 * fem,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                            Text(date,
                                                style: TextStyle(
                                                    fontSize: 25 * fem)),
                                          ],
                                        ),
                                     const SizedBox(height: 10.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Phương thức gửi:',
                                              style: TextStyle(
                                                  fontSize: 25 * fem,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          Container(
                                            width: 110 * fem,
                                            height: 30 * fem,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffe4f6e6),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      3 * fem),
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                data.methodName,
                                                style: TextStyle(
                                                  fontSize: 25 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2175 * ffem / fem,
                                                  color: const Color(0xff2b7031),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (checkStatus == 3)
                                        Column(
                                          children: [
                                          const  SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: Text(
                                                  'Khách hàng đã lấy trễ giờ',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 20 * fem,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ],
                                        ),
                                      if (checkStatus == 1)
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin:
                                                   const EdgeInsets.only(top: 40.0),
                                                width: 150 * fem,
                                                height: 42 * fem,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  // Màu nền là màu trắng
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9 * fem),
                                                  border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor, // Màu viền là màu nền hiện tại
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(0x82000000),
                                                      offset: Offset(
                                                          0 * fem, 4 * fem),
                                                      blurRadius: 10 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      textScanning = false;
                                                      status = false;
                                                      scannedText = '';
                                                      imageFile = null;
                                                    });
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      'Hủy',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 25 * ffem,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height:
                                                            1.175 * ffem / fem,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20 * fem,
                                              ),
                                              Container(
                                                margin:
                                                   const EdgeInsets.only(top: 40.0),
                                                height: 42 * fem,
                                                width: 150 * fem,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9 * fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(0x82000000),
                                                      offset: Offset(
                                                          0 * fem, 4 * fem),
                                                      blurRadius: 10 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    _showUpdateVehicleEntryDialog(
                                                        context, scannedText);
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      'Xe tới',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 25 * ffem,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height:
                                                            1.175 * ffem / fem,
                                                        color:
                                                           const Color(0xffffffff),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      if (checkStatus == 2 || checkStatus == 3)
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin:
                                                   const EdgeInsets.only(top: 40.0),
                                                width: 150 * fem,
                                                height: 42 * fem,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  // Màu nền là màu trắng
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9 * fem),
                                                  border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor, // Màu viền là màu nền hiện tại
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(0x82000000),
                                                      offset: Offset(
                                                          0 * fem, 4 * fem),
                                                      blurRadius: 10 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      textScanning = false;
                                                      status = false;
                                                      scannedText = '';
                                                      imageFile = null;
                                                    });
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      'Hủy',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 25 * ffem,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height:
                                                            1.175 * ffem / fem,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20 * fem,
                                              ),
                                              Container(
                                                margin:
                                                  const  EdgeInsets.only(top: 40.0),
                                                width: 150 * fem,
                                                height: 42 * fem,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9 * fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(0x82000000),
                                                      offset: Offset(
                                                          0 * fem, 4 * fem),
                                                      blurRadius: 10 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    _showUpdateVehicleExitDialog(
                                                        context, checkStatus, data.customerID);
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      'Xe ra',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 25 * ffem,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height:
                                                            1.175 * ffem / fem,
                                                        color:
                                                            Color(0xffffffff),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      SizedBox(
                                        height: 20 * fem,
                                      ),
                                    ],
                                  ));
                            }
                          }
                        },
                      )
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

  void resultGetReservationByLicensePlate(String scannedText) async {
    setState(() {
      this.scannedText = scannedText;
      textScanning = false;
      reservationByLicensePlate = _getReservationFuture(scannedText);
      status = true;
    });
  }

  Future<ReservationByLicensePlate> _getReservationFuture(
      String licensePlate) async {
    return ParkingAPI.getReservationByLicensePlate(licensePlate);
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String scannedText = recognizedText.text;
    scannedText = scannedText.replaceAll(RegExp(r"\s+"), "");
    textRecognizer.close();
    resultGetReservationByLicensePlate(scannedText);
  }

  Future<void> _showUpdateVehicleEntryDialog(
      BuildContext context, String licensePlate) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child:

          Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Center(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: const Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: 'Cập nhập trạng thái',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        TextSpan(
                            text: ' vào bãi',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))
                      ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                //

                Center(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      licensePlate,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: const Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff5767f5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 1,
                          height: 48,
                          color: const Color(0xffb3abab),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: const Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                await ParkingAPI
                                    .checkinReservationWithLicensePlate(
                                        scannedText);
                                widget.updateUI();
                                final message = {
                                  "reservationID":
                                      reservationIDByScan.toString(),
                                  "content": "GetStatus"
                                };
                                final messageJson = jsonEncode(message);
                                channel.sink.add(messageJson);
                                ScaffoldMessenger.of(context).showSnackBar(
                                const  SnackBar(
                                    content: Text('Check-in thành công'),
                                  ),
                                );
                                setState(() {
                                  imageFile = null;
                                  scannedText = "";
                                  status = false;
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Việc check-in thất bại'),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Xác nhận',
                              style:  TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffff3737),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showUpdateVehicleExitDialog(
      BuildContext context, int checkStatus, String customerID) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: const Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: 'Cập nhập trạng thái',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22)),
                        TextSpan(
                            text: ' rời bãi',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 22))
                      ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      scannedText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (checkStatus == 3)
                  const Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: '*Lưu ý: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                          text:
                              'Biển số xe này đã rời bãi trễ giờ. Phải đóng phí phạt',
                          style: TextStyle(
                            fontSize: 18,
                          ))
                    ]),
                    textAlign: TextAlign.center,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: const Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff5767f5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 1,
                          height: 48,
                          color: const Color(0xffb3abab),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: const Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                await ParkingAPI
                                        .checkoutReservationWithLicensePlate(
                                            scannedText)
                                    .then((_) async {
                                      await FirebaseAPI.deleteUser(customerID).then((_){
                                        widget.updateUI();
                                        final message = {
                                          "reservationID":
                                          reservationIDByScan.toString(),
                                          "content": "GetStatus"
                                        };
                                        final messageJson = jsonEncode(message);
                                        channel.sink.add(messageJson);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                         const SnackBar(
                                            content: Text('Check-out thành công'),
                                          ),
                                        );
                                        setState(() {
                                          imageFile = null;
                                          scannedText = "";
                                          status = false;
                                        });
                                      });

                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                    content: Text('Việc check-out thất bại'),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Xác nhận',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffff3737),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
