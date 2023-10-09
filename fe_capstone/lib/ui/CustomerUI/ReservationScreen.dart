import 'package:flutter/material.dart';
import 'package:fe_capstone/main.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  List<String> listType = <String>['Ban ngày', 'Ban Đêm', 'Qua đêm'];
  List<String> listVehicle = <String>['72A-371.90', '60A-257.26', '51F-123.56'];
  late String dropdownType = listType.first;
  late String dropdownVehicle = listVehicle.first;
  TextEditingController _vehicleNumberController = TextEditingController();


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
          'Đặt chỗ',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12 * fem),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25 * fem),
              child: Text('Khách sạn Romantic',
                  style: TextStyle(
                      fontSize: 20 * fem, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2 * fem, bottom: 15 * fem),
              child: Text(
                '681A Đ. Nguyễn Huệ, Bến Nghé, Quận 1, TP HCM',
                style: TextStyle(fontSize: 15 * fem, color: Colors.grey),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                            fontSize: 13 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.175 * ffem / fem,
                            color: Color(0xff5b5b5b),
                          ),
                        ),
                      ),
                      Text(
                        '3k',
                        style: TextStyle(
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10 * fem,
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
                          'Tối',
                          style: TextStyle(
                            fontSize: 13 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.175 * ffem / fem,
                            color: Color(0xff5b5b5b),
                          ),
                        ),
                      ),
                      Text(
                        '3k',
                        style: TextStyle(
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10 * fem,
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
                          'Qua đêm',
                          style: TextStyle(
                            fontSize: 13 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.175 * ffem / fem,
                            color: Color(0xff5b5b5b),
                          ),
                        ),
                      ),
                      Text(
                        '4k',
                        style: TextStyle(
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10 * fem,
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
                            fontSize: 13 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.175 * ffem / fem,
                            color: Color(0xff5b5b5b),
                          ),
                        ),
                      ),
                      Text(
                        '11',
                        style: TextStyle(
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10 * fem,
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
                            fontSize: 13 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.175 * ffem / fem,
                            color: Color(0xff5b5b5b),
                          ),
                        ),
                      ),
                      Text(
                        '5m',
                        style: TextStyle(
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30 * fem, bottom: 15 * fem),
              child: Text(
                'Phương thức gửi:',
                style:
                    TextStyle(fontSize: 17 * fem, fontWeight: FontWeight.bold),
              ),
            ),
            DropdownMenu<String>(
              initialSelection: listType.first,
              width: 350 * fem,
              textStyle: TextStyle(fontSize: 16 * fem),
              onSelected: (String? value) {
                setState(() {
                  dropdownType = value!;
                });
              },
              dropdownMenuEntries:
              listType.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25 * fem, bottom: 15 * fem),
              child: Text(
                'Chọn xe:',
                style:
                    TextStyle(fontSize: 17 * fem, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color(0xff2b7031), width: 2 * fem),
                    borderRadius: BorderRadius.circular(3 * fem),
                  ),
                  child: DropdownMenu<String>(
                    initialSelection: listVehicle.first,
                    textStyle: TextStyle(fontSize: 16 * fem),
                    
                    onSelected: (String? value) {
                      setState(() {
                        dropdownVehicle = value!;
                      });
                    },
                    dropdownMenuEntries:
                    listVehicle.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(value: value, label: value);
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
                    child: Image.asset('assets/images/addIcon.png'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Thời gian chờ là 15 phút',
                  style: TextStyle(
                      fontSize: 15 * fem, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      13 * fem, 38 * fem, 14 * fem, 37 * fem),
                  height: 120 * fem,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '3.000đ',
                            style: TextStyle(
                                fontSize: 18 * fem,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4 * fem,
                          ),
                          Text(dropdownType)
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _showAddReservationDialog(context);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              15 * fem, 10 * fem, 15 * fem, 10 * fem),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(6 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Đặt chỗ',
                              style: TextStyle(
                                fontSize: 16 * ffem,
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
      ),
    );
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
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "Thêm biển đổ xe mới",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, top: 20),
                  padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                  constraints: BoxConstraints(
                    maxWidth: 300,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.circular(9 * fem),
                  ),
                  child: TextFormField(
                    controller: _vehicleNumberController,
                    decoration: InputDecoration(
                      hintText: '12A-1234',
                      border: InputBorder.none,
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
                          color: Color(0xffb3abab), // Đường thẳng dọc
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
                              String newVehicle = _vehicleNumberController.text;
                              if (newVehicle.isNotEmpty) {
                                setState(() {
                                  listVehicle.add(newVehicle);
                                });
                              }
                            },
                            child: Text(
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

  Future<void> _showAddReservationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10 * fem),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12 * fem),
                  child: Center(
                    child: Text(
                      'THÔNG TIN ĐẶT XE',
                      style: TextStyle(
                        fontSize: 15 * fem,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8 * fem),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tên bãi:  ',
                        style: TextStyle(
                          fontSize: 13 * fem,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                      Text(
                        'Khách sạn Romantic',
                        style: TextStyle(
                          fontSize: 13 * fem,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4 * fem),
                  child: Container(
                    margin:
                        EdgeInsets.fromLTRB(1 * fem, 0 * fem, 1 * fem, 11 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Phương thức gửi: ',
                            style: TextStyle(
                              fontSize: 13 * fem,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Text(
                          dropdownType,
                          style: TextStyle(
                            fontSize: 13 * fem,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2 * fem),
                  child: Container(
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                    child: Text(
                      'Biển số xe: ',
                      style: TextStyle(
                        fontSize: 13 * fem,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 94 * fem,
                  height: 23 * fem,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff2b7031)),
                    color: Color(0xfff8f8f8),
                    borderRadius: BorderRadius.circular(3 * fem),
                  ),
                  child: Center(
                    child: Text(
                      dropdownVehicle,
                      style: TextStyle(
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.2175 * ffem / fem,
                        color: Color(0xff2b7031),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10 * fem),
                  child: Row(
                    crossAxisAlignment:  CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Container(
                        margin:  EdgeInsets.fromLTRB(0*fem, 6*fem, 174*fem, 0*fem),
                        child:
                        Text(
                          'Số tiền: ',
                          style:  TextStyle (
                            fontSize:  13*fem,
                            fontWeight:  FontWeight.w600,
                            color:  Color(0xff000000),
                          ),
                        ),
                      ),
                      Text(
                        '3.000đ',
                        style:  TextStyle (
                          fontSize:  18*fem,
                          fontWeight:  FontWeight.w600,
                          color:  Color(0xff000000),
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
                              Navigator.of(context).pop();
                            },
                            child: Text(
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
}
