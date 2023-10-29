import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/ParkingInformationModel.dart';
import 'package:fe_capstone/ui/screens/ChatScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/RatingScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/ReservationScreen.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/ListParkingCard.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/RatingStars.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showParkingDetail = false;
  String selectParkinglot = '';
  bool firstLoad = true;
  int status = 1;
  List<ParkingHomeScreen> fakeData = [
    ParkingHomeScreen(
        ploID: "PL0934328813",
        address: "678 đường 672 Phước Long B quận 9",
        parkingName: "Bãi xe Thịnh Nguyễn",
        slot: 10),
    ParkingHomeScreen(
        ploID: "PL0934328813",
        address: "678 đường  9",
        parkingName: "Bãi xe Thịnh Nguyễn",
        slot: 2),
    ParkingHomeScreen(
        ploID: "PL0934328813",
        address: " Phước Long B quận 9",
        parkingName: "Bãi xe Thịnh Nguyễn",
        slot: 6),
    ParkingHomeScreen(
        ploID: "PL0934328813",
        address: "678 đường Long B quận 9",
        parkingName: "Bãi xe Thịnh Nguyễn",
        slot: 9),
    ParkingHomeScreen(
        ploID: "PL0934328813",
        address: "678 đường 672 Phước Long ",
        parkingName: "Bãi xe Thịnh Nguyễn",
        slot: 11)
  ];


  void showParkingDetailContent(String ploID) {
    setState(() {
      showParkingDetail = true;
      selectParkinglot = ploID;
    });
  }

  void handleFirstLoadButton() {
    setState(() {
      firstLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin:
                EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 189.84 * fem),
            padding:
                EdgeInsets.fromLTRB(14 * fem, 72 * fem, 14 * fem, 36 * fem),
            width: double.infinity,
            height: 220 * fem,
            decoration: BoxDecoration(
              color: Color(0xff6ec2f7),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(23 * fem),
                bottomLeft: Radius.circular(23 * fem),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 40 * fem),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 248.88 * fem, 0 * fem),
                        child: Text(
                          'PARCO',
                          style: TextStyle(
                            fontSize: 30 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.2175 * ffem / fem,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
                        width: 25 * fem,
                        height: 24 * fem,
                        child: Icon(Icons.wallet),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(2 * fem, 0 * fem, 0 * fem, 0 * fem),
                  padding:
                      EdgeInsets.fromLTRB(19 * fem, 0 * fem, 14 * fem, 0 * fem),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(9 * fem),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 46 * fem,
                        width: 280 * fem,
                        child: TextFormField(
                          maxLines: 1, // Chỉ cho phép nhập 1 dòng chữ
                          decoration: InputDecoration(
                            hintText: 'Bạn muốn đi đến đâu?',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 9 * fem, 0 * fem),
                        width: 1 * fem,
                        height: 46 * fem,
                        decoration: BoxDecoration(
                          color: Color(0x7f000000),
                        ),
                      ),
                      Container(
                        width: 16 * fem,
                        height: 16 * fem,
                        child: Icon(
                          Icons.search,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              if (status == 2) {
                return CheckInContent(scrollController);
              } else if (status == 3) {
                return CheckOutContent(scrollController);
              } else {
                if (showParkingDetail) {
                  return ParkingDetailContent(
                    scrollController: scrollController,
                    showParkingDetailContent: showParkingDetailContent,
                    ploID: selectParkinglot,
                    closeParkingDetail: () {
                      setState(() {
                        showParkingDetail = false;
                      });
                    },
                  );
                } else {
                  return HomeScreenContent(
                      scrollController,
                      showParkingDetail,
                      showParkingDetailContent,
                      fakeData,
                      firstLoad,
                      handleFirstLoadButton);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

//Status = 1
class HomeScreenContent extends StatefulWidget {
  final ScrollController scrollController;
  final bool showParkingDetail;
  final Function showParkingDetailContent;
  final List<ParkingHomeScreen> fakeData;
  final firstLoad;
  final Function handleFistLoadButton;

  HomeScreenContent(
      this.scrollController,
      this.showParkingDetail,
      this.showParkingDetailContent,
      this.fakeData,
      this.firstLoad,
      this.handleFistLoadButton);

  @override
  HomeScreenContentState createState() => HomeScreenContentState();
}

class HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    final count = widget.fakeData.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            controller: widget.scrollController,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26 * fem),
                    topRight: Radius.circular(26 * fem),
                  ),
                  border: Border.all(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 10 * fem,
                          bottom: 12 * fem,
                        ),
                        width: 90 * fem,
                        height: 5 * fem,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30 * fem),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15 * fem),
                        child: Text(
                          'BÃI ĐỖ GẦN ĐÂY ${ widget.firstLoad ? '' : '($count)'}',
                          style: TextStyle(
                            fontSize: 25 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.175 * ffem / fem,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5 * fem),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      if (!widget.firstLoad)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(''),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 64 * fem,
                                  height: 20 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xff5b5b5b)),
                                    color: Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Rẻ nhất',
                                      style: TextStyle(
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff5b5b5b),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5 * fem),
                                  width: 64 * fem,
                                  height: 20 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xff5b5b5b)),
                                    color: Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Gần nhất',
                                      style: TextStyle(
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff5b5b5b),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                    ]),
              ),
              if (widget.firstLoad)
                Container(

                  margin: EdgeInsets.only(top: 50 * fem, right: 40 * fem, left: 40 * fem),
                  width: 80 * fem,
                  height: 50 * fem,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(9 * fem),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x82000000),
                        offset: Offset(0 * fem, 4 * fem),
                        blurRadius: 10 * fem,
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      widget.handleFistLoadButton();
                    },
                    child: Center(
                      child: Text(
                        'Tìm kiếm bãi đỗ gần đây',
                        textAlign: TextAlign.center,
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
              if (!widget.firstLoad)
                Container(
                    height: 350 * fem,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                widget.showParkingDetailContent(
                                    widget.fakeData[index].ploID);
                              },
                              child: ListParkingCard(widget.fakeData[index]));
                        }))
            ],
          ),
        ),
      ],
    );
  }
}

class ParkingDetailContent extends StatefulWidget {
  final ScrollController scrollController;
  final Function showParkingDetailContent;
  final Function closeParkingDetail;
  final String ploID;

  const ParkingDetailContent({
    required this.scrollController,
    required this.showParkingDetailContent,
    required this.closeParkingDetail,
    required this.ploID,
  });

  @override
  State<ParkingDetailContent> createState() => _ParkingDetailContentState();
}

//Detail Parking lot
class _ParkingDetailContentState extends State<ParkingDetailContent> {
  late String ploID;
  Future<ParkingLotDetail>? parkingLotFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parkingLotFuture = _getParkingLotFuture();
    ploID = widget.ploID;
  }

  Future<ParkingLotDetail> _getParkingLotFuture() async {
    return ParkingAPI.getParkingLotDetail(widget.ploID);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder<ParkingLotDetail>(
            future: parkingLotFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                ParkingLotDetail parkingLotDetail = snapshot.data!;

                return (Expanded(
                  child: ListView(
                    controller: widget.scrollController,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26 * fem),
                            topRight: Radius.circular(26 * fem),
                          ),
                          border: Border.all(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 20 * fem,
                                  bottom: 25 * fem,
                                ),
                                width: 85 * fem,
                                height: 3 * fem,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25 * fem),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10 * fem, right: 10 * fem, top: 5 * fem),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  parkingLotDetail.parkingName,
                                  style: TextStyle(
                                      fontSize: 30 * fem,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  onPressed: () {
                                    widget.closeParkingDetail();
                                  },
                                  icon: Icon(Icons.close),
                                )
                              ],
                            ),
                            Text(
                              parkingLotDetail.address,
                              style: TextStyle(
                                  fontSize: 18 * fem, color: Colors.grey),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5 * fem),
                              child: RatingStars(rating: parkingLotDetail.star),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5 * fem),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        15 * fem, 10 * fem, 15 * fem, 8 * fem),
                                    height: 50 * fem,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius:
                                          BorderRadius.circular(6 * fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(bottom: 6 * fem),
                                          child: Text(
                                            'Sáng',
                                            style: TextStyle(
                                              fontSize: 15 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.175 * ffem / fem,
                                              color: Color(0xff5b5b5b),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          parkingLotDetail.morningFee
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10 * fem,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        15 * fem, 10 * fem, 15 * fem, 8 * fem),
                                    height: 50 * fem,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius:
                                          BorderRadius.circular(6 * fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(bottom: 6 * fem),
                                          child: Text(
                                            'Tối',
                                            style: TextStyle(
                                              fontSize: 15 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.175 * ffem / fem,
                                              color: Color(0xff5b5b5b),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          parkingLotDetail.eveningFee
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10 * fem,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        15 * fem, 10 * fem, 15 * fem, 8 * fem),
                                    height: 50 * fem,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius:
                                          BorderRadius.circular(6 * fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(bottom: 6 * fem),
                                          child: Text(
                                            'Qua đêm',
                                            style: TextStyle(
                                              fontSize: 15 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.175 * ffem / fem,
                                              color: Color(0xff5b5b5b),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          parkingLotDetail.overnightFee
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10 * fem,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        12 * fem, 10 * fem, 12 * fem, 8 * fem),
                                    height: 50 * fem,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius:
                                          BorderRadius.circular(6 * fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(bottom: 6 * fem),
                                          child: Text(
                                            'Chỗ trống',
                                            style: TextStyle(
                                              fontSize: 15 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.175 * ffem / fem,
                                              color: Color(0xff5b5b5b),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          parkingLotDetail.currentSlot
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10 * fem,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        20 * fem, 10 * fem, 20 * fem, 8 * fem),
                                    height: 50 * fem,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius:
                                          BorderRadius.circular(6 * fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(bottom: 6 * fem),
                                          child: Text(
                                            'Cách',
                                            style: TextStyle(
                                              fontSize: 15 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.175 * ffem / fem,
                                              color: Color(0xff5b5b5b),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '5m',
                                          style: TextStyle(
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10 * fem),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RatingScreen(ploID: ploID)));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10 * fem,
                                          10 * fem, 10 * fem, 10 * fem),
                                      margin: EdgeInsets.only(right: 10 * fem),
                                      width: 137 * fem,
                                      decoration: BoxDecoration(
                                        color: Color(0xffdcdada),
                                        borderRadius:
                                            BorderRadius.circular(6 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Xem đánh giá',
                                          style: TextStyle(
                                            fontSize: 20 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReservationScreen()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10 * fem,
                                          10 * fem, 10 * fem, 10 * fem),
                                      width: 137 * fem,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(6 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Đặt chỗ gửi',
                                          style: TextStyle(
                                            fontSize: 20 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.175 * ffem / fem,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 200 * fem,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    for (var imageUrl
                                        in parkingLotDetail.images)
                                      InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5 * fem),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10 * fem),
                                            child: Image.network(
                                              imageUrl.imageLink,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ));
              }
            })
      ],
    );
  }
}

//Status = 2
class CheckInContent extends StatelessWidget {
  final ScrollController scrollController;

  const CheckInContent(this.scrollController);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15 * fem),
                    topRight: Radius.circular(15 * fem),
                  ),
                  // border: Border.all(
                  //   color: Colors.yellow,
                  //   width: 2.3,
                  // ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.yellow,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10 * fem, right: 10 * fem, top: 15 * fem),
                        child: Text(
                          'Đang trên đường tới...',
                          style: TextStyle(
                            fontSize: 18 * fem,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffe7c200),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Khách sạn Romantic',
                                    style: TextStyle(
                                        fontSize: 18 * fem,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '681A Đ. Nguyễn Huệ, Bến Nghé, Quận 1, TP HCM',
                                    style: TextStyle(
                                      fontSize: 14 * fem,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 2 * fem),
                                  child: Image.asset(
                                      'assets/images/directionImage.png'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 2 * fem),
                                  child: Image.asset(
                                      'assets/images/chatImage.png'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                        child: Container(
                          margin: EdgeInsets.only(top: 10 * fem),
                          padding: EdgeInsets.only(
                              top: 30 * fem,
                              bottom: 30 * fem,
                              left: 20 * fem,
                              right: 20 * fem),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 8 * fem, 10 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Phí gửi xe',
                                        style: TextStyle(
                                          fontSize: 12 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '3.000đ',
                                      style: TextStyle(
                                        fontSize: 19 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2175 * ffem / fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 1 * fem, 17 * fem),
                                width: double.infinity,
                                height: 24 * fem,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Trạng thái',
                                        style: TextStyle(
                                          fontSize: 12 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 75 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff9f7e4),
                                        borderRadius:
                                            BorderRadius.circular(100 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Đang tới',
                                          style: TextStyle(
                                            fontSize: 10 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.175 * ffem / fem,
                                            color: Color(0xffe7c200),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 20 * fem, 7 * fem, 15 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Bãi đỗ',
                                        style: TextStyle(
                                          fontSize: 13 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Khách sạn Romantic',
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 9 * fem, 8 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Phương thức',
                                        style: TextStyle(
                                          fontSize: 13 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Ban ngày',
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 5 * fem, 9 * fem, 9 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Số lượng chỗ',
                                        style: TextStyle(
                                          fontSize: 13 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Phương tiện',
                                        style: TextStyle(
                                          fontSize: 13 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '45A-54321',
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                        child: Container(
                          margin: EdgeInsets.only(top: 15 * fem),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(''),
                              Image.asset('assets/images/deleteImage.png')
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10 * fem, right: 10 * fem, bottom: 10 * fem),
                        child: Center(
                            child: Text(
                          'Check-in',
                          style: TextStyle(
                              fontSize: 24 * fem,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//Status = 3
class CheckOutContent extends StatelessWidget {
  final ScrollController scrollController;

  const CheckOutContent(this.scrollController);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15 * fem),
                    topRight: Radius.circular(15 * fem),
                  ),
                  // border: Border.all(
                  //   color: Colors.yellow,
                  //   width: 2.3,
                  // ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.green,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10 * fem, right: 10 * fem, top: 15 * fem),
                        child: Text(
                          'Đang trong bãi...',
                          style: TextStyle(
                            fontSize: 18 * fem,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Khách sạn Romantic',
                                    style: TextStyle(
                                        fontSize: 18 * fem,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '681A Đ. Nguyễn Huệ, Bến Nghé, Quận 1, TP HCM',
                                    style: TextStyle(
                                      fontSize: 14 * fem,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 2 * fem),
                                  child: Image.asset(
                                    'assets/images/directionImageGreen.png',
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: ChatScreen(),
                                      withNavBar: false,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 2 * fem),
                                    child: Image.asset(
                                        'assets/images/chatImageGreen.png'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                        child: Container(
                          margin: EdgeInsets.only(top: 10 * fem),
                          padding: EdgeInsets.only(
                              top: 30 * fem,
                              bottom: 30 * fem,
                              left: 20 * fem,
                              right: 20 * fem),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 8 * fem, 10 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Phí gửi xe',
                                        style: TextStyle(
                                          fontSize: 12 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '3.000đ',
                                      style: TextStyle(
                                        fontSize: 19 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2175 * ffem / fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 1 * fem, 17 * fem),
                                width: double.infinity,
                                height: 24 * fem,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Trạng thái',
                                        style: TextStyle(
                                          fontSize: 12 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 75 * fem,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE4F6E6),
                                        borderRadius:
                                            BorderRadius.circular(100 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Trong bãi',
                                          style: TextStyle(
                                            fontSize: 10 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.175 * ffem / fem,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 20 * fem, 7 * fem, 15 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Bãi đỗ',
                                        style: TextStyle(
                                          fontSize: 13 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Khách sạn Romantic',
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 9 * fem, 8 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Phương thức',
                                        style: TextStyle(
                                          fontSize: 13 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Ban ngày',
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 5 * fem, 9 * fem, 9 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Số lượng chỗ',
                                        style: TextStyle(
                                          fontSize: 13 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10 * fem),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Phương tiện',
                                        style: TextStyle(
                                          fontSize: 13 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '45A-54321',
                                      style: TextStyle(
                                        fontSize: 16 * fem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10 * fem, right: 10 * fem, top: 20 * fem),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Center(
                              child: Text(
                            'Check-out',
                            style: TextStyle(
                                fontSize: 24 * fem,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          )),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
