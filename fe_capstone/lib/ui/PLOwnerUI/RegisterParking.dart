import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/RequestResgisterParking.dart';
import 'package:fe_capstone/ui/PLOwnerUI/RegistrationFeeScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class RegisterParking extends StatefulWidget {
  const RegisterParking({Key? key}) : super(key: key);

  @override
  State<RegisterParking> createState() => _RegisterParkingState();
}

class _RegisterParkingState extends State<RegisterParking> {
  bool isCheckOne = false;
  bool isCheckTwo = false;
  bool canSubmit = false;
  String userName = '';
  List<String> images = [];
  String address = '';
  double lat = 0.0;
  double long = 0.0;
  bool showMapPicker = false;

  String? _image;
  TextEditingController _parkingNameController = TextEditingController();
  TextEditingController _widthController = TextEditingController();
  TextEditingController _lenthController = TextEditingController();
  TextEditingController _slotController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void _updateCheckboxState() {
    setState(() {
      if (isCheckOne && isCheckTwo) {
        canSubmit = true;
      } else {
        canSubmit = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  void getName() async {
    String? name = await UserPreferences.getFullName();

    if (userName != null) {
      setState(() {
        userName = name!;
      });
    }
  }

  String formatAddress(Map<String, dynamic> addressData) {
    List<String> components = [];

    if (addressData.containsKey('amenity')) {
      components.add(addressData['amenity']);
    }
    if (addressData.containsKey('house_number')) {
      components.add(addressData['house_number']);
    }
    if (addressData.containsKey('road')) {
      components.add(addressData['road']);
    }
    if (addressData.containsKey('suburb')) {
      components.add(addressData['suburb']);
    }
    if (addressData.containsKey('city')) {
      components.add(addressData['city']);
    }

    String formattedAddress = components.join(', ');

    return formattedAddress.isNotEmpty ? formattedAddress : 'Không có địa chỉ';
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
          'Đăng ký bãi đỗ',
          style: TextStyle(
            fontSize: 30 * ffem,
            fontWeight: FontWeight.w700,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical: 15 * fem),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5 * fem),
                child: Text(
                  'Tên bãi đỗ',
                  style: TextStyle(
                    fontSize: 22 * fem,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(18 * fem, 0 * fem, 18 * fem, 0 * fem),
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(9 * fem),
                ),
                child: TextFormField(
                  minLines: 1,
                  maxLines: null,
                  controller: _parkingNameController,
                  style: TextStyle(
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.175 * ffem / fem,
                    color: Color(0xff9e9e9e),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tên bãi đỗ',
                  ),
                  onChanged: (newValue) {
                    // Xử lý khi giá trị thay đổi
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Người đăng ký: ',
                        style: TextStyle(
                          fontSize: 22 * fem,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(userName,
                        style: TextStyle(
                          fontSize: 22 * fem,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Text('Hình ảnh:',
                    style: TextStyle(
                      fontSize: 22 * fem,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                height: 60 * fem,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var imageUrl in images.asMap().entries)
                      InkWell(
                        onTap: () {
                          _showConfirmDeleteImageDialog(
                              context, imageUrl.key, imageUrl.value);
                        },
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 5 * fem),
                          child: Container(
                            width: 100 * fem,
                            height: 60 * fem,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl.value,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Text('Chiều rộng(m):',
                    style: TextStyle(
                      fontSize: 22 * fem,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(18 * fem, 0 * fem, 18 * fem, 0 * fem),
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(9 * fem),
                ),
                child: TextFormField(
                  minLines: 1,
                  maxLines: null,
                  controller: _widthController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.175 * ffem / fem,
                    color: Color(0xff9e9e9e),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập chiều rộng',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Text('Chiều dài(m):',
                    style: TextStyle(
                      fontSize: 22 * fem,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(18 * fem, 0 * fem, 18 * fem, 0 * fem),
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(9 * fem),
                ),
                child: TextFormField(
                  minLines: 1,
                  maxLines: null,
                  controller: _lenthController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.175 * ffem / fem,
                    color: Color(0xff9e9e9e),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập chiều dài',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Text('Sức chứa của bãi xe:',
                    style: TextStyle(
                      fontSize: 22 * fem,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(18 * fem, 0 * fem, 18 * fem, 0 * fem),
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(9 * fem),
                ),
                child: TextFormField(
                  minLines: 1,
                  maxLines: null,
                  controller: _slotController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.175 * ffem / fem,
                    color: Color(0xff9e9e9e),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập số chỗ',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5 * fem, vertical: 15 * fem),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ:',
                      style: TextStyle(
                        fontSize: 22 * fem,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing between the texts
                    Flexible(
                      child: Text(
                        address,
                        style: TextStyle(
                          fontSize: 20 * fem,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showMapPicker = !showMapPicker;
                  });
                },
                child: Text(showMapPicker ? 'Đóng' : 'Chọn vị trí'),
              ),
              if (showMapPicker)
                SizedBox(
                  height: 500,
                  child: OpenStreetMapSearchAndPick(
                    center: LatLong(10.828813446468915, 106.62925166053212),
                    buttonColor: Colors.blue,
                    buttonText: 'Xác nhận',
                    onPicked: (pickedData) {
                      setState(() {
                        address = formatAddress(pickedData.address);
                        lat = pickedData.latLong.latitude;
                        long = pickedData.latLong.longitude;
                        showMapPicker = false;
                      });
                    },
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Text('Mô tả (không bắt buộc):',
                    style: TextStyle(
                      fontSize: 22 * fem,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(18 * fem, 0 * fem, 18 * fem, 0 * fem),
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(9 * fem),
                ),
                child: TextFormField(
                  minLines: 1,
                  maxLines: null,
                  controller: _descriptionController,
                  style: TextStyle(
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.175 * ffem / fem,
                    color: Color(0xff9e9e9e),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Mô tả',
                  ),
                  onChanged: (newValue) {
                    // Xử lý khi giá trị thay đổi
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Text('Điều kiện bắt buộc:',
                    style: TextStyle(
                      fontSize: 20 * fem,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    value: isCheckOne,
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckOne = value ?? false;
                        _updateCheckboxState();
                      });
                    },
                  ),
                   Text('Có camera', style: TextStyle(
                     fontSize: 20 * fem,
                   ),)
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    value: isCheckTwo,
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckTwo = value ?? false;
                        _updateCheckboxState();
                      });
                    },
                  ),
                  Text('Có phòng cháy chữa cháy', style: TextStyle(
                    fontSize: 20 * fem,
                  ),)
                ],
              ),
              InkWell(
                onTap: canSubmit
                    ? () {
                        String parkingName = _parkingNameController.text;
                        double length = double.parse(_lenthController.text);
                        double width = double.parse(_widthController.text);
                        int slot = int.parse(_slotController.text);
                        String description = _descriptionController.text;
                        RequestRegisterParking request = RequestRegisterParking(
                          address: address,
                          description: description,
                          images: images,
                          length: length,
                          parkingName: parkingName,
                          slot: slot,
                          latitude: lat,
                          longitude: long,
                          uuid: "",
                          width: width,
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationFeeScreen(requestRegisterParking: request,)));
                      }
                    : null,
                child: Container(
                  padding: EdgeInsets.all(8 * fem),
                  margin: EdgeInsets.fromLTRB(
                      20 * fem, 30 * fem, 20 * fem, 25 * fem),
                  height: 50 * fem,
                  decoration: BoxDecoration(
                    color: canSubmit
                        ? Theme.of(context)
                            .primaryColor // Màu nền khi có thể submit
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(9 * fem),
                  ),
                  child: Center(
                    child: Text(
                      'Tiếp tục',
                      style: TextStyle(
                        fontSize: 25 * ffem,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                      height: fem * 40, // Đặt chiều cao của nút
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final List<XFile> imageFiles =
                              await picker.pickMultiImage(imageQuality: 70);
                          for (var i in imageFiles) {
                            String? image =
                                await ParkingAPI.uploadFile(File(i.path!));
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
                            final XFile? imageFile = await picker.pickImage(
                                source: ImageSource.camera, imageQuality: 80);
                            if (imageFile != null) {
                              String? image = await ParkingAPI.uploadFile(
                                  File(imageFile.path!));
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
