import 'package:fe_capstone/apis/customer/HistoryAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/HistoryDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Rebooking extends StatefulWidget {
  final int reservationId;
  final VoidCallback? onNavigateToHomeScreen;

  Rebooking({required this.reservationId, this.onNavigateToHomeScreen});

  @override
  State<Rebooking> createState() => _RebookingState();
}

class _RebookingState extends State<Rebooking> {
  late Future<HistoryDetail> historyDetail;
  late String parkingName = '';

  @override
  void initState() {
    super.initState();
    final parameterValue = widget.reservationId;
    historyDetail = _fetchHistoryDetailData(parameterValue);
    historyDetail.then((data) {
      setState(() {
        parkingName = data.parkingName;
      });
    });
  }

  Future<HistoryDetail> _fetchHistoryDetailData(int reservationId) async {
    return HistoryAPI.getHistoryDetail(reservationId);
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
          parkingName,
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(14 * fem, 26 * fem, 14 * fem, 0),
        width: double.infinity,
        child: FutureBuilder<HistoryDetail>(
          future: historyDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            } else {
              final historyDetail = snapshot.data;
              Color statusColor;
              if (historyDetail?.statusName == 'Historical') {
                statusColor = Colors.green;
              } else {
                statusColor = Colors.red;
              }
              if (historyDetail == null) {
                return Center(child: Text('Không có dữ liệu'));
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25 * fem),
                      padding: EdgeInsets.symmetric(horizontal: 8 * fem),
                      width: mq.width,
                      height: 500 * fem,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16 * fem),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(16 * fem, 30 * fem, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Phí gửi xe',
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? 'Đang tải...'
                                      : (historyDetail != null
                                          ? '${NumberFormat("#,##0", "vi_VN").format(historyDetail.totalPrice)} đ'
                                          : '${NumberFormat("#,##0", "vi_VN").format(0.0)} đ'),
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(16 * fem, 25 * fem, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Trạng thái',
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 90 * fem,
                                  height: 20 * fem,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                  ),
                                  child: Center(
                                    child: Text(
                                      snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? 'Đang tải...'
                                          : () {
                                              if (historyDetail.statusName == 'Historical') {
                                                return 'Hoàn thành';
                                              } else {
                                                return 'Hủy đặt';
                                              }
                                            }(),
                                      style: TextStyle(
                                        fontSize: 22 * ffem,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
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
                            padding:
                                EdgeInsets.fromLTRB(16 * fem, 15 * fem, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Bãi đỗ',
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  historyDetail.parkingName,
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(16 * fem, 21 * fem, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Phương thức',
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.175 * ffem / fem,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  historyDetail.methodName,
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
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
                            padding:
                                EdgeInsets.fromLTRB(16 * fem, 15 * fem, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Phương tiện',
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  historyDetail.licensePlate,
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(16 * fem, 15 * fem, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${historyDetail.statusName.contains('Cancel') ? 'Thời gian đặt' : 'Thời gian vào bãi'}',
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${historyDetail.statusName.contains('Cancel') ? historyDetail.startTime : historyDetail.checkIn}',
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(16 * fem, 15 * fem, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${historyDetail.statusName.contains('Cancel') ? 'Thời gian hủy' : 'Thời gian rời bãi'}',
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  historyDetail.checkOut,
                                  style: TextStyle(
                                    fontSize: 22 * ffem,
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
                            padding:
                                EdgeInsets.fromLTRB(15 * fem, 10 * fem, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Địa chỉ ',
                                    style: TextStyle(fontSize: 22 * fem)),
                                SizedBox(
                                  height: 30 * fem,
                                ),
                                Text(
                                  historyDetail.address,
                                  style: TextStyle(
                                    fontSize: 18 * fem,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // maxLines: 2,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     widget.onNavigateToHomeScreen?.call();
                    //   },
                    //   child: Container(
                    //     margin: EdgeInsets.only(top: 20 * fem),
                    //     width: double.infinity,
                    //     height: 51 * fem,
                    //     decoration: BoxDecoration(
                    //       color: Theme.of(context).primaryColor,
                    //       borderRadius: BorderRadius.circular(9 * fem),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         'Đặt lại',
                    //         style: TextStyle(
                    //           fontSize: 25 * ffem,
                    //           fontWeight: FontWeight.w600,
                    //           height: 1.175 * ffem / fem,
                    //           color: Color(0xffffffff),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
