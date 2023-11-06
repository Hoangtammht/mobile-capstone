import 'dart:async';
import 'dart:convert';

import 'package:fe_capstone/apis/customer/HomeAPI.dart';
import 'package:fe_capstone/apis/customer/ReservationAPI.dart';
import 'package:fe_capstone/apis/customer/SearchParkingAPI.dart';
import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/apis/customer/WalletScreenAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/constant/base_constant.dart';
import 'package:fe_capstone/constant/url_constants.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/CustomerHome.dart';
import 'package:fe_capstone/models/Parking.dart';
import 'package:fe_capstone/models/ParkingInformationModel.dart';
import 'package:fe_capstone/models/ResponseWalletCustomer.dart';
import 'package:fe_capstone/ui/screens/ChatScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/RatingScreen.dart';
import 'package:fe_capstone/ui/CustomerUI/ReservationScreen.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/ListParkingCard.dart';
import 'package:fe_capstone/ui/components/widgetCustomer/RatingStars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

typedef MethodCallback = void Function(int method);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showParkingDetail = false;
  String selectParkinglot = '';
  bool isSendRating = false;
  bool isCheckedAccount = false;
  String distance = '';

  void showParkingDetailContent(Parking parking) {
    setState(() {
      showParkingDetail = true;
      selectParkinglot = parking.ploID;
      distance = (parking.distance * 1000).toStringAsFixed(0);
    });
  }

  VietmapController? _mapController;
  List<Marker> temp = [];
  UserLocation? userLocation;

  late double lat;
  late double long;

  late TextEditingController _searchController = TextEditingController();

  List<dynamic> autoSearchResults = [];
  bool showSearchResults = false;
  late List<Parking> parkingList = [];
  bool isRatingDialogDisplayed = false;
  Future<CustomerHome>? customerHome;
  late double accountBalance;
  FocusNode _searchFocusNode = FocusNode();
  WebSocketChannel channel = IOWebSocketChannel.connect('wss://eparkingcapstone.azurewebsites.net/privateReservation');
  late int reservationID = 0;

  @override
  void initState() {
    super.initState();
    print('loading');
    customerHome = _getHomeStatus();
    customerHome!.then((data) {
      reservationID = data.reservationID;
      if (data.statusID == 5) {
        if (!isRatingDialogDisplayed) {
          _RatingDialog(context, data);
          setState(() {
            isRatingDialogDisplayed = true;
          });
        }
      }
        if(reservationID != 0){
          final message = {
            "reservationID": reservationID.toString(),
            "content": "Connected",
          };
          final messageJson = jsonEncode(message);
          channel.sink.add(messageJson);
          channel.stream.listen((message) {
            handleMessage(message);
          });
          bool isLoggedIn = UserPreferences.isLoggedIn();
          if (isLoggedIn) {
            const duration = Duration(minutes: 3);
            Timer.periodic(duration, (Timer t) {
              final message = {
                "reservationID": reservationID.toString(),
                "content": "KeepAlive",
              };
              final messageJson = jsonEncode(message);
              if (channel.sink != null) {
                channel.sink.add(messageJson);
                print('KeepAlive message sent successfully.');
              } else {
                print('Channel sink is closed. KeepAlive message not sent.');
                t.cancel();
              }
            });
          }
        }
    });
    Future.delayed(Duration(seconds: 4), () async {
      if (!isCheckedAccount) {
        await checkWalletCustomer();
        checkAccount();
        isCheckedAccount = true;
      }
    });
  }

  void handleMessage(dynamic message) {
    print(message.toString());
    if (message.toString().contains("GetStatus")) {
      customerHome = _getHomeStatus();
      customerHome!.then((data) {
        reservationID = data.reservationID;
        if (data.statusID == 5) {
          if (!isRatingDialogDisplayed) {
            _RatingDialog(context, data);
            setState(() {
              isRatingDialogDisplayed = true;
            });
          }
        }
      });
    }
  }

  void refreshHomeScreen() {
    setState(() {
      customerHome = _getHomeStatus();
      customerHome!.then((data) {
        reservationID = data.reservationID;
        print('Reservation hiện tại là: ${reservationID}');
        final message = {
          "reservationID": reservationID.toString(),
          "content": "Connected",
        };
        final messageJson = jsonEncode(message);
        channel.sink.add(messageJson);
        channel.stream.listen((message) {
          handleMessage(message);
        });
      });
    });

    bool isLoggedIn = UserPreferences.isLoggedIn();
    if (isLoggedIn) {
      const duration = Duration(minutes: 3);
      Timer.periodic(duration, (Timer t) {
        final message = {
          "reservationID": reservationID.toString(),
          "content": "KeepAlive",
        };
        final messageJson = jsonEncode(message);
        if (channel.sink != null) {
          channel.sink.add(messageJson);
          print('KeepAlive message sent successfully.');
        } else {
          print('Channel sink is closed. KeepAlive message not sent.');
          t.cancel();
        }
      });
    }

  }

  Future<double> checkWalletCustomer() async {
    ResponseWalletCustomer responseWalletCustomer =
        await WalletScreenAPI.getWalletScreenData();
    accountBalance = responseWalletCustomer.walletBalance;
    print('Số tiền trong ví là: $accountBalance');
    return accountBalance;
  }

  void handleRating() {
    setState(() {
      isRatingDialogDisplayed = true;
    });
  }

  Future<CustomerHome> _getHomeStatus() {
    return HomeAPI.getHomeStatus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    channel.sink.close();
    super.dispose();
  }

  void checkAccount() {
    if (accountBalance < 10000) {
      String formattedBalance = accountBalance
          .toStringAsFixed(0)
          .replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]}.');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Thông báo", style: TextStyle(fontSize: 24 * fem)),
            content: Text(
                "Số dư tài khoản của bạn chỉ còn $formattedBalanceđ. Vui lòng nạp tiền!",
                style: TextStyle(fontSize: 20 * fem)),
            actions: <Widget>[
              TextButton(
                child: Text("Đóng", style: TextStyle(fontSize: 18 * fem)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _onMapCreated(VietmapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude;
      long = position.longitude;
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serverEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serverEnabled) {
      return Future.error('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location services are disabled');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permanently denied disabled, We cannot request permission');
    }
    return await Geolocator.getCurrentPosition();
  }

  void performAutoSearch(String searchText) async {
    double circleRadius = 200.0;
    String url =
        '${BaseConstants.VIETMAP_URL}/autocomplete/v3?apikey=${BaseConstants.VIET_MAP_APIKEY}&text=$searchText';
    try {
      var dio = Dio();
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        var data = response.data;
        setState(() {
          autoSearchResults = data;
        });
      } else {
        print('AutoSearch Request Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('AutoSearch Request Failed with error: $e');
    }
  }

  Future<void> _fetchParkingList(
      double latitude, double longitude, int method, double radius) async {
    double radius = 5.0;
    try {
      List<Parking> fetchedParkingList = await SearchParkingAPI.findParkingList(
          latitude, longitude, method, radius);
      setState(() {
        parkingList = fetchedParkingList;
      });
    } catch (e) {
      print('Error fetching parking list: $e');
    }
  }

  void getLatAndLong(String refId) async {
    String url =
        "${BaseConstants.VIETMAP_URL}/place/v3?apikey=${BaseConstants.VIET_MAP_APIKEY}&refid=$refId";
    try {
      var dio = Dio();
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        var data = response.data;
        setState(() async {
          lat = data['lat'];
          long = data['lng'];
          showSearchResults = false;
          temp.clear();
          _mapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(lat, long), zoom: 15, tilt: 60)));

          temp.add(Marker(
              alignment: Alignment.bottomCenter,
              width: 50,
              height: 50,
              child: Container(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              latLng: LatLng(lat, long)));

          await _fetchParkingList(lat, long, 1, 5.0);

          if (parkingList != null && parkingList.isNotEmpty) {
            for (var parking in parkingList) {
              temp.add(Marker(
                alignment: Alignment.bottomCenter,
                width: 50,
                height: 50,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.local_parking_outlined,
                    color: Colors.green,
                    size: 40,
                  ),
                ),
                latLng: LatLng(parking.latitude, parking.longitude),
              ));
            }
          }
        });
      } else {
        print('AutoSearch Request Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('AutoSearch Request Failed with error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 180 * fem,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 400 * fem,
              child: VietmapGL(
                myLocationEnabled: true,
                styleString:
                    '${BaseConstants.VIETMAP_URL}/maps/light/styles.json?apikey=${BaseConstants.VIET_MAP_APIKEY}',
                trackCameraPosition: true,
                onMapCreated: _onMapCreated,
                compassEnabled: false,
                onMapRenderedCallback: () {
                  _mapController?.animateCamera(CameraUpdate.newCameraPosition(
                      const CameraPosition(
                          target: LatLng(10.739031, 106.680524),
                          zoom: 10,
                          tilt: 60)));
                },
                onUserLocationUpdated: (location) {
                  setState(() {
                    userLocation = location;
                  });
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(10.739031, 106.680524), zoom: 14),
                onMapClick: (point, coordinates) async {
                  var data =
                      await _mapController?.queryRenderedFeatures(point: point);
                },
              ),
            ),
          ),
          if (_mapController != null)
            Positioned(
              top: 200 * fem,
              left: 0,
              right: 0,
              bottom: 0,
              child: MarkerLayer(
                ignorePointer: true,
                mapController: _mapController!,
                markers: [],
              ),
            ),
          if (_mapController != null)
            Positioned(
              top: 200 * fem,
              left: 0,
              right: 0,
              bottom: 0,
              child: MarkerLayer(
                ignorePointer: true,
                mapController: _mapController!,
                markers: temp,
              ),
            ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding:
                  EdgeInsets.fromLTRB(14 * fem, 62 * fem, 14 * fem, 26 * fem),
              width: double.infinity,
              height: 200 * fem,
              decoration: BoxDecoration(
                color: Color(0xff6ec2f7),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(23 * fem),
                  bottomLeft: Radius.circular(23 * fem),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 30 * fem),
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
                    padding: EdgeInsets.fromLTRB(
                        19 * fem, 0 * fem, 14 * fem, 0 * fem),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(9 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 46 * fem,
                          width: 320 * fem,
                          child: TextFormField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Bạn muốn đi đến đâu?',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              performAutoSearch(value);
                              setState(() {
                                showSearchResults = true;
                              });
                            },
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
                        InkWell(
                          onTap: () {
                            performAutoSearch(_searchController.text);
                            setState(() {
                              showSearchResults = true;
                            });
                          },
                          child: Container(
                            width: 16 * fem,
                            height: 16 * fem,
                            child: Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 165,
            left: 0,
            right: 0,
            child: showSearchResults
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16 * fem),
                    child: Container(
                      height: 220 * fem,
                      decoration: BoxDecoration(color: Colors.white),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: autoSearchResults.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(autoSearchResults[index]['name']),
                            subtitle: Text(autoSearchResults[index]['address']),
                            onTap: () {
                              var selectedResult =
                                  autoSearchResults[index]['ref_id'];
                              getLatAndLong(selectedResult);
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          );
                        },
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return FutureBuilder(
                  future: customerHome,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Xử lý lỗi
                      return Text('Error: ${snapshot.error}');
                    } else {
                      CustomerHome customerHome = snapshot.data!;

                      if (customerHome.statusID == 0 ||
                          customerHome.statusID == 5) {
                        if (showParkingDetail) {
                          return ParkingDetailContent(
                            ploID: selectParkinglot,
                            scrollController: scrollController,
                            distance: distance,
                            showParkingDetailContent: showParkingDetailContent,
                            refreshHomeScreen: refreshHomeScreen,
                            closeParkingDetail: () {
                              setState(() {
                                showParkingDetail = false;
                              });
                            },
                          );
                        } else {
                          return HomeScreenContent(
                            scrollController,
                            showParkingDetailContent,
                            parkingList,
                            (int method) {
                              setState(() {
                                _fetchParkingList(lat, long, method, 5.0);
                              });
                            },
                          );
                        }
                      } else if (customerHome.statusID == 1) {
                        return CheckInContent(
                            scrollController, customerHome, refreshHomeScreen);
                      } else {
                        return CheckOutContent(scrollController, customerHome);
                      }
                    }
                  });
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 35 * fem,
            width: 35 * fem,
            decoration: BoxDecoration(color: Colors.transparent),
            child: FloatingActionButton(
              tooltip: 'Vị trí hiện tại',
              backgroundColor: Colors.white,
              onPressed: () {
                _getCurrentLocation().then((value) async {
                  lat = double.parse('${value.latitude}');
                  long = double.parse('${value.longitude}');
                  liveLocation();
                  temp.clear();
                  _mapController?.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(value.latitude, value.longitude),
                          zoom: 15,
                          tilt: 60)));
                  temp.add(Marker(
                      alignment: Alignment.bottomCenter,
                      width: 50,
                      height: 50,
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                      latLng: LatLng(value.latitude, value.longitude)));
                  await _fetchParkingList(lat, long, 1, 5.0);
                  if (parkingList != null && parkingList.isNotEmpty) {
                    for (var parking in parkingList) {
                      temp.add(Marker(
                        alignment: Alignment.bottomCenter,
                        width: 50,
                        height: 50,
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.local_parking_outlined,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                        latLng: LatLng(parking.latitude, parking.longitude),
                      ));
                    }
                  }
                });
              },
              child: Icon(
                Icons.location_searching,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 270),
        ],
      ),
    );
  }
}

Future<void> _RatingDialog(
    BuildContext context, CustomerHome customerHome) async {
  late TextEditingController _feedbackController = TextEditingController();
  int selectedRating = 0;
  showDialog(
    barrierDismissible: false,
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
                      "GỬI ĐÁNH GIÁ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bãi xe:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        customerHome.parkingName,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  Center(
                    child: RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 33,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        selectedRating = rating.toInt();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    constraints: BoxConstraints(
                      maxWidth: 300,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(9 * fem),
                    ),
                    child: TextFormField(
                      controller: _feedbackController,
                      decoration: InputDecoration(
                        hintText: 'Nội dung',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      maxLines: 5,
                    ),
                  ),
                  SizedBox(height: 15 * fem),

                  // Center(
                  //     child: Text(
                  //       '*Không thể gửi vì điền thiếu thông tin!',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 10,
                  //         color: Colors.red,
                  //         fontStyle: FontStyle.italic,
                  //       ),
                  //   ),
                  // ),
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
                              onPressed: () async {
                                try {
                                  await ReservationAPI.skipRating(
                                      customerHome.reservationID);
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  Navigator.of(context)
                                      .popUntil((route) => route.isCurrent);
                                }
                              },
                              child: Text(
                                'Bỏ qua',
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
                                if (selectedRating == 0 ||
                                    _feedbackController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '*Không thể gửi vì điền thiếu thông tin!')),
                                  );
                                } else {
                                  try {
                                    await ReservationAPI.sendRating(
                                        _feedbackController.text,
                                        customerHome.ploID,
                                        customerHome.reservationID,
                                        selectedRating);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Gửi đánh giá thành công!')),
                                    );
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Gửi đánh giá thất bại!')));
                                    Navigator.of(context).pop();
                                  }
                                }
                              },
                              child: Text(
                                'Gửi',
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

class HomeScreenContent extends StatefulWidget {
  final ScrollController scrollController;
  final Function showParkingDetailContent;
  final List<Parking> parkingList;
  final MethodCallback onMethodSelected;

  const HomeScreenContent(this.scrollController, this.showParkingDetailContent,
      this.parkingList, this.onMethodSelected);

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  bool isNearestSelected = false;
  bool isCheapestSelected = false;

  void selectMethod(int method) {
    setState(() {
      if (method == 1) {
        isNearestSelected = true;
        isCheapestSelected = false;
      } else {
        isNearestSelected = false;
        isCheapestSelected = true;
      }
      widget.onMethodSelected(method);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26 * fem),
                    topRight: Radius.circular(26 * fem),
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
                        padding: EdgeInsets.only(bottom: 5 * fem),
                        child: Text(
                          'BÃI ĐỖ GẦN ĐÂY (${widget.parkingList.length})',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(''),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  selectMethod(1);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5 * fem),
                                  width: 70 * fem,
                                  height: 25 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xff5b5b5b)),
                                    color: Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        if (isNearestSelected)
                                          Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 16 * fem,
                                          ),
                                        Text(
                                          'Gần nhất',
                                          style: TextStyle(
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff5b5b5b),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5 * fem,
                              ),
                              InkWell(
                                onTap: () {
                                  selectMethod(2);
                                },
                                child: Container(
                                  width: 70 * fem,
                                  height: 25 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xff5b5b5b)),
                                    color: Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        if (isCheapestSelected)
                                          Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 16 * fem,
                                          ),
                                        Text(
                                          'Rẻ nhất',
                                          style: TextStyle(
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff5b5b5b),
                                          ),
                                        ),
                                      ],
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
              Container(
                height: 410 * fem,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: widget.parkingList.isEmpty
                    ? Center(
                        child: Text(
                          'Không có bãi đỗ xe',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: widget.parkingList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              widget.showParkingDetailContent(
                                  widget.parkingList[index]);
                            },
                            child: ListParkingCard(
                                parkingInfor: widget.parkingList[index]),
                          );
                        },
                      ),
              )
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
  final Function refreshHomeScreen;
  final String ploID;
  final String distance;

  const ParkingDetailContent({
    required this.scrollController,
    required this.showParkingDetailContent,
    required this.closeParkingDetail,
    required this.ploID,
    required this.refreshHomeScreen,
    required this.distance,

  });

  @override
  State<ParkingDetailContent> createState() => _ParkingDetailContentState();
}

class _ParkingDetailContentState extends State<ParkingDetailContent> {
  late String ploID;
  Future<ParkingLotDetail>? parkingLotFuture;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');

  @override
  void initState() {
    super.initState();
    parkingLotFuture = _getParkingLotFuture();
    ploID = widget.ploID;
  }

  Future<ParkingLotDetail> _getParkingLotFuture() async {
    return ParkingAPI.getParkingLotDetail(widget.ploID);
  }

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
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26 * fem),
                            topRight: Radius.circular(26 * fem),
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
                      Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10 * fem, right: 10 * fem, top: 5 * fem),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  padding:
                                      EdgeInsets.symmetric(vertical: 5 * fem),
                                  child: RatingStars(
                                      rating: parkingLotDetail.star),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 5 * fem),
                                  child: Row(
                                    children: [
                                      if (parkingLotDetail.morningFee != 0)
                                        Container(
                                          padding: EdgeInsets.fromLTRB(15 * fem,
                                              10 * fem, 15 * fem, 8 * fem),
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
                                                margin: EdgeInsets.only(
                                                    bottom: 6 * fem),
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
                                                '${formatCurrency.format(parkingLotDetail.morningFee)}',
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
                                        width: 5 * fem,
                                      ),
                                      if (parkingLotDetail.eveningFee != 0)
                                        Container(
                                          padding: EdgeInsets.fromLTRB(15 * fem,
                                              10 * fem, 15 * fem, 8 * fem),
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
                                                margin: EdgeInsets.only(
                                                    bottom: 6 * fem),
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
                                                '${formatCurrency.format(parkingLotDetail.eveningFee)}',
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
                                        width: 5 * fem,
                                      ),
                                      if (parkingLotDetail.overnightFee != 0)
                                        Container(
                                          padding: EdgeInsets.fromLTRB(15 * fem,
                                              10 * fem, 15 * fem, 8 * fem),
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
                                                margin: EdgeInsets.only(
                                                    bottom: 6 * fem),
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
                                                '${formatCurrency.format(parkingLotDetail.overnightFee)}',
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
                                        width: 5 * fem,
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            10 * fem, 12 * fem, 8 * fem),
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
                                              margin: EdgeInsets.only(
                                                  bottom: 6 * fem),
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
                                        width: 5 * fem,
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(20 * fem,
                                            10 * fem, 20 * fem, 8 * fem),
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
                                              margin: EdgeInsets.only(
                                                  bottom: 6 * fem),
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
                                              '${widget.distance} m',
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
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10 * fem),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RatingScreen(
                                                          ploID: ploID)));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(10 * fem,
                                              10 * fem, 10 * fem, 10 * fem),
                                          margin:
                                              EdgeInsets.only(right: 10 * fem),
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
                                                      ReservationScreen(
                                                        ploID: ploID,
                                                        distance: widget.distance,
                                                        waitingTime: parkingLotDetail.waitingTime,
                                                        parkinglotDetail:
                                                            parkingLotDetail,
                                                        refreshHomeScreen: () {
                                                          widget
                                                              .refreshHomeScreen();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(10 * fem,
                                              10 * fem, 10 * fem, 10 * fem),
                                          width: 137 * fem,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                    height: 215 * fem,
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
                                                    BorderRadius.circular(
                                                        10 * fem),
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
                          )),
                    ],
                  ),
                ));
              }
            })
      ],
    );
  }
}

class CheckInContent extends StatelessWidget {
  final ScrollController scrollController;
  final CustomerHome customerHome;
  final Function refreshHomeScreen;

  const CheckInContent(
      this.scrollController, this.customerHome, this.refreshHomeScreen);

  Future<void> _openMap(double lat, double long) async {
    String googleURL =
        '${UrlConstant.GOOGLE_MAP_SEARCH}/?api=1&query=$lat,$long';

    await canLaunchUrlString(googleURL)
        ? await launchUrlString(googleURL)
        : throw 'Could not launch $googleURL';
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');

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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15 * fem),
                    topRight: Radius.circular(15 * fem),
                  ),
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
                            left: 10 * fem,
                            right: 10 * fem,
                            top: 15 * fem,
                            bottom: 10 * fem),
                        child: Text(
                          'Đang trên đường tới...',
                          style: TextStyle(
                            fontSize: 20 * fem,
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
                                    customerHome.parkingName,
                                    style: TextStyle(
                                        fontSize: 20 * fem,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    customerHome.address,
                                    style: TextStyle(
                                      fontSize: 18 * fem,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _openMap(customerHome.latitude,
                                        customerHome.longitude);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 2 * fem),
                                    child: Image.asset(
                                        'assets/images/directionImage.png'),
                                  ),
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
                                          fontSize: 18 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${formatCurrency.format(customerHome.price)}',
                                      style: TextStyle(
                                        fontSize: 20 * ffem,
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
                                          fontSize: 18 * fem,
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
                                            fontSize: 18 * ffem,
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
                                          fontSize: 18 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      customerHome.parkingName,
                                      style: TextStyle(
                                        fontSize: 18 * fem,
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
                                          fontSize: 18 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      customerHome.methodName,
                                      style: TextStyle(
                                        fontSize: 18 * fem,
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
                                          fontSize: 18 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      customerHome.licensePlate,
                                      style: TextStyle(
                                        fontSize: 18 * fem,
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
                            left: 10 * fem, right: 10 * fem, bottom: 20 * fem),
                        child: GestureDetector(
                          onTap: () {
                            _showDeleteDialog(
                                context, customerHome, refreshHomeScreen);
                          },
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10 * fem, right: 10 * fem, bottom: 20 * fem),
                        child: Center(
                            child: Text(
                          'Check-in',
                          style: TextStyle(
                              fontSize: 30 * fem,
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

Future<void> _showDeleteDialog(BuildContext context, CustomerHome customerHome,
    Function refreshHomeScreen) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
        backgroundColor: const Color(0xffffffff),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12 * fem),
                child: Center(
                  child: Text(
                    'HỦY BỎ ĐẶT XE',
                    style: TextStyle(
                      fontSize: 25 * fem,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              ),
              Center(
                  child: Container(
                margin: EdgeInsets.only(top: 20 * fem, bottom: 20 * fem),
                child: Text(
                  'Bạn có chắc chắn hủy việc đặt chỗ ở ${customerHome.parkingName} ',
                  style: TextStyle(
                    fontSize: 20 * fem,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 1,
                          color: const Color(0xffb3abab),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
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
                        color: const Color(0xffb3abab),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 1,
                          color: const Color(0xffb3abab),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              await ReservationAPI.cancelReservation(
                                  customerHome.reservationID);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Hủy bỏ đặt chỗ thành công'),
                                ),
                              );
                              Navigator.of(context).pop();
                              refreshHomeScreen();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Hủy bỏ đặt chỗ thất bại'),
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text(
                            'Xác nhận',
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

class CheckOutContent extends StatelessWidget {
  final ScrollController scrollController;
  final CustomerHome customerHome;

  const CheckOutContent(this.scrollController, this.customerHome);

  Future<void> _openMap(double lat, double long) async {
    String googleURL =
        '${UrlConstant.GOOGLE_MAP_SEARCH}/?api=1&query=$lat,$long';

    await canLaunchUrlString(googleURL)
        ? await launchUrlString(googleURL)
        : throw 'Could not launch $googleURL';
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');

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
                  color: Colors.white,
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
                            left: 10 * fem,
                            right: 10 * fem,
                            top: 15 * fem,
                            bottom: 15 * fem),
                        child: Text(
                          'Đang trong bãi...',
                          style: TextStyle(
                            fontSize: 22 * fem,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10 * fem, right: 10 * fem, bottom: 15 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    customerHome.parkingName,
                                    style: TextStyle(
                                        fontSize: 20 * fem,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    customerHome.address,
                                    style: TextStyle(
                                      fontSize: 18 * fem,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _openMap(customerHome.latitude,
                                        customerHome.longitude);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 2 * fem),
                                    child: Image.asset(
                                      'assets/images/directionImageGreen.png',
                                    ),
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
                        padding: EdgeInsets.only(
                            left: 10 * fem, right: 10 * fem, top: 15 * fem),
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
                                          fontSize: 20 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${formatCurrency.format(customerHome.price)}',
                                      style: TextStyle(
                                        fontSize: 20 * ffem,
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
                                          fontSize: 20 * fem,
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
                                            fontSize: 18 * ffem,
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
                                          fontSize: 20 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      customerHome.parkingName,
                                      style: TextStyle(
                                        fontSize: 18 * fem,
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
                                          fontSize: 20 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      customerHome.methodName,
                                      style: TextStyle(
                                        fontSize: 18 * fem,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (customerHome.statusID == 3)
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 5 * fem, 9 * fem, 9 * fem),
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: SizedBox(
                                        width: 10 * fem,
                                      )),
                                      Text(
                                        'Bạn hiện đang trễ giờ rời bãi',
                                        style: TextStyle(
                                          fontSize: 20 * fem,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red,
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
                                          fontSize: 20 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5b5b5b),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      customerHome.licensePlate,
                                      style: TextStyle(
                                        fontSize: 18 * fem,
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
                            left: 10 * fem,
                            right: 10 * fem,
                            top: 20 * fem,
                            bottom: 20 * fem),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Center(
                              child: Text(
                            'Check-out',
                            style: TextStyle(
                                fontSize: 30 * fem,
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
