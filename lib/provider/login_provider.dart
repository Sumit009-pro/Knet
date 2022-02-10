import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/Network/Response/LoginResponse.dart';
import 'package:knet/screen/MapScreen.dart';
import 'package:knet/screen/get_markers.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:knet/utils/ToastUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../screen/auth_screen.dart';
// import '../main.dart';

class LoginProvider extends ChangeNotifier {
  bool isFetching = true;

  LoginResponse _getLoginResponse = new LoginResponse();

  setLoginRes(LoginResponse data) {
    _getLoginResponse = data;

    isFetching = false;
    notifyListeners();
  }

  LoginResponse getLoginRes() {
    return _getLoginResponse;
  }

  getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(Keys.accessToken);
    print('reviewDetails API HANDLER ' + token);
    return token;
  }

  savePref(BuildContext context, LoginResponse data) async {
    await sharedPreferences?.setString(Keys.emailID, data.accessToken);
    await sharedPreferences?.setString(Keys.password, data.accessToken);
    await sharedPreferences?.setString(Keys.userID, data.accessToken);
    await sharedPreferences?.setString(Keys.accessToken, data.accessToken);
    await sharedPreferences?.setInt("id", data.data.userId);
    print("KNET ACCESSTOKEN " + sharedPreferences.get(Keys.accessToken));
    print("KNET RESPONSE ACCESSTOKEN " + data.accessToken);
    notifyListeners();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GetPosition()),
    );
  }

  void doLogin(BuildContext context, String email, String password) async {
    try {
      var getLoginResponse = await ApiHandler.doLogin(context, email, password);
      if (getLoginResponse?.statusCode == 200) {
        setLoginRes(getLoginResponse);
        savePref(context, getLoginResponse);

        EasyLoading.dismiss();

        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            content: Text(
          getLoginResponse.message,
          style: TextStyle(color: Colors.white),
        ))));
        // ToastUtils.show('Success');

        print("doLogin api hit successfully Go for HomePage");
      } else if (getLoginResponse?.statusCode == 404) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (getLoginResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            content: Text(
          getLoginResponse.message,
          style: TextStyle(color: Colors.white),
        ))));
        print("error in doLogin api $getLoginResponse");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          content: Text(
        'Could not login, try later',
        style: TextStyle(color: Colors.white),
      ))));
      print("Knet -> doLogin() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }
}
