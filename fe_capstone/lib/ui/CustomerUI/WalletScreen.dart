import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/Transaction.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/TransactionCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController _InputMoneyController = TextEditingController();
  final NumberFormat currencyFormat = NumberFormat("#,###");

  final List<Transaction> transactions = [
    Transaction(
      icon: Icons.wallet,
      title: 'Nạp tiền',
      date: '10:30 20-6-2023',
      amount: '+200.000',
    ),
    Transaction(
      icon: Icons.wallet,
      title: 'Nạp tiền',
      date: '10:30 20-6-2023',
      amount: '+200.000',
    ),
    Transaction(
      icon: Icons.wallet,
      title: 'Nạp tiền',
      date: '10:30 20-6-2023',
      amount: '+200.000',
    ),
    Transaction(
      icon: Icons.wallet,
      title: 'Nạp tiền',
      date: '10:30 20-6-2023',
      amount: '+200.000',
    ),
    Transaction(
      icon: Icons.wallet,
      title: 'Nạp tiền',
      date: '10:30 20-6-2023',
      amount: '+200.000',
    ),
    Transaction(
      icon: Icons.wallet,
      title: 'Nạp tiền',
      date: '10:30 20-6-2023',
      amount: '+200.000',
    ),
    Transaction(
      icon: Icons.wallet,
      title: 'Nạp tiền',
      date: '10:30 20-6-2023',
      amount: '+200.000',
    ),
    Transaction(
      icon: Icons.wallet,
      title: 'Nạp tiền',
      date: '10:30 20-6-2023',
      amount: '+200.000',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 844 * fem,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(26 * fem),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0 * fem,
              top: 0 * fem,
              child: Container(
                width: 390 * fem,
                height: 208 * fem,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Text(
                    'VÍ TIỀN',
                    style: TextStyle(
                      fontSize: 26 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.175 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0 * fem,
              right: 0 * fem,
              top: 164 * fem,
              child: Align(
                child: SizedBox(
                  width: 390 * fem,
                  height: 678 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(23 * fem),
                        topRight: Radius.circular(23 * fem),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 19 * fem,
              top: 190 * fem,
              child: Align(
                child: SizedBox(
                  width: 52 * fem,
                  height: 23 * fem,
                  child: Text(
                    'Số dư',
                    style: TextStyle(
                      fontSize: 19 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.175 * ffem / fem,
                      color: Color(0xff9e9e9e),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 19 * fem,
              top: 232 * fem,
              child: Align(
                child: SizedBox(
                  width: 191 * fem,
                  height: 48 * fem,
                  child: Text(
                    '300.000đ',
                    style: TextStyle(
                      fontSize: 30 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2175 * ffem / fem,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 14 * fem,
              top: 289 * fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    24.5 * fem, 14 * fem, 23 * fem, 15 * fem),
                width: 160 * fem,
                height: 52 * fem,
                decoration: BoxDecoration(
                  color: Color(0xff000000),
                  borderRadius: BorderRadius.circular(9 * fem),
                ),
                child: InkWell(
                  onTap: (){
                    _showAddNewTransactionDialog(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 12 * fem, 0 * fem),
                        width: 22 * fem,
                        height: 18 * fem,
                        child: Icon(Icons.wallet, color: Colors.white, size: 25,),
                      ),
                      Text(
                        'Nạp tiền',
                        style: TextStyle(
                          fontSize: 19 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.175 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 19 * fem,
              right: 19 * fem,
              top: 372 * fem,
              child: Container(
                width: 354 * fem,
                height: 367 * fem,
                decoration: BoxDecoration(
                  color: Color(0xfff8f8f8),
                  borderRadius: BorderRadius.circular(6 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16*fem), // Thay đổi top để giảm khoảng cách
                      child: Text(
                        'Lịch sử giao dịch',
                        style: TextStyle(
                          fontSize: 19 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.175 * ffem / fem,
                          color: Color(0xff5b5b5b),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 8), // Thay đổi giá trị top tại đây
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          return TransactionCard(transaction: transaction);
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddNewTransactionDialog(BuildContext context) async {
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
                    "Số tiền nạp",
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
                            color: Color(0xffb3abab), // Đường thẳng ngang
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _showConfirmTransactionDialog(context);
                            },
                            child: Text(
                              'Nạp',
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

  Future<void> _showConfirmTransactionDialog(BuildContext context) async {
    String formattedText = _InputMoneyController.text.replaceAll(',', '');
    double amount = double.parse(formattedText);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: const Color(0xffffffff),
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      "Nạp ${currencyFormat.format(amount)}đ vào tài khoản của bạn?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center, // Căn giữa dọc
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
                            color: Color(0xffb3abab), // Đường thẳng ngang
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Đóng hộp thoại
                            },
                            child: Text(
                              'Xác nhận',
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
