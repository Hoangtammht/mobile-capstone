import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/PLOwnerUI/WaitingApprovalScreen.dart';
import 'package:fe_capstone/ui/helper/ConfirmDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationFeeScreen extends StatefulWidget {
  const RegistrationFeeScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationFeeScreen> createState() => _RegistrationFeeScreenState();
}

class _RegistrationFeeScreenState extends State<RegistrationFeeScreen> {
  String? _image;

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
          'Phí đăng ký',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30 * fem),
                child: Center(
                  child: Text(
                    '315.000 VNĐ',
                    style: TextStyle(fontSize: 30 * fem, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20 * fem),
                child: Text('Thông tin chuyển khoản:', style: TextStyle(
                  fontSize: 18 * fem,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15 * fem, top: 10 * fem, bottom: 10 * fem),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Bank: TP Bank - ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18 * fem
                                  )
                              ),
                              TextSpan(
                                  text: 'Ngân hàng Thương mại Cổ phần Tiên Phong',
                                  style: TextStyle(
                                    fontSize: 18 * fem,
                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15 * fem, top: 10 * fem, bottom: 10 * fem),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Số tài khoản: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18 * fem
                                  )
                              ),
                              TextSpan(
                                  text: '0909091209102',
                                  style: TextStyle(
                                    fontSize: 18 * fem,
                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10 * fem),
                child: Text(
                  'Hình ảnh giao dịch:',
                  style: TextStyle(fontSize: 18 * fem, fontWeight: FontWeight.w700),
                ),
              ),
              _image != null
                  ? InkWell(
                      onTap: () {
                        _showConfirmDeleteImageDialog(context);
                      },
                      child: Container(
                        height: 350 * fem,
                        width: 200 * fem,
                        child: Image.file(
                          File(_image!),
                          width: mq.height * .2,
                          height: mq.height * .2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: 50 * fem,
                      height: 50 * fem,
                      child: InkWell(
                        onTap: () {
                          _showBottomSheet();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/addImage.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

              Padding(
                padding: EdgeInsets.only(top: 40 * fem, bottom: 20 * fem),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Điều khoản hợp đồng: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18 * fem
                                  )
                              ),
                              TextSpan(
                                  text: 'Trong hợp đồng',
                                  style: TextStyle(
                                    fontSize: 18 * fem,
                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30 * fem),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Lưu ý: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18 * fem
                                  )
                              ),
                              TextSpan(
                                  text: 'Phí đăng kí sẽ được trừ vào tiền hợp đồng',
                                  style: TextStyle(
                                    fontSize: 18 * fem,
                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: _image != null
                    ? () {
                  CustomDialogs.showCustomDialog(
                    context,
                    "Gửi yêu cầu đăng ký bãi xe",
                    "Gửi",
                    Color(0xffff3737),
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WaitingApprovalScreen()),
                      );
                    },
                  );
                }
                    : null,
                child: Container(
                  margin:
                  EdgeInsets.fromLTRB(10 * fem, 0 * fem, 10 * fem, 10 * fem),
                  height: 50 * fem,
                  decoration: BoxDecoration(
                    color: _image != null
                        ? Theme.of(context)
                        .primaryColor // Màu nền khi có thể submit
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(9 * fem),
                  ),
                  child: Center(
                    child: Text(
                      'Gửi phiếu đăng kí',
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
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 80);
                          if (image != null) {
                            print(
                                'Image Path: ${image.path} -- MimeType: ${image.mimeType}');
                            setState(() {
                              _image = image.path;
                            });
                            //APIs image parking
                            Navigator.pop(context);
                          }
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
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.camera, imageQuality: 80);
                            if (image != null) {
                              print('Image Path: ${image.path}');
                              setState(() {
                                _image = image.path;
                              });
                              //APIs image parking
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

  Future<void> _showConfirmDeleteImageDialog(BuildContext context) async {
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
                    child: Image.file(
                      File(_image!),
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
                            color: Color(0xffb3abab), // Đường thẳng ngang
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
                              setState(() {
                                _image =
                                    null;
                              });
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
