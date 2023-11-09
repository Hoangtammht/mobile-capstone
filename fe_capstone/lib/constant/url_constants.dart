import 'package:fe_capstone/constant/base_constant.dart';

class UrlConstant {
  static const AUTH = "${BaseConstants.BASE_URL}/user";
  static const CUSTOMER = "${BaseConstants.BASE_URL}/customer";
  static const LICENSE_PLATE = "${BaseConstants.BASE_URL}/motorbike";
  static const PARKING_LOT = "${BaseConstants.BASE_URL}/parking";
  static const PARKING_OWNER = "${BaseConstants.BASE_URL}/PLO";
  static const TRANSACTION = "${BaseConstants.BASE_URL}/ploTransaction";
  static const RATING = "${BaseConstants.BASE_URL}/rating";
  static const RESERVATION = "${BaseConstants.BASE_URL}/reservation";
  static const ORDER_PRODUCT = "${BaseConstants.BASE_URL}/api/v1/order-product";
  static const IMAGE_STORE = "https://sg.storage.bunnycdn.com/fiftyfiftycdn/eparking";
  static const IMAGE_LINK = "https://fiftyfifty.b-cdn.net/eparking";
  static const VIETMAP_SEARCH = "${BaseConstants.VIETMAP_URL}/";
  static const VIETMAP = "${BaseConstants.VIETMAP_URL}/";
  static const GOOGLE_MAP_SEARCH = "${BaseConstants.GOOGLE_MAP_URL}/search";
}