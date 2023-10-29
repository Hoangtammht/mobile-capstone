import 'package:fe_capstone/apis/customer/VehicleAPI.dart';
import 'package:fe_capstone/blocs/VehicleProvider.dart';
import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleCard extends StatefulWidget {
  final String vehicleNumber;
  final int vehicleID;

  const VehicleCard({Key? key, required this.vehicleNumber, required this.vehicleID}) : super(key: key);

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  late VehicleProvider _vehicleProvider;

  @override
  void initState() {
    super.initState();
    _vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.vehicleNumber,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22 * fem),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleDeleteVehicle(BuildContext context) async {
    try {
      await _vehicleProvider.deleteVehicle(widget.vehicleID);
      Navigator.of(context).pop();
    } catch (error) {
      print('Lỗi khi xóa xe: $error');
    }
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    final confirmed = await showDialog(
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
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  constraints: BoxConstraints(
                    maxWidth: 300,
                  ),
                  child: Text(
                    'Xóa biển số xe ${widget.vehicleNumber} khỏi tài khoản của bạn?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
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
                            color: Color(0xffb3abab),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 22,
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
                            color: Color(0xffb3abab), // Đường thẳng ngang
                          ),
                          TextButton(
                            onPressed: () {
                            _handleDeleteVehicle(context);
                            },
                            child: Text(
                              'Xóa',
                              style: TextStyle(
                                fontSize: 22,
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
