import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';

class OwnershipHistoryCard extends StatelessWidget {
  final String status;
  const OwnershipHistoryCard({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom :10 * fem),
            child: Text('Bãi xe: Nguyễn Anh Khoa', style: TextStyle(
              fontSize: 16 * fem,
              fontWeight: FontWeight.bold,
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(bottom :10 * fem),
            child: Row(
              children: [
                Text('Cập nhập: ', style: TextStyle(
                  fontSize: 16 * fem,
                  fontWeight: FontWeight.bold,
                ),),
                if(status == '1')
                Container(
                  width:  60*fem,
                  height: 20 * fem,
                  decoration:  BoxDecoration (
                    color:  Color(0xffff0000),
                    borderRadius:  BorderRadius.circular(25*fem),
                  ),
                  child: Center(
                    child:
                    Text(
                      'Xóa',
                      style:  TextStyle (
                        fontSize:  13*ffem,
                        fontWeight:  FontWeight.w400,
                        height:  1.175*ffem/fem,
                        color:  Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
                if(status == '2')
                Container(
                  width:  100*fem,
                  height: 20 * fem,
                  decoration:  BoxDecoration (
                    color:  Colors.green,
                    borderRadius:  BorderRadius.circular(25*fem),
                  ),
                  child: Center(
                    child:
                    Text(
                      'Chuyển nhượng',
                      style:  TextStyle (
                        fontSize:  13*ffem,
                        fontWeight:  FontWeight.w400,
                        height:  1.175*ffem/fem,
                        color:  Color(0xffffffff),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),

          RichText(
            text:
            TextSpan(
              style:  TextStyle (
                fontSize:  14*ffem,
                fontWeight:  FontWeight.w400,
                height:  1.175*ffem/fem,
                color:  Color(0xff000000),
              ),
              children:  [
                TextSpan(
                  text:  'Địa chỉ: ', style: TextStyle(
                  fontSize: 16 * fem,
                  fontWeight: FontWeight.bold,
                ),
                ),
                TextSpan(
                  text:  '6 Phạm Văn Đồng, phường 3, Gò Vấp, Hồ Chí Minh',
                  style:  TextStyle (
                    fontSize:  16*ffem,
                    fontWeight:  FontWeight.w400,
                    height:  1.175*ffem/fem,
                    color:  Color(0xff979797),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(''),
              Text('10/01/2022 - 10/03/2024')
            ],
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
