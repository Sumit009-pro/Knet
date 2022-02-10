import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/Network/Response/AddReviewResponse.dart';
import 'package:knet/Network/Response/AllUserDetailsResponse.dart';
import 'package:knet/Network/Response/ReviewDetailsResponse.dart';
import 'package:knet/Network/Response/DeleteReviewResponse.dart';
import 'package:knet/Network/Response/SingleUserDetailsResponse.dart';

import 'package:knet/screen/MapScreen.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:knet/utils/ToastUtils.dart';

import '../screen/auth_screen.dart';
import '../main.dart';

class UserProvider extends ChangeNotifier {
  bool isFetching = true;

  SingleUserDetailsResponse _getSingleUserDetailsResponse = new SingleUserDetailsResponse();
  AllUserDetailsResponse _getAllUserDetailsResponse = new AllUserDetailsResponse();


  setSingleUserDetailsResponse(SingleUserDetailsResponse data) {
    _getSingleUserDetailsResponse = data;

    isFetching = false;
    notifyListeners();
  }

  SingleUserDetailsResponse getSingleUserDetailsResponse() {
    return _getSingleUserDetailsResponse;
  }

  void singleUserDetails(BuildContext context) async {
    try {
      var _getSingleUserDetailsResponse = await ApiHandler.singleUserDetails(context);
      if (_getSingleUserDetailsResponse?.statusCode == 200) {
        setSingleUserDetailsResponse(_getSingleUserDetailsResponse);
        ToastUtils.show('Success');
        print("getSubscription api hit successfully Go for HomePage");
      } else if (_getSingleUserDetailsResponse?.statusCode == 404) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (_getSingleUserDetailsResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        // EasyLoading.showToast('Could not login, try later');
        ToastUtils.show(_getSingleUserDetailsResponse.message);
        print("error in doLogin api $_getSingleUserDetailsResponse");
      }
    } catch (e) {
      EasyLoading.showToast('Could not fetch subscription, try later');
      print("Knet -> getSubscription() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }



  /*All User Details*/

  setAllUserDetailsResponse(AllUserDetailsResponse data) {
    _getAllUserDetailsResponse = data;

    isFetching = false;
    notifyListeners();
  }

  AllUserDetailsResponse getAllUserDetailsResponse() {
    return _getAllUserDetailsResponse;
  }

  void allUserDetails(BuildContext context) async {
    try {
      var _getAllUserDetailsResponse = await ApiHandler.allUserDetails(context);
      if (_getAllUserDetailsResponse?.statusCode == 200) {
        setAllUserDetailsResponse(_getAllUserDetailsResponse);
        ScaffoldMessenger.of(context)
            .showSnackBar((SnackBar(content: Text(_getAllUserDetailsResponse.message,style: TextStyle(color: Colors.white),))));
        // ToastUtils.show('Success');
        print("allUserDetails api hit successfully Go for HomePage");
      } else if (_getAllUserDetailsResponse?.statusCode == 404) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (_getAllUserDetailsResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        // EasyLoading.showToast('Could not login, try later');
        ToastUtils.show(_getAllUserDetailsResponse.message);
        print("error in allUserDetails api $_getAllUserDetailsResponse");
      }
    } catch (e) {
      EasyLoading.showToast('Could not fetch allUserDetails, try later');
      print("Knet -> allUserDetails() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }



}
