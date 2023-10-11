import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';

class ReBooking extends StatelessWidget {
  final String title;
  const ReBooking({Key? key, required this.title}) : super(key: key);

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
          '${title}',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15 * fem, 26 * fem, 14 * fem, 0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25 * fem),
              padding: EdgeInsets.symmetric(horizontal: 8 * fem),
              width: 358 * fem,
              height: 350 * fem,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16 * fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16 * fem, 30 * fem, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Phí gửi xe',
                          style: TextStyle(
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5b5b5b),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '6.000đ',
                          style: TextStyle(
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16 * fem, 25 * fem, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Trạng thái',
                          style: TextStyle(
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5b5b5b),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width:  60* fem,
                          height: 20 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xfff5e4e4),
                            borderRadius: BorderRadius.circular(100 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Rời bãi',
                              style: TextStyle(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffcc5252),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16 * fem, 15 * fem, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Bãi đỗ',
                          style: TextStyle(
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5b5b5b),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Khách sạn Romantic',
                          style: TextStyle(
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16 * fem, 21 * fem, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Phương thức',
                          style: TextStyle(
                            fontSize: 13 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.175 * ffem / fem,
                            color: Color(0xff5b5b5b),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Ban ngày',
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.2175 * ffem / fem,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16 * fem, 15 * fem, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Phương tiện',
                          style: TextStyle(
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5b5b5b),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '45A-12345',
                          style: TextStyle(
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15 * fem, 10 * fem, 0, 0),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Địa chỉ: ',
                                      style: TextStyle(
                                          fontSize: 18 * fem
                                      )
                                  ),
                                  TextSpan(
                                      text: '681A Đ. Nguyễn Huệ, Bến Nghé, Quận 1, TP HCM',
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        fontWeight: FontWeight.bold,
                                      )
                                  )
                                ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20 * fem),
              width: double.infinity,
              height: 51 * fem,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(9 * fem),
              ),
              child: Center(
                child: Text(
                  'Đặt lại',
                  style: TextStyle(
                    fontSize: 19 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.175 * ffem / fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

