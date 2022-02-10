import 'dart:ui';

class StringUtils {
  // Common
  static String checkInternetConnectivity =
      "Please check your internet connection.";
  static String errorShareInternetNotConnected =
      "Can not share because of connectivity Issue\n$checkInternetConnectivity";
  static String errorDownloadInternetNotConnected =
      "Can not download because of connectivity Issue\n$checkInternetConnectivity";

  //ImagePath
  static final String imagesplash = 'assets/logo.png';
  static final String board1 = 'assets/image.png';
  static final String board2 = 'assets/image.png';
  static final String board3 = 'assets/image.png';
  static final String ob1 = 'assets/splash.png';
  static final String ob2 = 'assets/splash.png';
  static final String oby2 = 'assets/splash.png';
  static final String background = 'assets/background.png';
  static final String contract = 'assets/contract.png';
  static final String download = 'assets/download.png';
  static final String symbol = 'assets/n_symbol.png';
  static final String devices = 'assets/devices.png';

  //Colors
  static String themeColor = '#752FFF';
  static String toastbackground = 'CC5F5F5F';
  static String backgroundcolor = '#FF696A';
  static String inputbackground = '#A2A2A2';
  static String letterblack = '#2D2E4A';

}

class Keys {
  static const String deviceId = "device_id";
  static const String accessToken = "access_token";
  static const String deviceType = "device_type";
  static const String userID = "user_id";
  static const String sessionID = "session_id";
  static const String emailID = "email_id";
  static const String password = "password";
}

Color parseHexColor(String hexColorString) {
  if (hexColorString == null) {
    return null;
  }
  hexColorString = hexColorString.toUpperCase().replaceAll("#", "");
  if (hexColorString.length == 6) {
    hexColorString = "FF" + hexColorString;
  }
  int colorInt = int.parse(hexColorString, radix: 16);
  return Color(colorInt);
}
