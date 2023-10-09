import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/PLOwnerUI/RegistrationFeeScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/WaitingApprovalScreen.dart';
import 'package:fe_capstone/ui/helper/ConfirmDialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class RegisterParking extends StatefulWidget {
  const RegisterParking({Key? key}) : super(key: key);

  @override
  State<RegisterParking> createState() => _RegisterParkingState();
}

class _RegisterParkingState extends State<RegisterParking> {
  bool isCheckOne = false;
  bool isCheckTwo = false;
  bool canSubmit = false;
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeET9OkThGxXQWnPrfXR_2NY45Xn1cqtKJwXhtNx2bjjW8rM8fUwW-ChoZM-3FyzI0MmQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeET9OkThGxXQWnPrfXR_2NY45Xn1cqtKJwXhtNx2bjjW8rM8fUwW-ChoZM-3FyzI0MmQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeET9OkThGxXQWnPrfXR_2NY45Xn1cqtKJwXhtNx2bjjW8rM8fUwW-ChoZM-3FyzI0MmQ&usqp=CAU"
  ];
  String? _image;

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
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
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
                    fontSize: 16 * fem,
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
                  style: TextStyle(
                    fontSize: 16 * ffem,
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
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.bold,
                        )),
                    Text('Huỳnh Bá Quốc',
                        style: TextStyle(
                          fontSize: 16 * fem,
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
                      fontSize: 16 * fem,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                height: 60 * fem,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var imageUrl in images)
                      InkWell(
                        onTap: () {
                          _showConfirmDeleteImageDialog(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5 * fem),
                          child: Container(
                            width: 100 * fem,
                            height: 60 * fem,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
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
                      fontSize: 16 * fem,
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
                  style: TextStyle(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.175 * ffem / fem,
                    color: Color(0xff9e9e9e),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập chiều rộng',
                  ),
                  onChanged: (newValue) {
                    // Xử lý khi giá trị thay đổi
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Text('Chiều dài(m):',
                    style: TextStyle(
                      fontSize: 16 * fem,
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
                  style: TextStyle(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.175 * ffem / fem,
                    color: Color(0xff9e9e9e),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập chiều dài',
                  ),
                  onChanged: (newValue) {
                    // Xử lý khi giá trị thay đổi
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Text('Số slot xe (chỗ):',
                    style: TextStyle(
                      fontSize: 16 * fem,
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
                  style: TextStyle(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.175 * ffem / fem,
                    color: Color(0xff9e9e9e),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập số chỗ',
                  ),
                  onChanged: (newValue) {
                    // Xử lý khi giá trị thay đổi
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Text('Địa chỉ:',
                    style: TextStyle(
                      fontSize: 16 * fem,
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
                  style: TextStyle(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.175 * ffem / fem,
                    color: Color(0xff9e9e9e),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập địa chỉ',
                  ),
                  onChanged: (newValue) {
                    // Xử lý khi giá trị thay đổi
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * fem, vertical: 15 * fem),
                child: Text('Mô tả (không bắt buộc):',
                    style: TextStyle(
                      fontSize: 16 * fem,
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
                  style: TextStyle(
                    fontSize: 16 * ffem,
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
                      fontSize: 16 * fem,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.white, // Màu của checkbox khi được chọn
                    checkColor: Colors.black, // Màu của dấu tích
                    value: isCheckOne,
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckOne = value ?? false;
                        _updateCheckboxState();
                      });
                    },
                  ),
                  const Text('Có camera')
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
                  const Text('Có phòng cháy chữa cháy')
                ],
              ),
              InkWell(
                onTap: canSubmit
                    ? () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationFeeScreen()));
                          }
                    : null,
                child: Container(
                  padding: EdgeInsets.all(8 * fem),
                  margin: EdgeInsets.fromLTRB(
                      20 * fem, 30 * fem, 20 * fem, 0 * fem),
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
                        fontSize: 19 * ffem,
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
                          final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
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
                            final XFile? image =
                            await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
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
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeET9OkThGxXQWnPrfXR_2NY45Xn1cqtKJwXhtNx2bjjW8rM8fUwW-ChoZM-3FyzI0MmQ&usqp=CAU',
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
