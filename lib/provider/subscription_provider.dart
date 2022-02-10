import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/Network/Response/AddSubscriptionResponse.dart';
import 'package:knet/Network/Response/UserSubscriptionPlansResponse.dart';

import 'package:knet/Network/Response/SubscriptionPlansResponse.dart';
import 'package:knet/screen/MapScreen.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:knet/utils/ToastUtils.dart';

import '../screen/auth_screen.dart';
import '../main.dart';

class SubscriptionProvider extends ChangeNotifier {
  bool isFetching = true;

  SubscriptionPlansResponse _getSubscriptionPlansResponse = new SubscriptionPlansResponse();
  AddSubscriptionResponse _getAddSubscriptionResponse = new AddSubscriptionResponse();
  UserSubscriptionPlansResponse _getUserSubscriptionPlansResponse = new UserSubscriptionPlansResponse();

  setSubscriptionPlansResponse(SubscriptionPlansResponse data) {
    _getSubscriptionPlansResponse = data;

    isFetching = false;
    notifyListeners();
  }

  SubscriptionPlansResponse getSubscriptionPlansResponse() {
    return _getSubscriptionPlansResponse;
  }

  void getSubscription(BuildContext context) async {
    try {
      var _getSubscriptionPlansResponse = await ApiHandler.getSubscription(context);
      if (_getSubscriptionPlansResponse?.statusCode == 200) {
        setSubscriptionPlansResponse(_getSubscriptionPlansResponse);
        ToastUtils.show('Success');
        print("getSubscription api hit successfully Go for HomePage");
      } else if (_getSubscriptionPlansResponse?.statusCode == 404) {

      } else if (_getSubscriptionPlansResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        // EasyLoading.showToast('Could not login, try later');
        ToastUtils.show(_getSubscriptionPlansResponse.message);
        print("error in doLogin api $_getSubscriptionPlansResponse");
      }
    } catch (e) {
      EasyLoading.showToast('Could not fetch subscription, try later');
      print("Knet -> getSubscription() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }







  setUserSubscriptionPlansResponse(UserSubscriptionPlansResponse data) {
    _getUserSubscriptionPlansResponse = data;

    isFetching = false;
    notifyListeners();
  }

  UserSubscriptionPlansResponse getUserSubscriptionPlansResponse() {
    return _getUserSubscriptionPlansResponse;
  }
  void getUserSubscription(BuildContext context) async {
    try {
      var _getUserSubscriptionPlansResponse = await ApiHandler.getSubscription(context);
      if (_getUserSubscriptionPlansResponse?.statusCode == 200) {
        // setUserSubscriptionPlansResponse(_getUserSubscriptionPlansResponse);
        ToastUtils.show('Success');
        print("getSubscription api hit successfully Go for HomePage");
      } else if (_getUserSubscriptionPlansResponse?.statusCode == 404) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => AuthScreen()),
        // );
      } else if (_getUserSubscriptionPlansResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        // EasyLoading.showToast('Could not login, try later');
        ToastUtils.show(_getUserSubscriptionPlansResponse.message);
        print("error in doLogin api $_getUserSubscriptionPlansResponse");
      }
    } catch (e) {
      EasyLoading.showToast('Could not fetch subscription, try later');
      print("Knet -> getSubscription() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }







  setAddSubscriptionResponse(AddSubscriptionResponse data) {
    _getAddSubscriptionResponse = data;
    isFetching = false;
    notifyListeners();
  }

  AddSubscriptionResponse getAddSubscriptionResponse() {
    return _getAddSubscriptionResponse;
  }

  void postSubscription(BuildContext context) async {
    try {
      var _getAddSubscriptionResponse = await ApiHandler.postSubscription(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)));
      // print('Response :'+_getAddSubscriptionResponse.toString());
      if (_getAddSubscriptionResponse?.statusCode == 200) {
        setAddSubscriptionResponse(_getAddSubscriptionResponse);
        ScaffoldMessenger.of(context)
            .showSnackBar((SnackBar(content: Text(_getAddSubscriptionResponse.message,style: TextStyle(color: Colors.white),))));
        // ToastUtils.show('Success');
        EasyLoading.dismiss();
        print("postSubscription api hit successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (_getAddSubscriptionResponse?.statusCode == 401) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (_getAddSubscriptionResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        // EasyLoading.showToast('Could not login, try later');
        ToastUtils.show(_getAddSubscriptionResponse.message);
        print("error in doLogin api $_getAddSubscriptionResponse");
      }
    }on DioError catch (e) {
      // EasyLoading.showToast('Could not add subscription, try later');
      // EasyLoading.dismiss();
      print("Knet -> postSubscription() -> ${e.response.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }
}
