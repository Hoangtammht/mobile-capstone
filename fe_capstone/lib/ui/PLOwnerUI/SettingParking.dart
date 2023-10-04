import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';

class SettingParkingScreen extends StatefulWidget {
  const SettingParkingScreen({Key? key}) : super(key: key);

  @override
  State<SettingParkingScreen> createState() => _SettingParkingScreenState();
}

class _SettingParkingScreenState extends State<SettingParkingScreen> {
  List<String> list = <String>['Ban ngày', 'Ban đêm','Qua đêm'];
  late String dropdownValue = list.first;
  bool isIconVisibleOne = true;
  bool isIconVisibleTwo = true;
  bool _firstAddClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'CÀI ĐẶT BÃI XE',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: const Color(0xffffffff),
          ),
        ),
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10 * fem, 20 * fem, 10 * fem, 10 * fem),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5 * fem),
              child: Text('Mức phí & hoạt động', style: TextStyle(
                fontSize: 18 * fem,
                fontWeight: FontWeight.bold
              ),),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5 * fem),
                    child: DropdownMenu<String>(
                      initialSelection: list.first,
                      onSelected: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5 * fem),
                    child: Text('Mức phí', style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15 * fem,
                        fontWeight: FontWeight.w400
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
                    padding: EdgeInsets.symmetric(horizontal: 10 * fem),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(9 * fem),
                    ),
                    child: TextFormField(
                      initialValue: '3.000', // Giá trị ban đầu
                      style: TextStyle(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.175 * ffem / fem,
                        color: Color(0xff9e9e9e),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none, // Loại bỏ viền của TextFormField
                      ),
                      onChanged: (newValue) {
                        // Xử lý khi giá trị thay đổi
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5 * fem),
                    child: Text('Thời gian hoạt động', style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15 * fem,
                        fontWeight: FontWeight.w400
                    ),
                    ),
                  ),
                  Container(
                    height:  51*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 35*fem, 0*fem),
                          width:  120*fem,
                          height:  double.infinity,
                          decoration:  BoxDecoration (
                            color:  Color(0xfff5f5f5),
                            borderRadius:  BorderRadius.circular(9*fem),
                          ),
                          child:
                          Center(
                            child:
                            Text(
                              '6 AM',
                              style:  TextStyle (
                                fontSize:  16*ffem,
                                fontWeight:  FontWeight.w400,
                                height:  1.2175*ffem/fem,
                                color:  Color(0x7f222222),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 34*fem, 0*fem),
                          width:  35*fem,
                          child:
                          Icon(Icons.arrow_forward),
                        ),
                        Container(
                          width:  120*fem,
                          height:  double.infinity,
                          decoration:  BoxDecoration (
                            color:  Color(0xfff5f5f5),
                            borderRadius:  BorderRadius.circular(9*fem),
                          ),
                          child:
                          Center(
                            child:
                            Text(
                              '18 PM',
                              style:  TextStyle (
                                fontSize:  16*ffem,
                                fontWeight:  FontWeight.w400,
                                height:  1.2175*ffem/fem,
                                color:  Color(0x7f222222),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            if(isIconVisibleOne)
            InkWell(
              onTap: (){
                setState(() {
                  isIconVisibleOne = false;
                  _firstAddClicked = true;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5 * fem),
                width:  40*fem,
                height:  40*fem,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff9e9e9e)),
                  borderRadius: BorderRadius.circular(9 * fem),
                  color: Colors.transparent,
                ),
                child:
                Icon(Icons.add),
              ),
            ),
            if (!isIconVisibleOne)
            Container(
              margin: EdgeInsets.only(top: 10 * fem),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5 * fem),
                    child: DropdownMenu<String>(
                      initialSelection: list.first,
                      onSelected: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5 * fem),
                    child: Text('Mức phí', style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15 * fem,
                        fontWeight: FontWeight.w400
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
                    padding: EdgeInsets.symmetric(horizontal: 10 * fem),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(9 * fem),
                    ),
                    child: TextFormField(
                      initialValue: '3.000', // Giá trị ban đầu
                      style: TextStyle(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.175 * ffem / fem,
                        color: Color(0xff9e9e9e),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none, // Loại bỏ viền của TextFormField
                      ),
                      onChanged: (newValue) {
                        // Xử lý khi giá trị thay đổi
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5 * fem),
                    child: Text('Thời gian hoạt động', style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15 * fem,
                        fontWeight: FontWeight.w400
                    ),
                    ),
                  ),
                  Container(
                    height:  51*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 35*fem, 0*fem),
                          width:  120*fem,
                          height:  double.infinity,
                          decoration:  BoxDecoration (
                            color:  Color(0xfff5f5f5),
                            borderRadius:  BorderRadius.circular(9*fem),
                          ),
                          child:
                          Center(
                            child:
                            Text(
                              '11 PM',
                              style:  TextStyle (
                                fontSize:  16*ffem,
                                fontWeight:  FontWeight.w400,
                                height:  1.2175*ffem/fem,
                                color:  Color(0x7f222222),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 34*fem, 0*fem),
                          width:  35*fem,
                          child:
                          Icon(Icons.arrow_forward),
                        ),
                        Container(
                          width:  120*fem,
                          height:  double.infinity,
                          decoration:  BoxDecoration (
                            color:  Color(0xfff5f5f5),
                            borderRadius:  BorderRadius.circular(9*fem),
                          ),
                          child:
                          Center(
                            child:
                            Text(
                              '11 PM',
                              style:  TextStyle (
                                fontSize:  16*ffem,
                                fontWeight:  FontWeight.w400,
                                height:  1.2175*ffem/fem,
                                color:  Color(0x7f222222),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(_firstAddClicked)
                  InkWell(
                    onTap: (){
                      setState(() {
                        isIconVisibleOne = true;
                      });
                    },
                    child: Container(
                      margin:  EdgeInsets.fromLTRB(0*fem, 25*fem, 0*fem, 0*fem),
                      width:  361*fem,
                      height:  51*fem,
                      decoration:  BoxDecoration (
                        color: Colors.red,
                        borderRadius:  BorderRadius.circular(9*fem),
                      ),
                      child:
                      Center(
                        child:
                        Icon(Icons.delete_forever_outlined, color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ),


            ),

            if (_firstAddClicked)
              if(isIconVisibleTwo)
                InkWell(
                  onTap: () {
                    setState(() {
                      isIconVisibleTwo = false;
                      _firstAddClicked = false;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5 * fem),
                    width: 40 * fem,
                    height: 40 * fem,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff9e9e9e)),
                      borderRadius: BorderRadius.circular(9 * fem),
                      color: Colors.transparent,
                    ),
                    child:
                    Icon(Icons.add),
                  ),
                ),
              if (!isIconVisibleTwo)
                Container(
                  margin: EdgeInsets.only(top: 10 * fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5 * fem),
                        child: DropdownMenu<String>(
                          initialSelection: list.first,
                          onSelected: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries:
                          list.map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5 * fem),
                        child: Text('Mức phí', style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15 * fem,
                            fontWeight: FontWeight.w400
                        ),),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 16 * fem),
                        padding: EdgeInsets.symmetric(horizontal: 10 * fem),
                        decoration: BoxDecoration(
                          color: Color(0xfff5f5f5),
                          borderRadius: BorderRadius.circular(9 * fem),
                        ),
                        child: TextFormField(
                          initialValue: '3.000', // Giá trị ban đầu
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.175 * ffem / fem,
                            color: Color(0xff9e9e9e),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder
                                .none, // Loại bỏ viền của TextFormField
                          ),
                          onChanged: (newValue) {
                            // Xử lý khi giá trị thay đổi
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5 * fem),
                        child: Text('Thời gian hoạt động', style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15 * fem,
                            fontWeight: FontWeight.w400
                        ),
                        ),
                      ),
                      Container(
                        height: 51 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 35 * fem, 0 * fem),
                              width: 120 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(9 * fem),
                              ),
                              child:
                              Center(
                                child:
                                Text(
                                  '11 PM',
                                  style: TextStyle(
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2175 * ffem / fem,
                                    color: Color(0x7f222222),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 34 * fem, 0 * fem),
                              width: 35 * fem,
                              child:
                              Icon(Icons.arrow_forward),
                            ),
                            Container(
                              width: 120 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(9 * fem),
                              ),
                              child:
                              Center(
                                child:
                                Text(
                                  '11 PM',
                                  style: TextStyle(
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2175 * ffem / fem,
                                    color: Color(0x7f222222),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isIconVisibleTwo = true;
                            _firstAddClicked = true;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 25 * fem, 0 * fem, 0 * fem),
                          width: 361 * fem,
                          height: 51 * fem,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(9 * fem),
                          ),
                          child:
                          Center(
                            child:
                            Icon(Icons.delete_forever_outlined,
                              color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

            InkWell(
              onTap: (){
                _showFailureDialog(context);
              },
              child: Container(
                margin:  EdgeInsets.fromLTRB(0*fem, 55*fem, 0*fem, 0*fem),
                height:  50*fem,
                decoration:  BoxDecoration (
                  color: Theme.of(context).primaryColor,
                  borderRadius:  BorderRadius.circular(9*fem),
                ),
                child:
                Center(
                  child:
                  Text(
                    'Lưu thay đổi',
                    style:  TextStyle (
                      fontSize:  19*ffem,
                      fontWeight:  FontWeight.w600,
                      height:  1.175*ffem/fem,
                      color:  Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSuccessfulDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            child: Container(
              padding:  EdgeInsets.fromLTRB(10*fem, 32*fem, 10*fem, 0),
              width:  double.infinity,
              height: 300 * fem,
              decoration:  BoxDecoration (
                color:  Color(0xffffffff),
                borderRadius:  BorderRadius.circular(23*fem),
              ),
              child:
              Column(
                crossAxisAlignment:  CrossAxisAlignment.center,
                children:  [
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 12*fem, 11*fem),
                    width:  100*fem,
                    height:  100*fem,
                    child:
                    Image.asset(
                        'assets/images/success.png'
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 23*fem),
                    child:
                    Text(
                      'Chúc mừng bạn!',
                      style:  TextStyle (
                        fontSize:  24*ffem,
                        fontWeight:  FontWeight.w600,
                        height:  1.175*ffem/fem,
                        color:  Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 25*fem),
                    child:
                    Text(
                      'Hệ thống đã lưu thay đổi của bạn !',
                      textAlign:  TextAlign.center,
                      style:  TextStyle (
                        fontSize:  16*ffem,
                        fontWeight:  FontWeight.w400,
                        height:  1.2175*ffem/fem,
                        color:  Color(0xff999999),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width:  60 * fem,
                      height:  42*fem,
                      decoration:  BoxDecoration (
                        color:  Color(0xff6ec2f7),
                        borderRadius:  BorderRadius.circular(9*fem),
                        boxShadow:  [
                          BoxShadow(
                            color:  Color(0x82000000),
                            offset:  Offset(0*fem, 4*fem),
                            blurRadius:  10*fem,
                          ),
                        ],
                      ),
                      child:
                      Center(
                        child:
                        Center(
                          child:
                          Text(
                            'Ok',
                            textAlign:  TextAlign.center,
                            style:  TextStyle (
                              fontSize:  16*ffem,
                              fontWeight:  FontWeight.w600,
                              height:  1.175*ffem/fem,
                              color:  Color(0xffffffff),
                            ),
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
      },
    );
  }

  Future<void> _showFailureDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            child: Container(
              padding:  EdgeInsets.fromLTRB(10*fem, 32*fem, 10*fem, 0),
              width:  double.infinity,
              height: 300 * fem,
              decoration:  BoxDecoration (
                color:  Color(0xffffffff),
                borderRadius:  BorderRadius.circular(23*fem),
              ),
              child:
              Column(
                crossAxisAlignment:  CrossAxisAlignment.center,
                children:  [
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0 * fem, 11*fem),
                    width:  100*fem,
                    height:  100*fem,
                    child:
                    Image.asset(
                        'assets/images/failure.png'
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 23*fem),
                    child:
                    Text(
                      'Thất bại',
                      style:  TextStyle (
                        fontSize:  24*ffem,
                        fontWeight:  FontWeight.w600,
                        height:  1.175*ffem/fem,
                        color:  Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 25*fem),
                    child:
                    Text(
                      'Việc chuyển đổi dữ liệu đã thất bại !',
                      textAlign:  TextAlign.center,
                      style:  TextStyle (
                        fontSize:  16*ffem,
                        fontWeight:  FontWeight.w400,
                        height:  1.2175*ffem/fem,
                        color:  Color(0xff999999),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width:  60 * fem,
                      height:  42*fem,
                      decoration:  BoxDecoration (
                        color:  Color(0xff6ec2f7),
                        borderRadius:  BorderRadius.circular(9*fem),
                        boxShadow:  [
                          BoxShadow(
                            color:  Color(0x82000000),
                            offset:  Offset(0*fem, 4*fem),
                            blurRadius:  10*fem,
                          ),
                        ],
                      ),
                      child:
                      Center(
                        child:
                        Center(
                          child:
                          Text(
                            'Ok',
                            textAlign:  TextAlign.center,
                            style:  TextStyle (
                              fontSize:  16*ffem,
                              fontWeight:  FontWeight.w600,
                              height:  1.175*ffem/fem,
                              color:  Color(0xffffffff),
                            ),
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
      },
    );
  }

}
