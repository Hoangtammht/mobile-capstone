import 'package:fe_capstone/apis/customer/VehicleAPI.dart';
import 'package:fe_capstone/blocs/VehicleProvider.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ListVehicleCustomer.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/VehicleCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {

  TextEditingController _vehicleNumberController = TextEditingController();
  TextEditingController _vehicleNameController = TextEditingController();
  TextEditingController _vehicleColorController = TextEditingController();
  int vehicleID = 0;
  late VehicleProvider _vehicleProvider;
  late Future<List<ListVehicleCustomer>> vehicleFuture;

  @override
  void initState() {
    super.initState();
    _vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
  }

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
          'Danh sách xe',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Consumer<VehicleProvider>(
        builder: (context, vehicleProvider, child) {
          return FutureBuilder<List<ListVehicleCustomer>>(
            future: vehicleProvider.getVehicleList(),
            builder: (context, snapshot) {
              if (vehicleProvider.vehicles.isEmpty) {
                return InkWell(
                  onTap: () {
                    _showAddVehicleDialog(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    width: 138 * fem,
                    height: 42 * fem,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(9 * fem),
                    ),
                    child: Center(
                      child: Text(
                        'Thêm xe',
                        style: TextStyle(
                          fontSize: 25 * ffem,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: vehicleProvider.vehicles.length,
                    itemBuilder: (context, index) {
                      return VehicleCard(
                        vehicleNumber: vehicleProvider.vehicles[index].licensePlate, vehicleID: vehicleProvider.vehicles[index].motorbikeID,
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      _showAddVehicleDialog(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      width: 138 * fem,
                      height: 42 * fem,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Thêm xe',
                          style: TextStyle(
                            fontSize: 25 * ffem,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
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

                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Biển số', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child:
                      TextFormField(
                        controller: _vehicleNumberController,
                        decoration: const InputDecoration(
                          hintText: '12-A34567',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tên xe', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child:
                      TextFormField(
                        controller: _vehicleNameController,
                        decoration: const InputDecoration(
                          hintText: 'Air Blade 125',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Màu sắc', style: TextStyle(fontSize: 15,  fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(9 * fem),
                      ),
                      child:
                      TextFormField(
                        controller: _vehicleColorController,
                        decoration: const InputDecoration(
                          hintText: 'Đen',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
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
                            onPressed: () async {
                              String newlicensePlate =
                                  _vehicleNumberController.text;
                              String newMotorColor =
                                  _vehicleColorController.text;
                              String newMotorName = _vehicleNameController.text;
                              if (newlicensePlate.isNotEmpty &&
                                  newMotorColor.isNotEmpty &&
                                  newMotorName.isNotEmpty) {
                               try{
                                 await _vehicleProvider.addNewVehicle(newlicensePlate,newMotorColor,newMotorName);

                                 Navigator.of(context).pop();
                               }catch(e){
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Thêm xe thất bại'),
                                   ),
                                 );
                               }
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

}
