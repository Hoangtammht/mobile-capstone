import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ParkingInformationModel.dart';
import 'package:fe_capstone/models/RatingModel.dart';
import 'package:fe_capstone/ui/PLOwnerUI/EditParkingInformation.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/RatingCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParkingInformation extends StatefulWidget {
  const ParkingInformation({Key? key}) : super(key: key);

  @override
  State<ParkingInformation> createState() => _ParkingInformationState();
}

class _ParkingInformationState extends State<ParkingInformation> {

  late Future<ParkingInformationModel> parkingInformationFuture;
  late Future<List<RatingModel>> listRatingModelFuture;

  @override
  void initState() {
    super.initState();
    parkingInformationFuture = _getParkingInformationFuture();
    listRatingModelFuture = _getListRating();
  }

  Future<ParkingInformationModel> _getParkingInformationFuture() async {
      return ParkingAPI.getParkingInformation();
  }

  Future<List<RatingModel>> _getListRating() async {
      return ParkingAPI.getRatingList();
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
          'THÔNG TIN BÃI XE GỬI XE',
          style: TextStyle(
            fontSize: 30 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.175 * ffem / fem,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<ParkingInformationModel>(
                future: parkingInformationFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final parkingInformation = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot.connectionState == ConnectionState.waiting ? Text('Đang xử lý...',
                            style: TextStyle(
                          fontSize: 22 * fem,
                        )) :
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5 * fem, vertical :5 * fem),
                          child: Container(
                            height: 60 * fem,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: parkingInformation!.image.length,
                              itemBuilder: (context, index) {
                                final image = parkingInformation!.image[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100 * fem,
                                    height: 60 * fem,
                                    child: Image.network(
                                      image.imageLink,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
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
                                              fontSize: 22 * fem
                                          )
                                      ),
                                      TextSpan(
                                          text: snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : parkingInformation?.parkingName ?? '',
                                          style: TextStyle(
                                            fontSize: 22,
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
                                                fontSize: 22 * fem
                                            )
                                        ),
                                        TextSpan(
                                            text: snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : parkingInformation?.address ?? '',
                                            style: TextStyle(
                                              fontSize: 22 * fem,
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
                                                fontSize: 22 * fem
                                            )
                                        ),
                                        TextSpan(
                                            text: snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : (parkingInformation?.slot ?? '').toString(),
                                            style: TextStyle(
                                              fontSize: 22 * fem,
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
                                                fontSize: 22 * fem
                                            )
                                        ),
                                        TextSpan(
                                            text: snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : (parkingInformation?.width ?? '').toString(),
                                            style: TextStyle(
                                              fontSize: 22 * fem,
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
                                                fontSize: 22 * fem
                                            )
                                        ),
                                        TextSpan(
                                            text: snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : (parkingInformation?.length ?? '').toString(),
                                            style: TextStyle(
                                              fontSize: 22 * fem,
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
                                                fontSize: 22 * fem
                                            )
                                        ),
                                        TextSpan(
                                            text: snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : (parkingInformation?.description ?? '').toString(),
                                            style: TextStyle(
                                              fontSize: 22 * fem,
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
                                            text: 'Thời gian chờ: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22 * fem
                                            )
                                        ),
                                        TextSpan(
                                            text: snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : (parkingInformation?.waitingTime ?? '').toString(),
                                            style: TextStyle(
                                              fontSize: 22 * fem,
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
                                            text: 'Thời gian hủy đặt chỗ: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22 * fem
                                            )
                                        ),
                                        TextSpan(
                                            text: snapshot.connectionState == ConnectionState.waiting ? 'Đang tải...' : (parkingInformation?.cancelBookingTime ?? '').toString(),
                                            style: TextStyle(
                                              fontSize: 22 * fem,
                                            )
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    );
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical: 15 * fem),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đánh giá:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22 * fem,
                      ),
                    ),
                    SizedBox(height: 10 * fem),
                    Container(
                      height: 300 * fem,
                      child: FutureBuilder<List<RatingModel>>(
                        future: listRatingModelFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final listRating = snapshot.data;
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: listRating!.length,
                              itemBuilder: (context, index) {
                                return RatingCard(
                                  fromBy: listRating[index].fullName,
                                  star: listRating[index].star,
                                  content: listRating[index].content,
                                );
                              },
                            );
                          }
                        },
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(height: 20 * fem,),
              InkWell(
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => EditParkingInformation()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      10 * fem, 0 * fem, 10 * fem, 20 * fem),
                  height: 50 * fem,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(9 * fem),
                  ),
                  child: Center(
                    child: Text(
                      'Chỉnh sửa',
                      style: TextStyle(
                        fontSize: 25 * ffem,
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
      ),
    );
  }
}
