class RevenueModel {
  RevenueModel({
    required this.ploID,
    required this.balance,
    required this.history,
    required this.totalVehicle,
    required this.totalVehicleMethodDay,
    required this.totalVehicleMethodNight,
    required this.totalVehicleMethodOvernight,
  });
  late final String ploID;
  late final double balance;
  late final List<History> history;
  late final int totalVehicle;
  late final int totalVehicleMethodDay;
  late final int totalVehicleMethodNight;
  late final int totalVehicleMethodOvernight;

  RevenueModel.fromJson(Map<String, dynamic> json){
    ploID = json['ploID'] ?? '';
    balance = json['balance'] ?? 0.0;
    history = (json['history'] as List<dynamic>?)
        ?.map((e) => History.fromJson(e as Map<String, dynamic>))
        .toList() ?? [];
    totalVehicle = json['totalVehicle'] ?? 0;
    totalVehicleMethodDay = json['totalVehicleMethodDay'] ?? 0;
    totalVehicleMethodNight = json['totalVehicleMethodNight'] ?? 0;
    totalVehicleMethodOvernight = json['totalVehicleMethodOvernight'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ploID'] = ploID;
    _data['balance'] = balance;
    _data['history'] = history.map((e)=>e.toJson()).toList();
    _data['totalVehicle'] = totalVehicle;
    _data['totalVehicleMethodDay'] = totalVehicleMethodDay;
    _data['totalVehicleMethodNight'] = totalVehicleMethodNight;
    _data['totalVehicleMethodOvernight'] = totalVehicleMethodOvernight;
    return _data;
  }
}

class History {
  History({
    required this.historyID,
    required this.depositAmount,
    required this.transactionDate,
    required this.transactionResultDate,
  });
  late final int historyID;
  late final double depositAmount;
  late final String transactionDate;
  late final String transactionResultDate;

  History.fromJson(Map<String, dynamic> json){
    historyID = json['historyID'] ?? 0;
    depositAmount = json['depositAmount'] ?? 0.0;
    transactionDate = json['transactionDate'] ?? '';
    transactionResultDate = json['transactionResultDate'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['historyID'] = historyID;
    _data['depositAmount'] = depositAmount;
    _data['transactionDate'] = transactionDate;
    _data['transactionResultDate'] = transactionResultDate;
    return _data;
  }
}