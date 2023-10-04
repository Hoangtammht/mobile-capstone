import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/PLOwnerUI/EditParkingInformation.dart';
import 'package:flutter/material.dart';

class ParkingInformation extends StatefulWidget {
  const ParkingInformation({Key? key}) : super(key: key);

  @override
  State<ParkingInformation> createState() => _ParkingInformationState();
}

class _ParkingInformationState extends State<ParkingInformation> {
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
          'THÔNG TIN BÃI XE GỬI XE',
          style: TextStyle(
            fontSize: 26 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8 * fem),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5 * fem, vertical :5 * fem),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100 * fem,
                      height: 60 * fem,
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeET9OkThGxXQWnPrfXR_2NY45Xn1cqtKJwXhtNx2bjjW8rM8fUwW-ChoZM-3FyzI0MmQ&usqp=CAU',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100 * fem,
                      height: 60 * fem,
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeET9OkThGxXQWnPrfXR_2NY45Xn1cqtKJwXhtNx2bjjW8rM8fUwW-ChoZM-3FyzI0MmQ&usqp=CAU',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100 * fem,
                      height: 60 * fem,
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeET9OkThGxXQWnPrfXR_2NY45Xn1cqtKJwXhtNx2bjjW8rM8fUwW-ChoZM-3FyzI0MmQ&usqp=CAU',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical :15 * fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(
                              text: 'Tên bãi: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18 * fem
                              )
                          ),
                          TextSpan(
                              text: 'Nguyễn Văn Thám',
                              style: TextStyle(
                                fontSize: 18,
                              )
                          )
                        ]
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical :15 * fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                                text: 'Địa chỉ: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18 * fem
                                )
                            ),
                            TextSpan(
                                text: '681A Đ. Nguyễn Huệ, Bến Nghé, Quận 1, TP HCM',
                                style: TextStyle(
                                  fontSize: 18 * fem,
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical :15 * fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                                text: 'Số chỗ đậu xe: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18 * fem
                                )
                            ),
                            TextSpan(
                                text: '20 chỗ',
                                style: TextStyle(
                                  fontSize: 18 * fem,
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical :15 * fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                                text: 'Chiều rộng (m): ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18 * fem
                                )
                            ),
                            TextSpan(
                                text: '50 m',
                                style: TextStyle(
                                  fontSize: 18 * fem,
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical :15 * fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                                text: 'Chiều dài (m): ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18 * fem
                                )
                            ),
                            TextSpan(
                                text: '50 m',
                                style: TextStyle(
                                  fontSize: 18 * fem,
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical :15 * fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                          children: [
                            TextSpan(
                                text: 'Mô tả: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18 * fem
                                )
                            ),
                            TextSpan(
                                text: 'bãi xe dành cho xe máy với nhiều chỗ trống và coi xe 24/24',
                                style: TextStyle(
                                  fontSize: 18 * fem,
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40 * fem,),
            InkWell(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => EditParkingInformation()));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    10 * fem, 0 * fem, 10 * fem, 0 * fem),
                height: 50 * fem,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(9 * fem),
                ),
                child: Center(
                  child: Text(
                    'Chỉnh sửa',
                    style: TextStyle(
                      fontSize: 19 * ffem,
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
  }
}
