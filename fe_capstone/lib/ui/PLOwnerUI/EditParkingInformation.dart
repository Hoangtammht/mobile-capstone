import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ParkingInformationModel.dart';
import 'package:fe_capstone/ui/helper/ConfirmDialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ParkingInformation.dart';

class EditParkingInformation extends StatefulWidget {
  const EditParkingInformation({Key? key}) : super(key: key);

  @override
  State<EditParkingInformation> createState() => _EditParkingInformationState();
}

class _EditParkingInformationState extends State<EditParkingInformation> {

  List<String> images = [
  ];

  late Future<ParkingInformationModel> parkingInformationFuture;
  TextEditingController _parkingNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _slotController = TextEditingController();

  String token = "";

  @override
  void initState() {
    super.initState();
    parkingInformationFuture = _getParkingInformationFuture();
    parkingInformationFuture.then((data) {
      _parkingNameController.text = data?.parkingName ?? '';
      _descriptionController.text = data?.description ?? '';
      _slotController.text = data?.slot.toString() ?? '0';
      images = data.image.map((imageObject) => imageObject.imageLink).toList();
    });
  }

  Future<ParkingInformationModel> _getParkingInformationFuture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    if (accessToken != null) {
      setState(() {
        token = accessToken;
      });
      return ParkingAPI.getParkingInformation(token);
    } else {
      throw Exception("Access token not found");
    }
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
          'CHỈNH SỬA',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical: 15 * fem),
        child: FutureBuilder<ParkingInformationModel>(
          future: parkingInformationFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60 * fem,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var imageUrl in images.asMap().entries)
                          InkWell(
                            onTap: () {
                              _showConfirmDeleteImageDialog(context, imageUrl.key, imageUrl.value);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5 * fem),
                              child: Container(
                                width: 100 * fem,
                                height: 60 * fem,
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl.value,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        InkWell(
                          onTap: () {
                            _showBottomSheet();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 50 * fem,
                              height: 50 * fem,
                              child: Image.asset(
                                'assets/images/addImage.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10 * fem, vertical: 10 * fem),
                    child: Container(
                      margin:
                      EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 5 * fem),
                      child: Text(
                        'Tên bãi',
                        style: TextStyle(
                          fontSize: 19 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10 * fem, vertical: 5 * fem),
                    child: Container(
                      padding:
                      EdgeInsets.fromLTRB(18 * fem, 0 * fem, 18 * fem, 0 * fem),
                      width: 361 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child: TextFormField(
                        controller: _parkingNameController,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff9e9e9e),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10 * fem, vertical: 10 * fem),
                    child: Container(
                      margin:
                      EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 0 * fem),
                      child: Text(
                        'Mô tả',
                        style: TextStyle(
                          fontSize: 19 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10 * fem, vertical: 15 * fem),
                    child: Container(
                      padding:
                      EdgeInsets.fromLTRB(18 * fem, 0 * fem, 18 * fem, 0 * fem),
                      width: 361 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child: TextFormField(
                        controller: _descriptionController,
                        minLines: 1,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff9e9e9e),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10 * fem, vertical: 15 * fem),
                    child: Container(
                      margin:
                      EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 5 * fem),
                      child: Text(
                        'Số chỗ:',
                        style: TextStyle(
                          fontSize: 19 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10 * fem, vertical: 15 * fem),
                    child: Container(
                      padding:
                      EdgeInsets.fromLTRB(18 * fem, 0 * fem, 18 * fem, 0 * fem),
                      width: 361 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child: TextFormField(
                        controller: _slotController,
                        minLines: 1,
                        maxLines: null,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff9e9e9e),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30 * fem,
                  ),
                  InkWell(
                    onTap: () {
                      String newParkingName = _parkingNameController.text;
                      String description = _descriptionController.text;
                      int slot = int.parse(_slotController.text);
                      print(slot);

                      CustomDialogs.showCustomDialog(
                        context,
                        "Thay đổi thông tin bãi xe",
                        "Xác nhận",
                        Color(0xffff3737),
                            () async {
                              try {
                                await ParkingAPI.updateParkingInformation(token, description, images, newParkingName);
                              } catch (e) {
                                print("Error: $e");
                              }
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ParkingInformation()));
                        },
                      );
                    },
                    child: Container(
                      margin:
                      EdgeInsets.fromLTRB(10 * fem, 0 * fem, 10 * fem, 0 * fem),
                      height: 50 * fem,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontSize: 19 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.175 * ffem / fem,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        context: context,
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: fem * 3, bottom: fem * 5),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    150 * fem, 10 * fem, 150 * fem, 20 * fem),
                child: Container(
                  width: 25 * fem,
                  height: 3 * fem,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(25 * fem)),
                  ),
                ),
              ),
              Text(
                'Lựa chọn tải ảnh',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(15 * fem, 0, 15 * fem, 10 * fem),
                    child: Container(
                      width: double.infinity,
                      height: fem * 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final List<XFile> imageFiles =
                          await picker.pickMultiImage(imageQuality: 70);
                          for (var i in imageFiles) {
                            String? image = await ParkingAPI.uploadFile(File(i.path!));
                            setState(() {
                              images.add(image!);
                            });
                          }
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/images/file.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(15 * fem, 0, 15 * fem, 4 * fem),
                    child: Container(
                      width: double.infinity,
                      height: fem * 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize: Size(fem * 3, fem * 3),
                          ),
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? imageFile =
                            await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
                            if (imageFile != null) {
                              String? image = await ParkingAPI.uploadFile(File(imageFile.path!));
                              setState(() {
                                images.add(image!);
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Image.asset('assets/images/camera.png')),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  Future<void> _showConfirmDeleteImageDialog(BuildContext context, int index, String imgLink) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30 * fem, top: 20 * fem),
                    child: const Text(
                      "Xóa ảnh dưới đây",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 25 * fem),
                  child: Container(
                    width: 100 * fem,
                    height: 60 * fem,
                    child: Image.network(
                      imgLink,
                      fit: BoxFit.cover,
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
                            color: Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
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
                          color: Color(0xffb3abab),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                                images.removeAt(index);
                                Navigator.of(context).pop();
                            },
                            child: Text(
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
