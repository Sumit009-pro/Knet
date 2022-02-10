import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/Network/Response/LogoutResponse.dart';

import '../screen/auth_screen.dart';
import '../main.dart';

class LogoutProvider extends ChangeNotifier {
  bool isFetching = true;

  LogoutResponse _getLogoutResponse = new LogoutResponse();

  setLogoutResponse(LogoutResponse data) {
    _getLogoutResponse = data;

    isFetching = false;
    notifyListeners();
  }

  LogoutResponse getLogoutResponse() {
    return _getLogoutResponse;
  }

  void doLogout(BuildContext context) async {
    try {
      var getLogoutResponse = await ApiHandler.doLogout(context);
      if (getLogoutResponse?.statusCode == 200) {
        await sharedPreferences.clear();
        setLogoutResponse(getLogoutResponse);

        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            content: Text(
          getLogoutResponse.message,
          style: TextStyle(color: Colors.white),
        ))));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AuthScreen(true)),
            (Route<dynamic> route) => false);
      }
    } catch (e) {
      EasyLoading.dismiss();

      print("Knet -> doLogout() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }
}
