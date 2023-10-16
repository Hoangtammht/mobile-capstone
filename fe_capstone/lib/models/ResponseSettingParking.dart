class ResponseSettingParking {
  ResponseSettingParking({
    required this.ploID,
    required this.methodList,
  });
  late final String ploID;
  late final List<MethodList> methodList;

  ResponseSettingParking.fromJson(Map<String, dynamic> json){
    ploID = json['ploID'] ?? '';
    methodList = (json['methodList'] != null)
        ? List.from(json['methodList']).map((e) => MethodList.fromJson(e)).toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ploID'] = ploID;
    _data['methodList'] = methodList.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class MethodList {
  MethodList({
    required this.methodID,
    required this.methodName,
    required this.startTime,
    required this.endTime,
    required this.price,
  });
  late final int methodID;
  late final String methodName;
  late final String startTime;
  late final String endTime;
  late final double price;

  MethodList.fromJson(Map<String, dynamic> json){
    methodID = json['methodID'] ?? 0;
    methodName = json['methodName'] ?? '';
    startTime = json['startTime'] ?? '';
    endTime = json['endTime'] ?? '';
    price = json['price'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['methodID'] = methodID;
    _data['methodName'] = methodName;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    _data['price'] = price;
    return _data;
  }
}