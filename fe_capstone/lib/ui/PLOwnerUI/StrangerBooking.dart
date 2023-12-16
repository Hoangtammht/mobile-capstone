import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/apis/customer/ReservationAPI.dart';
import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/base_constant.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ReservationDetail.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StrangerBooking extends StatefulWidget {
  final void Function() updateUI;
  final String? scannedText;
  final XFile? imageFile;
  final void Function()? updateCheckCamUI;
  const StrangerBooking({Key? key, required this.updateUI, this.scannedText, this.imageFile, this.updateCheckCamUI}) : super(key: key);

  @override
  State<StrangerBooking> createState() => _ScanLicensePlateState();
}

class _ScanLicensePlateState extends State<StrangerBooking> {
  int currentStep = 0;
  bool textScanningStep1 = false;
  bool statusStep1 = false;
  XFile? imageFileStep1;

  String? image;
  bool textScanningStep2 = false;
  bool statusStep2 = false;
  XFile? imageFileStep2;
  String scannedTextStep2 = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      print('tEST ${widget.scannedText}');
        if(widget.scannedText != null){
          imageFileStep2 = widget.imageFile;
          scannedTextStep2 = widget.scannedText!;
        }
    });
  }
 void UpdateCheckCam(){
   if(widget.scannedText != null){
     widget.updateCheckCamUI!();
   }
 }
  void Update() {
    widget.updateUI();
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
              UpdateCheckCam();
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Tạo giao dịch mới',
            style: TextStyle(
              fontSize: 30 * ffem,
              fontWeight: FontWeight.w700,
              height: 1.175 * ffem / fem,
              color: const Color(0xffffffff),
            ),
          ),
        ),
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue:
                  (currentStep == 1 && imageFileStep2 == null)
              ? null
              : () async {
                  final isLastStep = currentStep == getSteps().length - 1;
                  if (isLastStep) {
                    _showCreateBookingDialog(context);
                  } else {
                    if(imageFileStep1 == null){
                      setState(() {
                        currentStep +=1;
                        image = 'NoImageFile';
                      });
                    } else {
                      String? imageLink = await ParkingAPI.uploadFile(
                          File(imageFileStep1!.path));
                      setState(() {
                        currentStep +=1;
                        image = imageLink;
                      });
                    }
                  }
                },
          onStepTapped: (step) => setState(() => currentStep = step),
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: Text('Quay lại'),
                    onPressed: details.onStepCancel,
                  )),
                  const SizedBox(width: 12),
                  Expanded(
                      child: ElevatedButton(
                    child: Text(currentStep == 0 ? 'Bỏ qua' : 'Tiếp tục'),
                    onPressed: details.onStepContinue,
                  )),
                ],
              ),
            );
          },
        ));
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Khách hàng'),
          content: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(top: 10 * fem),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // if (textScanning) const CircularProgressIndicator(),
                    if (!textScanningStep1 && imageFileStep1 == null)
                      Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey[300]!,
                      ),
                    if (imageFileStep1 != null)
                      Container(
                        padding:
                            EdgeInsets.only(left: 20 * fem, right: 20 * fem),
                        // Đặt padding cho phía bên trái và phải là 20
                        child: Image.file(File(imageFileStep1!.path)),
                      ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text('Chụp hình khách hàng và xe' ,style: TextStyle(fontSize:  25, fontWeight: FontWeight.bold),),
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
                                          fontSize: 22,
                                          color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                )),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: Text('Biển số'),
          content: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(top: 10 * fem),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    if (!textScanningStep2 && imageFileStep2 == null)
                      Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey[300]!,
                      ),
                    if (imageFileStep2 != null)
                      Container(
                        padding:
                            EdgeInsets.only(left: 20 * fem, right: 20 * fem),

                        child: Image.file(File(imageFileStep2!.path)),
                      ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text('Chụp hình biển số' ,style: TextStyle(fontSize:  25, fontWeight: FontWeight.bold),),
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
                                          fontSize: 22,
                                          color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                    if (scannedTextStep2.length > 0)
                      const SizedBox(
                        height: 30,
                      ),
                    if (scannedTextStep2.length > 0)
                      Center(
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
                                text: scannedTextStep2,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                )),
          ),
        )
      ];

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        if (currentStep == 0) {
          textScanningStep1 = true;
          imageFileStep1 = pickedImage;
          setState(() {});
          getRecognisedText(pickedImage);
        } else {
          textScanningStep2 = true;
          imageFileStep2 = pickedImage;
          setState(() {});
          getRecognisedText(pickedImage);
        }
      }
    } catch (e) {
      if (currentStep == 0) {
        textScanningStep1 = false;
        imageFileStep1 = null;
        setState(() {});
      } else {
        textScanningStep2 = false;
        imageFileStep2 = null;
        scannedTextStep2 = "Error occured while scanning";
        setState(() {});
      }
    }
  }

  void resultGetReservationByLicensePlate(String scannedText) async {
    setState(() {
      if (currentStep == 0) {
        textScanningStep1 = false;
        statusStep1 = true;
      } else {
       scannedTextStep2 = scannedText;
        textScanningStep2 = false;
        statusStep2 = true;
      }
    });
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

  Future<void> _showCreateBookingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: const Center(
                          child: Text('Xác nhận tạo giao dịch mới?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          scannedTextStep2,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
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
                              await ReservationAPI.getBookingForStranger(
                                  image!,
                                  scannedTextStep2)
                                  .then((value) async {
                                if (value == 1) {

                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Tạo giao dịch mới thành công'),
                                    ),
                                  );
                                  setState(() {
                                    imageFileStep1 = null;
                                    imageFileStep2 = null;
                                    scannedTextStep2 = "";
                                    statusStep1 = false;
                                    statusStep2 = false;
                                    currentStep = 0;
                                  });
                                  widget.updateUI();
                                } else {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Bãi xe hiện tại đã hết chỗ rồi, không thể nhập thêm nữa!'),
                                    ),
                                  );
                                }
                              });
                            } catch (e) {
                              if (e is DioException) {
                                if (e.response != null &&
                                    e.response!.statusCode == 500) {
                                  final errorResponse = e.response!;
                                  final errorData = errorResponse.data;
                                  if (errorData is Map<String, dynamic> &&
                                      errorData.containsKey('message')) {
                                    final errorMessage = errorData['message'];
                                    print("Lỗi gặp phải là $errorMessage");
                                    if (errorMessage.contains(
                                        'Current slot is invalid')) {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Bãi xe hiện tại đã hết chỗ, xin vui lòng đặt nơi khác!'),
                                        ),
                                      );
                                    }
                                  } else {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Tạo giao dịch mới thất bại'),
                                      ),
                                    );
                                  }
                                }
                              }

                            }
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
        );
      },
    );
  }
}
