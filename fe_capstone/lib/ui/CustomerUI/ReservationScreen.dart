import 'dart:convert';

import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/apis/customer/ReservationAPI.dart';
import 'package:fe_capstone/blocs/VehicleProvider.dart';
import 'package:fe_capstone/blocs/WalletDataProvider.dart';
import 'package:fe_capstone/constant/base_constant.dart';
import 'package:fe_capstone/models/ListVehicleCustomer.dart';
import 'package:fe_capstone/models/ParkingInformationModel.dart';
import 'package:fe_capstone/models/ReservationDetail.dart';
import 'package:flutter/material.dart';
import 'package:fe_capstone/main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class ReservationScreen extends StatefulWidget {
  final ParkingLotDetail parkinglotDetail;
  final Function refreshHomeScreen;
  final String ploID;
  final String distance;
  final String waitingTime;

  const ReservationScreen({
    super.key,
    required this.parkinglotDetail,
    required this.ploID,
    required this.refreshHomeScreen,
    required this.distance,
    required this.waitingTime,
  });

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  Future<ReservationMethod>? reservationMethod;
  late VehicleProvider _vehicleProvider;
  late Future<List<ListVehicleCustomer>> vehicleFuture;
  TextEditingController _vehicleNumberController = TextEditingController();
  TextEditingController _vehicleNameController = TextEditingController();
  TextEditingController _vehicleColorController = TextEditingController();
  late double price;
  late String dropdownType = '';
  late String dropdownVehicle = '';
  late int dropdownVehicleID;
  late List<ReservationMethod> reserMethod;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
  WebSocketChannel ploChannel =
      IOWebSocketChannel.connect(BaseConstants.WEBSOCKET_PRIVATE_PLO_URL);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
    vehicleFuture = _vehicleProvider.getVehicleList();
    vehicleFuture.then((value) {
      dropdownVehicle = value.first.licensePlate;
      dropdownVehicleID = value.first.motorbikeID;
    });
    reservationMethod = _getReservationMethod();
  }

  Future<ReservationMethod> _getReservationMethod() {
    return ReservationAPI.getMethodofPLO(widget.ploID);
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
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Đặt chỗ',
            style: TextStyle(
              fontSize: 30 * ffem,
              fontWeight: FontWeight.w700,
              height: 1.175 * ffem / fem,
              color: const Color(0xffffffff),
            ),
          ),
        ),
        body: FutureBuilder(
            future: reservationMethod,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Lỗi: ${snapshot.error}');
              } else {
                final data = snapshot.data;

                if (data == null) {
                  return const Text('Không có dữ liệu');
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12 * fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25 * fem),
                        child: Text(widget.parkinglotDetail.parkingName,
                            style: TextStyle(
                                fontSize: 22 * fem,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 2 * fem, bottom: 15 * fem),
                        child: Text(
                          widget.parkinglotDetail.address,
                          style:
                              TextStyle(fontSize: 20 * fem, color: Colors.grey),
                        ),
                      ),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (widget.parkinglotDetail.morningFee != 0)
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    15 * fem, 10 * fem, 15 * fem, 8 * fem),
                                height: 50 * fem,
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(6 * fem),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 6 * fem),
                                      child: Text(
                                        'Sáng',
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.175 * ffem / fem,
                                          color: const Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${formatCurrency.format(widget.parkinglotDetail.morningFee)}',
                                      style: TextStyle(
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2175 * ffem / fem,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              width: 5 * fem,
                            ),
                            if (widget.parkinglotDetail.eveningFee != 0)
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    15 * fem, 10 * fem, 15 * fem, 8 * fem),
                                height: 50 * fem,
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(6 * fem),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 6 * fem),
                                      child: Text(
                                        'Tối',
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.175 * ffem / fem,
                                          color: const Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${formatCurrency.format(widget.parkinglotDetail.eveningFee)}',
                                      style: TextStyle(
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2175 * ffem / fem,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              width: 5 * fem,
                            ),
                            if (widget.parkinglotDetail.overnightFee != 0)
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    12 * fem, 10 * fem, 12 * fem, 8 * fem),
                                height: 50 * fem,
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(6 * fem),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 6 * fem),
                                      child: Text(
                                        'Qua đêm',
                                        style: TextStyle(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.175 * ffem / fem,
                                          color: const Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${formatCurrency.format(widget.parkinglotDetail.overnightFee)}',
                                      style: TextStyle(
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2175 * ffem / fem,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              width: 5 * fem,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  12 * fem, 10 * fem, 12 * fem, 8 * fem),
                              height: 50 * fem,
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(6 * fem),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 6 * fem),
                                    child: Text(
                                      'Chỗ trống',
                                      style: TextStyle(
                                        fontSize: 18 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.175 * ffem / fem,
                                        color: const Color(0xff5b5b5b),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.parkinglotDetail.currentSlot
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2175 * ffem / fem,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5 * fem,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  15 * fem, 10 * fem, 15 * fem, 8 * fem),
                              height: 50 * fem,
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(6 * fem),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 6 * fem),
                                    child: Text(
                                      'Cách',
                                      style: TextStyle(
                                        fontSize: 18 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.175 * ffem / fem,
                                        color: const Color(0xff5b5b5b),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${widget.distance} m',
                                    style: TextStyle(
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2175 * ffem / fem,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 30 * fem, bottom: 15 * fem),
                        child: Row(
                          children: [
                            Text(
                              'Phương thức gửi:',
                              style: TextStyle(
                                  fontSize: 17 * fem,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 30),
                            Text(
                              data.methodName,
                              style: TextStyle(fontSize: 16 * fem, fontWeight:  FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 25 * fem, bottom: 15 * fem),
                        child: Text(
                          'Chọn xe:',
                          style: TextStyle(
                              fontSize: 17 * fem, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Consumer<VehicleProvider>(
                        builder: (context, vehicleProvider, child) {
                          return FutureBuilder<List<ListVehicleCustomer>>(
                            future: vehicleProvider.getVehicleList(),
                            builder: (context, snapshot) {
                              if (vehicleProvider.vehicles.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    _showAddVehicleDialog(context);
                                  },
                                  child: Container(
                                    width: 31 * fem,
                                    height: 31 * fem,
                                    child: Image.asset(
                                        'assets/images/addIcon.png'),
                                  ),
                                );
                              }
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xff2b7031),
                                        width: 2 * fem,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(3 * fem),
                                    ),
                                    child: DropdownMenu<String>(
                                      initialSelection: vehicleProvider
                                          .vehicles.first.licensePlate,
                                      textStyle: TextStyle(fontSize: 16 * fem),
                                      onSelected: (String? value) {
                                        ListVehicleCustomer selectedMap =
                                            vehicleProvider.vehicles.firstWhere(
                                                (map) =>
                                                    map.licensePlate == value);

                                        setState(() {
                                          dropdownVehicle =
                                              selectedMap.licensePlate;
                                          dropdownVehicleID =
                                              selectedMap.motorbikeID;
                                        });
                                      },
                                      dropdownMenuEntries: vehicleProvider
                                          .vehicles
                                          .map((vehicle) {
                                        return DropdownMenuEntry<String>(
                                          value: vehicle.licensePlate,
                                          label: vehicle.licensePlate,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _showAddVehicleDialog(context);
                                    },
                                    child: Container(
                                      width: 31 * fem,
                                      height: 31 * fem,
                                      child: Image.asset(
                                          'assets/images/addIcon.png'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Thời gian chờ là ${widget.waitingTime}',
                            style: TextStyle(
                                fontSize: 20 * fem,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                10 * fem, 38 * fem, 14 * fem, 37 * fem),
                            height: 120 * fem,
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '${formatCurrency.format(data.price)}',
                                      style: TextStyle(
                                          fontSize: 22 * fem,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data.methodName,
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    _showAddReservationDialog(context,
                                        widget.refreshHomeScreen, data);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        15 * fem, 10 * fem, 15 * fem, 10 * fem),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(6 * fem),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Đặt chỗ',
                                        style: TextStyle(
                                          fontSize: 20 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.175 * ffem / fem,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }

  Future<void> _showAddVehicleDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "Thêm biển đổ xe mới",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25 * fem,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Biển số',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child: TextFormField(
                        controller: _vehicleNumberController,
                        decoration: const InputDecoration(
                          hintText: '12-A34567',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tên xe',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child: TextFormField(
                        controller: _vehicleNameController,
                        decoration: const InputDecoration(
                          hintText: 'Air Blade 125',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Màu Sắc',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child: TextFormField(
                        controller: _vehicleColorController,
                        decoration: const InputDecoration(
                          hintText: 'Air Blade 125',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
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
                          color: const Color(0xffb3abab), // Đường thẳng dọc
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
                              String newlicensePlate =
                                  _vehicleNumberController.text;
                              String newMotorColor =
                                  _vehicleColorController.text;
                              String newMotorName = _vehicleNameController.text;
                              if (newlicensePlate.isNotEmpty &&
                                  newMotorColor.isNotEmpty &&
                                  newMotorName.isNotEmpty) {
                                try {
                                  await _vehicleProvider.addNewVehicle(
                                      newlicensePlate,
                                      newMotorColor,
                                      newMotorName);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Thêm xe thành công')),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Thêm xe thất bại'),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'Lưu',
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

  Future<void> _showAddReservationDialog(BuildContext context,
      Function refreshHomeScreen, ReservationMethod reservationMethod) async {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 * fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12 * fem),
                        child: Center(
                          child: Text(
                            'THÔNG TIN ĐẶT XE',
                            style: TextStyle(
                              fontSize: 20 * fem,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 8 * fem),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Text(
                              'Tên bãi:  ',
                              style: TextStyle(
                                fontSize: 18 * fem,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff000000),
                              ),
                            ),
                            title: Text(
                              widget.parkinglotDetail.parkingName,
                              style: TextStyle(
                                fontSize: 18 * fem,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff000000),
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4 * fem),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              1 * fem, 0 * fem, 1 * fem, 11 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Phương thức gửi: ',
                                  style: TextStyle(
                                    fontSize: 18 * fem,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                              Text(
                                reservationMethod.methodName,
                                style: TextStyle(
                                  fontSize: 18 * fem,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2 * fem),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 8 * fem),
                          child: Text(
                            'Biển số xe: ',
                            style: TextStyle(
                              fontSize: 18 * fem,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 94 * fem,
                        height: 23 * fem,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff2b7031)),
                          color: const Color(0xfff8f8f8),
                          borderRadius: BorderRadius.circular(3 * fem),
                        ),
                        child: Center(
                          child: Text(
                            dropdownVehicle,
                            style: TextStyle(
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2175 * ffem / fem,
                              color: const Color(0xff2b7031),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10 * fem),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 6 * fem, 174 * fem, 0 * fem),
                              child: Text(
                                'Số tiền: ',
                                style: TextStyle(
                                  fontSize: 18 * fem,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff000000),
                                ),
                              ),
                            ),
                            Text(
                              '${formatCurrency.format(reservationMethod.price)}',
                              style: TextStyle(
                                fontSize: 18 * fem,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ],
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
                                await ReservationAPI.getBooking(
                                        dropdownVehicleID,
                                        reservationMethod.methodID,
                                        widget.ploID)
                                    .then((value) async {
                                  if (value == 1) {
                                    await FirebaseAPI.createUserForCus(
                                            widget.ploID)
                                        .then((value) async {
                                      final message = {
                                        "ploID": widget.ploID.toString(),
                                        "content": "GetParking"
                                      };
                                      final messageJson = jsonEncode(message);
                                      ploChannel.sink.add(messageJson);
                                      print("Đặt chỗ socket: $messageJson");
                                      Navigator.of(context).pop();
                                      refreshHomeScreen();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Đặt chỗ thành công')),
                                      );
                                      final walletProvider =
                                          Provider.of<WalletDataProvider>(
                                              context,
                                              listen: false);
                                      await walletProvider.updateTransactions();
                                    });
                                  } else {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Bãi xe hiện tại đã hết chỗ, xin vui lòng đặt nơi khác!'),
                                      ),
                                    );
                                  }
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Đặt chỗ thất bại'),
                                  ),
                                );
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text(
                              'Đặt',
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
