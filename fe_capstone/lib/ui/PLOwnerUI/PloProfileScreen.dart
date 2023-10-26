import 'package:fe_capstone/apis/Auth.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/PloDetail.dart';
import 'package:fe_capstone/ui/screens/ChangePasswordScreen.dart';
import 'package:fe_capstone/ui/screens/EditProfileScreen.dart';
import 'package:fe_capstone/ui/PLOwnerUI/TransferParking.dart';
import 'package:fe_capstone/ui/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PloProfileScreen extends StatefulWidget {
  const PloProfileScreen({Key? key}) : super(key: key);

  @override
  State<PloProfileScreen> createState() => _PloProfileScreenState();
}

class _PloProfileScreenState extends State<PloProfileScreen> {
  late Future<PloProfile> ploProfileFuture;

  @override
  void initState() {
    super.initState();
    ploProfileFuture = _getPloProfileFuture();
  }

  Future<PloProfile> _getPloProfileFuture() async {
      return AuthAPIs.getPloProfile();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'TÀI KHOẢN',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 360,
              child: Stack(
                children: [
                  Positioned(
                    left: 0 * fem,
                    top: 0 * fem,
                    child: Container(
                      width: mq.width,
                      height: 120 * fem,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(23 * fem),
                          bottomLeft: Radius.circular(23 * fem),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10 * fem,
                    right: 10 * fem,
                    top: 30 * fem,
                    child: Container(
                      height: 250 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(26 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x1e000000),
                            offset: Offset(0 * fem, 0 * fem),
                            blurRadius: 25 * fem,
                          ),
                        ],
                      ),
                      child:  FutureBuilder<PloProfile>(
                        future: ploProfileFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final ploProfile = snapshot.data;
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 15 * fem),
                                  padding: EdgeInsets.symmetric(horizontal: 10* fem),
                                  height: 30 * fem,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              1.21 * fem, 4.63 * fem, 0 * fem),
                                          width: 21.75 * fem,
                                          height: 22.96 * fem,
                                          child: const Icon(Icons.person)),
                                      Text(
                                        'Thông tin cá nhân',
                                        style: TextStyle(
                                          fontSize: 26 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.175 * ffem / fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 15 * fem),
                                    padding: EdgeInsets.symmetric(horizontal: 10* fem),
                                    height: 20 * fem,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            'Họ và tên',
                                            style: TextStyle(
                                              fontSize: 22 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.175 * ffem / fem,
                                              color: Color(0xff5b5b5b),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : ploProfile?.fullName ?? '',
                                          style: TextStyle(
                                            fontSize: 22 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                Align(
                                  child: SizedBox(
                                    width: 390 * fem,
                                    height: 1.01 * fem,
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 15 * fem),
                                    padding: EdgeInsets.symmetric(horizontal: 10* fem),
                                    height: 20 * fem,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            'Số điện thoại',
                                            style: TextStyle(
                                              fontSize: 22 * ffem,
                                              fontWeight: FontWeight.bold,
                                              height: 1.175 * ffem / fem,
                                              color: Color(0xff5b5b5b),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : ploProfile?.phoneNumber ?? '',
                                          style: TextStyle(
                                            fontSize: 22 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                Align(
                                  child: SizedBox(
                                    width: 390 * fem,
                                    height: 1.01 * fem,
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 15 * fem),
                                  padding: EdgeInsets.symmetric(horizontal: 10* fem),
                                  height: 20 * fem,
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          'Email',
                                          style: TextStyle(
                                            fontSize: 22 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.175 * ffem / fem,
                                            color: Color(0xff5b5b5b),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : ploProfile?.email ?? '',
                                        style: TextStyle(
                                          fontSize: 22 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.175 * ffem / fem,
                                          color: Color(0xff000000),
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
                    ),
                  ),
                  Positioned(
                    left: 34 * fem,
                    right: 34 * fem,
                    top: 250 * fem,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                      child: Container(
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
                        child: Center(
                          child: Text(
                            'Chỉnh sửa',
                            style: TextStyle(
                              fontSize: 25 * ffem,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding:
                EdgeInsets.fromLTRB(14 * fem, 0, 14 * fem, 0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // InkWell(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => OwnershipHistoryScreen()));
                    //   },
                    //   child: Container(
                    //     margin:
                    //     EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 0 * fem),
                    //     width: 362 * fem,
                    //     height: 63 * fem,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: Color(0xffdcdada)),
                    //       color: Color(0xffffffff),
                    //       borderRadius: BorderRadius.circular(9 * fem),
                    //     ),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Padding(
                    //           padding: EdgeInsets.only(left: 10 * fem),
                    //           child: Icon(Icons.history),
                    //         ),
                    //         Padding(
                    //           padding: EdgeInsets.only(left: 10 * fem),
                    //           child: Text(
                    //             'Lịch sử bãi xe đã đăng kí',
                    //             style: TextStyle(
                    //               fontSize: 19 * ffem,
                    //               fontWeight: FontWeight.w600,
                    //               height: 1.175 * ffem / fem,
                    //               color: Color(0xff000000),
                    //             ),
                    //           ),
                    //         ),
                    //
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 84 * fem,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TransferParking()));
                      },
                      child: Container(
                        margin:
                        EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 0 * fem),
                        width: 362 * fem,
                        height: 63 * fem,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffdcdada)),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(9 * fem),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10 * fem),
                              child: Icon(Icons.swap_horiz_sharp),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10 * fem),
                              child: Text(
                                'Cập nhật số điện thoại',
                                style: TextStyle(
                                  fontSize: 25 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14 * fem,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                      },
                      child: Container(
                        margin:
                        EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 0 * fem),
                        width: 362 * fem,
                        height: 63 * fem,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffdcdada)),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(9 * fem),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10 * fem),
                              child: Icon(Icons.lock),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10 * fem),
                              child: Text(
                                'Thay đổi mật khẩu',
                                style: TextStyle(
                                  fontSize: 25 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 14 * fem,
                    ),
                    InkWell(
                      onTap: () async {
                        await UserPreferences.logout();
                        PersistentNavBarNavigator.pushNewScreen(context, screen: LoginScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.cupertino, );
                      },
                      child: Container(
                        margin:
                        EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 0 * fem),
                        width: 362 * fem,
                        height: 63 * fem,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffdcdada)),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(9 * fem),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10 * fem),
                              child: Icon(Icons.logout),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10 * fem),
                              child: Text(
                                'Đăng xuất',
                                style: TextStyle(
                                  fontSize: 25 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.175 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
