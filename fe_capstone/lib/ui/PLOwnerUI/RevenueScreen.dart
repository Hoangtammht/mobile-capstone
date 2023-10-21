import 'package:fe_capstone/apis/plo/AuthAPI.dart';
import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/RevenueModel.dart';
import 'package:fe_capstone/models/Withdraw.dart';
import 'package:fe_capstone/ui/components/widgetPLO/WithdrawCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({Key? key}) : super(key: key);

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  TextEditingController _InputMoneyController = TextEditingController();
  TextEditingController _methodOneController = TextEditingController();
  TextEditingController _methodTwoController = TextEditingController();
  final NumberFormat currencyFormat = NumberFormat("#,###");

  TextEditingController _fromDateController = TextEditingController();
  TextEditingController _toDateController = TextEditingController();
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  late Future<RevenueModel> revenueModelFuture;

  String token = "";
  List<Withdraw> listHistoryWithdraw = [];
  double revenueValue = 0;


  @override
  void initState() {
    super.initState();
    _fromDateController.text =
        DateFormat('dd/MM/yyyy').format(selectedFromDate);
    _toDateController.text = DateFormat('dd/MM/yyyy').format(selectedToDate);
    revenueModelFuture = _getPloProfileFuture();
    revenueModelFuture.then((data) {
      listHistoryWithdraw = data.history.map((history) => Withdraw(
          icon: Icons.account_balance_wallet_outlined,
          title: "Rút tiền",
          time: history.transactionResultDate,
          amount: history.depositAmount)).toList();
    });
    _getDataFromAPI();
  }

  void _getDataFromAPI() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      if (accessToken != null) {
        setState(() {
          token = accessToken;
        });
        String fromDate = DateFormat("yyyy-MM-dd").format(DateFormat("dd/MM/yyyy").parse(_fromDateController.text));
        String toDate = DateFormat("yyyy-MM-dd").format(DateFormat("dd/MM/yyyy").parse(_toDateController.text));
        double value = await ParkingAPI.getSumByDate(
            token, fromDate, toDate);
        setState(() {
          revenueValue = value;
        });
      }
    } catch (e) {
      print('Error while fetching data: $e');
    }
  }

  Future<RevenueModel> _getPloProfileFuture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    if (accessToken != null) {
      setState(() {
        token = accessToken;
      });
      return AuthPloAPIs.getPloRevenue(token);
    } else {
      throw Exception("Access token not found");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          'Doanh thu',
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
        child: FutureBuilder<RevenueModel>(
          future: revenueModelFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final revenueModel = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        19 * fem, 10 * fem, 0 * fem, 0 * fem),
                    child: Text(
                      'Ví tiền',
                      style: TextStyle(
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        19 * fem, 5 * fem, 0 * fem, 0 * fem),
                    child: Text(
                      snapshot.connectionState == ConnectionState.waiting
                          ? 'Đang tải...'
                          : (revenueModel != null
                          ? '${NumberFormat("#,##0", "vi_VN").format(revenueModel.balance)} đ'
                          : '${NumberFormat("#,##0", "vi_VN").format(0.0)} đ'),
                      style: TextStyle(
                        fontSize: 35 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.2175 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                        _showRequestTransactionDialog(context);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          19 * fem, 0 * fem, 19 * fem, 5 * fem),
                      padding: EdgeInsets.fromLTRB(
                          24.5 * fem, 14 * fem, 11 * fem, 15 * fem),
                      width: 150 * fem,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 1 * fem, 11.5 * fem, 0 * fem),
                            width: 21 * fem,
                            height: 18.67 * fem,
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Rút tiền',
                            style: TextStyle(
                              fontSize: 19 * ffem,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        15 * fem, 5 * fem, 17 * fem, 5 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(26 * fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 9 * fem),
                          child: Text(
                            'Thống kê chi tiết',
                            style: TextStyle(
                              fontSize: 19 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.175 * ffem / fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              8 * fem, 0 * fem, 0 * fem, 15 * fem),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 5 * fem),
                                child: Text(
                                  'Từ',
                                  style: TextStyle(
                                    fontSize: 19 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.175 * ffem / fem,
                                    color: Color(0xff9e9e9e),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: selectedFromDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                    ).then((date) {
                                      if (date != null) {
                                        setState(() {
                                          selectedFromDate = date;
                                          _fromDateController.text = DateFormat('dd/MM/yyyy').format(selectedFromDate);
                                          _getDataFromAPI();
                                        });
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 7 * fem),
                                    padding: EdgeInsets.fromLTRB(
                                        12 * fem, 7 * fem, 5 * fem, 7 * fem),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0x4c000000)),
                                      color: Color(0xffffffff),
                                      borderRadius:
                                          BorderRadius.circular(10 * fem),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_month_outlined),
                                        SizedBox(width: 10 * fem),
                                        Text(
                                          _fromDateController.text,
                                          style: TextStyle(
                                            fontSize: 16 * ffem,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 7 * fem, right: 2 * fem),
                                child: Text(
                                  'đến',
                                  style: TextStyle(
                                    fontSize: 19 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.175 * ffem / fem,
                                    color: Color(0xff9e9e9e),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: selectedToDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                    ).then((date) {
                                      if (date != null) {
                                        setState(() {
                                          selectedToDate = date;
                                          _toDateController.text =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(selectedToDate);
                                          _getDataFromAPI();
                                        });
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 7 * fem),
                                    padding: EdgeInsets.fromLTRB(
                                        12 * fem, 7 * fem, 5 * fem, 7 * fem),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0x4c000000)),
                                      color: Color(0xffffffff),
                                      borderRadius:
                                          BorderRadius.circular(10 * fem),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_month_outlined),
                                        SizedBox(width: 10 * fem),
                                        Text(
                                          _toDateController.text,
                                          style: TextStyle(
                                            fontSize: 16 * ffem,
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
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              8 * fem, 0 * fem, 3 * fem, 0 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 3 * fem, 115 * fem, 0 * fem),
                                child: Text(
                                  'Doanh thu',
                                  style: TextStyle(
                                    fontSize: 19 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.175 * ffem / fem,
                                    color: Color(0xff9e9e9e),
                                  ),
                                ),
                              ),
                              Text(
                              '${NumberFormat("#,##0", "vi_VN").format(revenueValue)} đ',
                                style: TextStyle(
                                  fontSize: 24 * ffem,
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
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        20 * fem, 0 * fem, 20 * fem, 29 * fem),
                    height: 60 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              15 * fem, 13 * fem, 15 * fem, 15 * fem),
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(6 * fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 7 * fem),
                                child: Text(
                                  'Số lượng ',
                                  style: TextStyle(
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.bold,
                                    height: 1.175 * ffem / fem,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 3 * fem, 0 * fem),
                                child: Text(
                                  snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? '...'
                                      : revenueModel?.totalVehicle.toString() ??
                                          '0',
                                  style: TextStyle(
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2175 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
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
                              18 * fem, 14 * fem, 19 * fem, 15 * fem),
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
                            borderRadius: BorderRadius.circular(6 * fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 6 * fem),
                                child: Text(
                                  'Ban ngày',
                                  style: TextStyle(
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.bold,
                                    height: 1.175 * ffem / fem,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    1 * fem, 0 * fem, 0 * fem, 0 * fem),
                                child: Text(
                                  snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? '...'
                                      : revenueModel?.totalVehicleMethodDay
                                              .toString() ??
                                          '0',
                                  style: TextStyle(
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2175 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
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
                              16 * fem, 15 * fem, 17 * fem, 12 * fem),
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                child: Text(
                                  'Ban Tối',
                                  style: TextStyle(
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.bold,
                                    height: 1.175 * ffem / fem,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                              ),
                              Container(
                                // dNo (648:924)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 1 * fem, 0 * fem),
                                child: Text(
                                  snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? '...'
                                      : revenueModel?.totalVehicleMethodNight
                                              .toString() ??
                                          '0',
                                  style: TextStyle(
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2175 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
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
                              13 * fem, 14 * fem, 13 * fem, 15 * fem),
                          decoration: BoxDecoration(
                            color: Color(0xfff5f5f5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 6 * fem),
                                child: Text(
                                  'Qua đêm',
                                  style: TextStyle(
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.bold,
                                    height: 1.175 * ffem / fem,
                                    color: Color(0xff5b5b5b),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    6 * fem, 0 * fem, 0 * fem, 0 * fem),
                                child: Text(
                                  snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? '...'
                                      : revenueModel
                                              ?.totalVehicleMethodOvernight
                                              .toString() ??
                                          '0',
                                  style: TextStyle(
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2175 * ffem / fem,
                                    color: Color(0xff000000),
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
                    margin: EdgeInsets.fromLTRB(
                        19 * fem, 0 * fem, 0 * fem, 8 * fem),
                    child: Text(
                      'Lịch sử rút tiền',
                      style: TextStyle(
                        fontSize: 19 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.175 * ffem / fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          15 * fem, 0 * fem, 15 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          14 * fem, 10 * fem, 14 * fem, 0 * fem),
                      width: double.infinity,
                      height: 250 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xfff8f8f8),
                        borderRadius: BorderRadius.circular(6 * fem),
                      ),
                      child: ListView.builder(
                        itemCount: listHistoryWithdraw.length,
                        itemBuilder: (BuildContext context, int index) {
                          final transaction = listHistoryWithdraw[index];
                          return WithdrawCard(
                            icon: Icons.account_balance_wallet_outlined,
                            title: "Rút tiền",
                            time: transaction.time,
                            amount: transaction.amount,
                          );
                        },
                      )),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _showRequestTransactionDialog(BuildContext context) async {
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
                    "Yêu cầu rút tiền",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Số tiền rút",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 15, top: 10),
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    constraints: BoxConstraints(
                      maxWidth: 300,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(9 * fem),
                    ),
                    child: TextFormField(
                      controller: _InputMoneyController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChanged: (value) {
                        final numberFormat = NumberFormat("#,###");
                        final text = value.isNotEmpty
                            ? numberFormat.format(int.parse(value))
                            : '';
                        _InputMoneyController.value = TextEditingValue(
                          text: text,
                          selection:
                              TextSelection.collapsed(offset: text.length),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: '100.000',
                        border: InputBorder.none,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Thông tin tài khoản",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Dạng: Tên ngân hàng -STK - Tên",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.grey
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 5, top: 15),
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    constraints: BoxConstraints(
                      maxWidth: 300,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(9 * fem),
                    ),
                    child: TextFormField(
                      controller: _methodOneController,
                      decoration: InputDecoration(
                        hintText: 'Nhập phương thức chuyển khoản 1',
                        border: InputBorder.none,
                      ),
                    )
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20, top: 10),
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    constraints: BoxConstraints(
                      maxWidth: 300,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(9 * fem),
                    ),
                    child: TextFormField(
                      controller: _methodTwoController,
                      decoration: InputDecoration(
                        hintText: 'Nhập phương thức chuyển khoản 2',
                        border: InputBorder.none,
                      ),
                    )
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
                            onPressed: () async {
                              double amount = double.parse(_InputMoneyController.text.replaceAll(RegExp(r'[^\d]'), ''));
                              String method1 = _methodOneController.text;
                              String method2 = _methodTwoController.text;
                              try {
                                await ParkingAPI.requestWithdrawal(token, amount, method1, method2);
                                Navigator.pop(context);
                                _showSuccessfulDialog(context);
                              } catch (e) {

                              }
                            },
                            child: Text(
                              'Gửi',
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
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "Đã nhận yêu cầu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25 * fem),
                  child: Center(
                    child: Text(
                      "Quý khách sẽ nhận tiền sau 24h-48h",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 42 * fem,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(9 * fem),
                    ),
                    child: Center(
                      child: Text(
                        'Xong',
                        style: TextStyle(
                          fontSize: 16 * ffem,
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
        );
      },
    );
  }
}
