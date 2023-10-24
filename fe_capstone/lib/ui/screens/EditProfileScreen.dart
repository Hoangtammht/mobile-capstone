import 'package:fe_capstone/apis/Auth.dart';
import 'package:fe_capstone/apis/plo/AuthAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/CustomerDetail.dart';
import 'package:fe_capstone/models/PloDetail.dart';
import 'package:fe_capstone/models/UpdateProfileRequest.dart';
import 'package:fe_capstone/ui/PLOwnerUI/PloProfileScreen.dart';
import 'package:fe_capstone/ui/helper/ConfirmDialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late Future<CustomerProfile> customerProfileFuture;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    customerProfileFuture = _getCustomerProfileFuture();
    customerProfileFuture.then((data) {
      _fullNameController.text = data?.fullName ?? '';
      _emailController.text = data?.email ?? '';
    });
  }

  Future<CustomerProfile> _getCustomerProfileFuture() async {
      return AuthAPIs.getCustomerProfile();
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
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(26 * fem),
          ),
          child: FutureBuilder<CustomerProfile>(
            future: customerProfileFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final ploProfile = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                      EdgeInsets.fromLTRB(15 * fem, 35 * fem, 0 * fem, 0 * fem),
                      child: Text(
                        'Họ và tên',
                        style: TextStyle(
                          fontSize: 19 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          14 * fem, 16 * fem, 14 * fem, 160 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                1 * fem, 0 * fem, 0 * fem, 16 * fem),
                            padding: EdgeInsets.fromLTRB(
                                18 * fem, 0 * fem, 18 * fem, 0 * fem),
                            width: 361 * fem,
                            decoration: BoxDecoration(
                              color: Color(0xfff5f5f5),
                              borderRadius: BorderRadius.circular(9 * fem),
                            ),
                            child: TextFormField(
                              controller: _fullNameController,
                              style: TextStyle(
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.175 * ffem / fem,
                                color: Color(0xff9e9e9e),
                              ),
                              decoration: InputDecoration(
                                border: InputBorder
                                    .none,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                1 * fem, 0 * fem, 0 * fem, 16 * fem),
                            child: Text(
                              'Số điện thoại',
                              style: TextStyle(
                                fontSize: 19 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.175 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                7 * fem, 0 * fem, 0 * fem, 15 * fem),
                            child: Text(
                              snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : ploProfile?.phoneNumber ?? '',
                              style: TextStyle(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.175 * ffem / fem,
                                color: Color(0xff9e9e9e),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                1 * fem, 0 * fem, 0 * fem, 16 * fem),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 19 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.175 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            padding: EdgeInsets.fromLTRB(
                                18 * fem, 0 * fem, 18 * fem, 0 * fem),
                            width: 361 * fem,
                            decoration: BoxDecoration(
                              color: Color(0xfff5f5f5),
                              borderRadius: BorderRadius.circular(9 * fem),
                            ),
                            child: TextFormField(
                              controller: _emailController,
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
                            InkWell(
                              onTap: () {
                                String newFullName = _fullNameController.text;
                                String newEmail = _emailController.text;
                                CustomDialogs.showCustomDialog(
                                  context,
                                  "Thay đổi thông tin cá nhân",
                                  "Xác nhận",
                                  Color(0xffff3737),
                                      () async {
                                        await AuthAPIs.updateProfile(UpdateProfileRequest(
                                          email: newEmail,
                                          fullName: newFullName,
                                        ));
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PloProfileScreen()), (route) => false);
                                    },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                height: 50 * fem,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(9 * fem),
                                ),
                                child: Center(
                                  child: Text(
                                    'Hoàn tất',
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
                  ],
                );
              }
            },
          ),
        ));
  }

}
