import 'package:fe_capstone/apis/customer/WalletScreenAPI.dart';
import 'package:fe_capstone/models/ResponseWalletCustomer.dart';
import 'package:flutter/material.dart';

class WalletDataProvider extends ChangeNotifier {
  late ResponseWalletCustomer _transactions;

  Future<ResponseWalletCustomer> getTransactions() async {
    _transactions = await WalletScreenAPI.getWalletScreenData();
    return _transactions;
  }

  Future<void> updateTransactions() async {
    await getTransactions();
    notifyListeners();
  }

}

