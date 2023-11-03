import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ResponseSettingParking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late Future<ResponseSettingParking> settingParkingFuture;

  TextEditingController _priceOfMethodOneController = TextEditingController();
  TextEditingController _priceOfMethodTwoController = TextEditingController();
  TextEditingController _priceOfMethodThreeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    settingParkingFuture = _getSettingParkingFuture();
    settingParkingFuture.then((settingParking) {
      settingParking?.methodList?.forEach((method) {
        if (method.methodID == 1) {
          _priceOfMethodOneController.text = method.price.toStringAsFixed(0).toString();
        } else if (method.methodID == 2) {
          _priceOfMethodTwoController.text = method.price.toStringAsFixed(0).toString();
        } else if (method.methodID == 3) {
          _priceOfMethodThreeController.text = method.price.toStringAsFixed(0).toString();
        }
      });
    });
  }

  Future<ResponseSettingParking> _getSettingParkingFuture() async {
      return ParkingAPI.getParkingSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'CÀI ĐẶT BÃI XE',
          style: TextStyle(
            fontSize: 30 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: const Color(0xffffffff),
          ),
        ),
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10 * fem, 20 * fem, 10 * fem, 10 * fem),
        child: FutureBuilder<ResponseSettingParking>(
          future: settingParkingFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5 * fem),
                    child: Text('Mức phí & hoạt động', style: TextStyle(
                        fontSize: 22 * fem,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:  EdgeInsets.fromLTRB(7*fem, 14*fem, 10*fem, 12*fem),
                          decoration:  BoxDecoration (
                            color:  Color(0xfff5f5f5),
                            borderRadius:  BorderRadius.circular(9*fem),
                          ),
                          child:
                          Text(
                            'Ban ngày',
                            textAlign:  TextAlign.center,
                            style:  TextStyle (
                              fontSize:  22*ffem,
                              fontWeight:  FontWeight.w500,
                              height:  1.175*ffem/fem,
                              color:  Color(0xff222222),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5 * fem),
                          child: Text('Mức phí', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22 * fem,
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
                            controller: _priceOfMethodOneController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 22 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.175 * ffem / fem,
                              color: Color(0xff9e9e9e),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5 * fem),
                          child: Text('Thời gian hoạt động', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22 * fem,
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
                                      fontSize:  22*ffem,
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
                                      fontSize:  22*ffem,
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
                  Padding(
                    padding: EdgeInsets.only(left: 40 * fem, right: 40 * fem, top: 20 * fem, bottom: 15 * fem),
                    child: Divider(
                      thickness: 3,
                      height: 2 * fem,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10 * fem),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:  EdgeInsets.fromLTRB(7*fem, 14*fem, 10*fem, 12*fem),
                          decoration:  BoxDecoration (
                            color:  Color(0xfff5f5f5),
                            borderRadius:  BorderRadius.circular(9*fem),
                          ),
                          child:
                          Text(
                            'Ban đêm',
                            textAlign:  TextAlign.center,
                            style:  TextStyle (
                              fontSize:  22*ffem,
                              fontWeight:  FontWeight.w500,
                              height:  1.175*ffem/fem,
                              color:  Color(0xff222222),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5 * fem),
                          child: Text('Mức phí', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22 * fem,
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
                            controller: _priceOfMethodTwoController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 22 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.175 * ffem / fem,
                              color: Color(0xff9e9e9e),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5 * fem),
                          child: Text('Thời gian hoạt động', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22 * fem,
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
                                    '18 PM',
                                    style:  TextStyle (
                                      fontSize:  22*ffem,
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
                                    '23 PM',
                                    style:  TextStyle (
                                      fontSize:  22*ffem,
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
                  Padding(
                    padding: EdgeInsets.only(left: 40 * fem, right: 40 * fem, top: 20 * fem, bottom: 15 * fem),
                    child: Divider(
                      thickness: 3,
                      height: 2 * fem,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10 * fem),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:  EdgeInsets.fromLTRB(7*fem, 14*fem, 10*fem, 12*fem),
                          decoration:  BoxDecoration (
                            color:  Color(0xfff5f5f5),
                            borderRadius:  BorderRadius.circular(9*fem),
                          ),
                          child:
                          Text(
                            'Qua đêm',
                            textAlign:  TextAlign.center,
                            style:  TextStyle (
                              fontSize:  22*ffem,
                              fontWeight:  FontWeight.w500,
                              height:  1.175*ffem/fem,
                              color:  Color(0xff222222),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5 * fem),
                          child: Text('Mức phí', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22 * fem,
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
                            controller: _priceOfMethodThreeController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 22 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.175 * ffem / fem,
                              color: Color(0xff9e9e9e),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder
                                  .none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5 * fem),
                          child: Text('Thời gian hoạt động', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22 * fem,
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
                                    '23 PM',
                                    style: TextStyle(
                                      fontSize: 22 * ffem,
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
                                      fontSize: 22 * ffem,
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
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      String price1 = _priceOfMethodOneController.text;
                      String price2 = _priceOfMethodTwoController.text;
                      String price3 = _priceOfMethodThreeController.text;

                      if(price1.isEmpty && price2.isEmpty && price3.isEmpty){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Cần nhập ít nhất 1 phương thức'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Đóng'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }else{
                        List<Map<String, dynamic>> data = [];
                        if (price1 != null && price1.isNotEmpty) {
                          data.add({"methodID": 1, "price": price1});
                        }
                        if (price2 != null && price2.isNotEmpty) {
                          data.add({"methodID": 2, "price": price2});
                        }
                        if (price3 != null && price3.isNotEmpty) {
                          data.add({"methodID": 3, "price": price3});
                        }
                        try {
                          await ParkingAPI.updateParkingSetting(data);
                          _showSuccessfulDialog(context);
                        } catch (e) {
                          _showFailureDialog(context);
                        }
                      }

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
                            fontSize:  25*ffem,
                            fontWeight:  FontWeight.w600,
                            height:  1.175*ffem/fem,
                            color:  Color(0xffffffff),
                          ),
                        ),
                      ),
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
                        fontSize:  20*ffem,
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
                              fontSize:  20*ffem,
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
                        fontSize:  20*ffem,
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
                              fontSize:  20*ffem,
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
