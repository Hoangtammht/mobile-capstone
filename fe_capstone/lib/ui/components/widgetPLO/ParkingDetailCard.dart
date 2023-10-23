import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ReservationDetail.dart';
import 'package:fe_capstone/ui/helper/ConfirmDialog.dart';
import 'package:fe_capstone/ui/helper/my_date_until.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParkingDetailCard extends StatefulWidget {
  final List<String> type;
  final String licensePlate;
  final int reservationID;
  final void Function() updateUI;
  const ParkingDetailCard({Key? key, required this.type, required this.licensePlate, required this.reservationID, required this.updateUI}) : super(key: key);

  @override
  State<ParkingDetailCard> createState() => _ParkingDetailCardState();
}

class _ParkingDetailCardState extends State<ParkingDetailCard> {
  late Future<ReservationDetail> reservationDetailFuture;

  @override
  void initState() {
    super.initState();
    reservationDetailFuture = _getReservationDetailFuture();
  }

  Future<ReservationDetail> _getReservationDetailFuture() async {
      return ParkingAPI.getReservationDetail(widget.reservationID);
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
          widget.licensePlate,
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
        actions: [
          if (widget.type.contains('Later'))
            IconButton(
              onPressed: () {
                CustomDialogs.showCustomDialog(
                  context,
                  "Chủ xe sẽ nhận được thông báo khi bạn xóa xe khỏi bãi.",
                  "Xác nhận",
                  Color(0xffff3737),
                      () async {
                          int reservationID = widget.reservationID;
                          try {
                            await ParkingAPI.checkInReservation(reservationID);
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            widget.updateUI();
                          } catch (e) {}
                  },
                );
              },

              icon: Icon(Icons.delete),
            ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15 * fem, 26 * fem, 14 * fem, 0),
        width: double.infinity,
        child: FutureBuilder<ReservationDetail>(
          future: reservationDetailFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final reservationDetail = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(!widget.type.contains("History"))
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 5 * fem),
                      padding: EdgeInsets.fromLTRB(14 * fem, 14 * fem, 4 * fem, 10 * fem),
                      width: 120 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xffdcdada),
                        borderRadius: BorderRadius.circular(6 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20 * fem,
                            height: 20 * fem,
                            child: Icon(Icons.message),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8 * fem),
                            child: Text(
                              'Nhắn tin',
                              style: TextStyle(
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 25 * fem),
                    padding: EdgeInsets.fromLTRB(8 * fem, 0, 8 * fem, 16 * fem),
                    width: 358 * fem,
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
                                snapshot.connectionState == ConnectionState.waiting
                                    ? 'Đang tải...'
                                    : NumberFormat.compact(locale: "en").format(reservationDetail?.price) ?? '0.0',style: TextStyle(
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
                                    snapshot.connectionState == ConnectionState.waiting
                                        ? 'Đang tải...'
                                        : () {
                                      if (reservationDetail?.statusName == 'Checked In') {
                                        return 'Trong bãi';
                                      } else if (reservationDetail?.statusName == 'Occupied') {
                                        return 'Đang tới';
                                      } else if (reservationDetail?.statusName == 'Overdue') {
                                        return 'Trễ giờ';
                                      } else if (reservationDetail?.statusName == 'Historical') {
                                        return 'Đã rời';
                                      } else {
                                        return '';
                                      }
                                    }(),
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
                          padding: EdgeInsets.fromLTRB(16 * fem, 25 * fem, 0, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Khách hàng',
                                style: TextStyle(
                                  fontSize: 15 * ffem,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5b5b5b),
                                ),
                              ),
                              Spacer(),
                              Text(
                                snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : reservationDetail?.fullName ?? '',
                                style: TextStyle(
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
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
                                'Số điện thoại',
                                style: TextStyle(
                                  fontSize: 13 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.175 * ffem / fem,
                                  color: Color(0xff5b5b5b),
                                ),
                              ),
                              Spacer(),
                              Text(
                                snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : reservationDetail?.phoneNumber ?? '',
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
                                snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : reservationDetail?.licensePlate ?? '',
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
                          padding: EdgeInsets.fromLTRB(16 * fem, 21 * fem, 0, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Vào bãi',
                                style: TextStyle(
                                  fontSize: 15 * ffem,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5b5b5b),
                                ),
                              ),
                              Spacer(),
                              Text(
                                snapshot.connectionState == ConnectionState.waiting
                                    ? 'Đang tải...'
                                    : MyDateUtil.formatCheckInAndCheckOutDate(reservationDetail?.checkIn) ?? '',
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
                          padding: EdgeInsets.fromLTRB(16 * fem, 10 * fem, 0, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Rời chỗ',
                                style: TextStyle(
                                  fontSize: 15 * ffem,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5b5b5b),
                                ),
                              ),
                              Spacer(),
                              Text(
                                snapshot.connectionState == ConnectionState.waiting
                                    ? 'Đang tải...'
                                    : MyDateUtil.formatCheckInAndCheckOutDate(reservationDetail?.checkOut) ?? '',
                                style: TextStyle(
                                  fontSize: 15 * ffem,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
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
    );
  }
}
