class ResponseWalletCustomer {
  ResponseWalletCustomer({
    required this.walletBalance,
    required this.historyBalanceCustomerList,
  });
  late final double walletBalance;
  late final List<HistoryBalanceCustomerList> historyBalanceCustomerList;

  ResponseWalletCustomer.fromJson(Map<String, dynamic> json) {
    walletBalance = json['wallet_balance'] ?? 0.0;
    historyBalanceCustomerList = (json['historyBalanceCustomerList'] != null)
        ? List.from(json['historyBalanceCustomerList'])
            .map((e) => HistoryBalanceCustomerList.fromJson(e))
            .toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['wallet_balance'] = walletBalance;
    _data['historyBalanceCustomerList'] =
        historyBalanceCustomerList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class HistoryBalanceCustomerList {
  HistoryBalanceCustomerList({
    required this.transactionID,
    required this.depositAmount,
    required this.rechargeTime,
    required this.bankCode,
  });
  late final int transactionID;
  late final double depositAmount;
  late final String rechargeTime;
  late final String bankCode;

  HistoryBalanceCustomerList.fromJson(Map<String, dynamic> json) {
    transactionID = json['transactionID'] ?? 0;
    depositAmount = json['depositAmount'] ?? 0.0;
    rechargeTime = json['rechargeTime'] ?? '';
    bankCode = json['bankCode'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transactionID'] = transactionID;
    _data['depositAmount'] = depositAmount;
    _data['rechargeTime'] = rechargeTime;
    _data['bankCode'] = bankCode;
    return _data;
  }
}
