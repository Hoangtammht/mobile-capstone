import 'package:fe_capstone/apis/plo/ParkingAPI.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/ui/PLOwnerUI/BottomTabNavPlo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../models/RequestResgisterParking.dart';

class RechargeWebViewScreen extends StatefulWidget {
  final String url;
  final RequestRegisterParking request;

  RechargeWebViewScreen(this.url, this.request);

  @override
  State<RechargeWebViewScreen> createState() => _RechargeWebViewScreenState();
}

class _RechargeWebViewScreenState extends State<RechargeWebViewScreen> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        var isLastPage = await inAppWebViewController.canGoBack();
        if(isLastPage){
          inAppWebViewController.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(widget.url)
                ),
                onWebViewCreated: (InAppWebViewController controller){
                  inAppWebViewController = controller;
                },
                onLoadStop: (InAppWebViewController controller, Uri? url) async {
                  if (url.toString().contains('vnp_ResponseCode=00')) {
                    await ParkingAPI.registerParking(widget.request);
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: BottomTabNavPlo(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Thanh toán thành công',
                              style: TextStyle(
                                fontSize: 22 * fem,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    fontSize: 22 * fem,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                  }
                  if (url.toString().contains('vnp_ResponseCode=24') || url.toString().contains('vnp_ResponseCode=01') || url.toString().contains('vnp_ResponseCode=02')
                      || url.toString().contains('vnp_ResponseCode=03') || url.toString().contains('vnp_ResponseCode=04') || url.toString().contains('vnp_ResponseCode=08')
                      || url.toString().contains('vnp_ResponseCode=79') || url.toString().contains('vnp_ResponseCode=97')
                  ) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Thanh toán thất bại',
                            style: TextStyle(
                              fontSize: 22 * fem,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  fontSize: 22 * fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );

                  }
                },
                onProgressChanged: (InAppWebViewController controller, int process){
                  setState(() {
                    _progress = process / 100;
                  });
                },
                onLoadError: (InAppWebViewController controller, Uri? url, int code, String message) {
                  print('Error $code: $message when loading $url');
                },
              ),
              _progress < 1 ? Container(
                child: LinearProgressIndicator(
                  value: _progress,
                ),
              ) : SizedBox()
            ],
          ),
        ),
      ),
    );
}



}

