import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/Network/Response/RequestOtpResponse.dart';
import 'package:knet/Network/Response/VerifyResponse.dart';
import 'package:knet/screen/MapScreen.dart';
import 'package:knet/utils/ToastUtils.dart';

import '../screen/auth_screen.dart';
import '../main.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  bool isFetching = true;

  RequestOtpResponse _getRequestOtpResponse = new RequestOtpResponse();
  VerifyResponse _getVerifyOtpResponse = new VerifyResponse();

  setVerifyOtpResponse(VerifyResponse data) {
    _getVerifyOtpResponse = data;

    isFetching = false;
    notifyListeners();
  }

  VerifyResponse getVerifyOtpResponse() {
    return _getVerifyOtpResponse;
  }

  verifyOTP(BuildContext context, String email, String otp) async {
    try {
      var getVerifyOtpResponse =
          await ApiHandler.verifyOTP(context, email, otp);
      print("SC" + getVerifyOtpResponse.message.toString());
      if (getVerifyOtpResponse.statusCode == 200) {
        setVerifyOtpResponse(getVerifyOtpResponse);
        print("SC" + getVerifyOtpResponse.statusCode.toString());

        // ToastUtils.show('Success');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MapScreen()),
        );
        print("requstOTP api hit successfully Go for HomePage");
      } else if (getVerifyOtpResponse.statusCode == 401) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (getVerifyOtpResponse.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true),
        ));
      } else {
        ToastUtils.show(getVerifyOtpResponse.message);
        print("error in requestOTP api $_getVerifyOtpResponse");
      }
    } catch (e) {
      print("Knet -> requestOTP() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }

  setRequestOtpRes(RequestOtpResponse data) {
    _getRequestOtpResponse = data;

    isFetching = false;
    notifyListeners();
  }

  RequestOtpResponse getRequestOtpRes() {
    return _getRequestOtpResponse;
  }

  void requestOTP(BuildContext context, String email) async {
    //
    try {
      var getRequestOtpResponse = await ApiHandler.requestOTP(context, email);
      if (getRequestOtpResponse?.statusCode == 200) {
        setRequestOtpRes(getRequestOtpResponse);

        ToastUtils.show('Success');

        print("requstOTP api hit successfully Go for HomePage");
      } else if (getRequestOtpResponse?.statusCode == 404) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (getRequestOtpResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        ToastUtils.show(getRequestOtpResponse.message);
        print("error in requestOTP api $getRequestOtpResponse");
      }
    } catch (e) {
      print("Knet -> requestOTP() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }
}
