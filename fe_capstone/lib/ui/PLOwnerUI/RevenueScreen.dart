import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/Withdraw.dart';
import 'package:fe_capstone/ui/components/widgetPLO/WithdrawCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({Key? key}) : super(key: key);

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  TextEditingController _InputMoneyController = TextEditingController();
  final NumberFormat currencyFormat = NumberFormat("#,###");
  List<Withdraw> generateFakeTransactions() {
    return [
      Withdraw(
        icon: Icons.account_balance_wallet_outlined,
        title: 'Rút tiền',
        time: '10:30 20-6-2023',
        amount: '-1.200.000',
      ),
      Withdraw(
        icon: Icons.account_balance_wallet_outlined,
        title: 'Rút tiền',
        time: '10:30 20-6-2023',
        amount: '-1.400.000',
      ),
      Withdraw(
        icon: Icons.account_balance_wallet_outlined,
        title: 'Rút tiền',
        time: '10:30 20-6-2023',
        amount: '-1.400.000',
      ),
      Withdraw(
        icon: Icons.account_balance_wallet_outlined,
        title: 'Rút tiền',
        time: '10:30 20-6-2023',
        amount: '-1.400.000',
      ),
      Withdraw(
        icon: Icons.account_balance_wallet_outlined,
        title: 'Rút tiền',
        time: '10:30 20-6-2023',
        amount: '-1.400.000',
      ),
      Withdraw(
        icon: Icons.account_balance_wallet_outlined,
        title: 'Rút tiền',
        time: '10:30 20-6-2023',
        amount: '-1.400.000',
      ),
    ];
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 10 * fem, 210 * fem, 0 * fem),
              child: Text(
                'Tổng doanh thu',
                style: TextStyle(
                  fontSize: 20 * ffem,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 5 * fem, 150 * fem, 0 * fem),
              child: Text(
                '36.000.000đ',
                style: TextStyle(
                  fontSize: 35 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2175 * ffem / fem,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(19 * fem, 0 * fem, 154 * fem, 5 * fem),
              padding:
                  EdgeInsets.fromLTRB(24.5 * fem, 14 * fem, 11 * fem, 15 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(9 * fem),
              ),
              child: InkWell(
                onTap: (){
                  _showRequestTransactionDialog(context);
                },
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
                      'Yêu cầu rút tiền',
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
              padding:
                  EdgeInsets.fromLTRB(15 * fem, 5 * fem, 17 * fem, 5 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(26 * fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 9 * fem),
                    child: Text(
                      'Doanh thu chi tiết',
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
                          child: Container(
                            margin: EdgeInsets.only(right: 7 * fem),
                            padding: EdgeInsets.fromLTRB(101 * fem, 7 * fem, 5 * fem, 7 * fem),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0x4c000000)),
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10 * fem),
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 24 * fem,
                                height: 24 * fem,
                                child: Icon(Icons.calendar_month_outlined),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7 * fem, right: 2 * fem),
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
                          child: Container(
                            margin: EdgeInsets.only(right: 7 * fem),
                            padding: EdgeInsets.fromLTRB(101 * fem, 7 * fem, 5 * fem, 7 * fem),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0x4c000000)),
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10 * fem),
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 24 * fem,
                                height: 24 * fem,
                                child: Icon(Icons.calendar_month_outlined),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )

                  ),
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(8 * fem, 0 * fem, 3 * fem, 0 * fem),
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
                          '6.000.000đ',
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
              margin:
                  EdgeInsets.fromLTRB(20 * fem, 0 * fem, 20 * fem, 29 * fem),
              width: double.infinity,
              height: 63 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        15 * fem, 13 * fem, 15 * fem, 15 * fem),
                    height: double.infinity,
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
                              fontSize: 10 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.175 * ffem / fem,
                              color: Color(0xff5b5b5b),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 3 * fem, 0 * fem),
                          child: Text(
                            '300',
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
                    height: double.infinity,
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
                            'Qua đêm',
                            style: TextStyle(
                              fontSize: 10 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.175 * ffem / fem,
                              color: Color(0xff5b5b5b),
                            ),
                          ),
                        ),
                        Container(
                          // 4wy (648:918)
                          margin: EdgeInsets.fromLTRB(
                              1 * fem, 0 * fem, 0 * fem, 0 * fem),
                          child: Text(
                            '120',
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
                    // frame40a9d (648:922)
                    padding: EdgeInsets.fromLTRB(
                        16 * fem, 15 * fem, 17 * fem, 12 * fem),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // banngyWJB (648:923)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 8 * fem),
                          child: Text(
                            'Ban Ngày',
                            style: TextStyle(
                              fontSize: 10 * ffem,
                              fontWeight: FontWeight.w400,
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
                            '180',
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
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // theothngHTM (648:920)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 6 * fem),
                          child: Text(
                            'Theo tháng',
                            style: TextStyle(
                              fontSize: 10 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.175 * ffem / fem,
                              color: Color(0xff5b5b5b),
                            ),
                          ),
                        ),
                        Container(
                          // oAo (648:921)
                          margin: EdgeInsets.fromLTRB(
                              6 * fem, 0 * fem, 0 * fem, 0 * fem),
                          child: Text(
                            '1',
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
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 218 * fem, 6 * fem),
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
              margin: EdgeInsets.fromLTRB(15 * fem, 0 * fem, 15 * fem, 0 * fem),
              padding:
                  EdgeInsets.fromLTRB(14 * fem, 10 * fem, 14 * fem, 0 * fem),
              width: double.infinity,
              height: 250 * fem,
              decoration: BoxDecoration(
                color: Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(6 * fem),
              ),
              child: ListView.builder(
                itemCount: generateFakeTransactions().length,
                itemBuilder: (BuildContext context, int index) {
                  final transaction = generateFakeTransactions()[index];
                  return WithdrawCard(
                    icon: transaction.icon,
                    title: transaction.title,
                    time: transaction.time,
                    amount: transaction.amount,
                  );
                },
              )
            ),
          ],
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
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
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
                      controller: _InputMoneyController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChanged: (value) {
                        final numberFormat = NumberFormat("#,###");
                        final text = value.isNotEmpty ? numberFormat.format(int.parse(value)) : '';
                        _InputMoneyController.value = TextEditingValue(
                          text: text,
                          selection: TextSelection.collapsed(offset: text.length),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: '100.000',
                        border: InputBorder.none,
                      ),
                    )

                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Nhập thông tin tài khoản",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20, top: 15),
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    constraints: BoxConstraints(
                      maxWidth: 300,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(9 * fem),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Nhập số tài khoảng và tên bank',
                        border: InputBorder.none,
                      ),
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, bottom: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Vui lòng nhập 2 phương thức trở lên",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
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
                              _showSuccessfulDialog(context);
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
                        color: Colors.grey
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    // frame33Xgs (651:190)
                    width:  double.infinity,
                    height:  42*fem,
                    decoration:  BoxDecoration (
                      color:  Theme.of(context).primaryColor,
                      borderRadius:  BorderRadius.circular(9*fem),
                    ),
                    child:
                    Center(
                      child:
                      Text(
                        'Xong',
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
              ],
            ),
          ),
        );
      },
    );
  }




}
