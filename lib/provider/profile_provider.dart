import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/Network/Response/AddSubscriptionResponse.dart';
import 'package:knet/Network/Response/GetProfileResponse.dart';
import 'package:knet/Network/Response/UpdateProfilePictureResponse.dart';
import 'package:knet/Network/Response/UpdateProfileResponse.dart';
import 'package:knet/screen/MapScreen.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:knet/utils/ToastUtils.dart';

import '../screen/auth_screen.dart';
import '../main.dart';

class ProfileProvider extends ChangeNotifier {
  bool isFetching = true;

  GetProfileResponse _getGetProfileResponse = new GetProfileResponse();
  UpdateProfilePictureResponse _getUpdateProfilePictureResponse =
      new UpdateProfilePictureResponse();
  UpdateProfileResponse _getUpdateProfileResponse = new UpdateProfileResponse();

  setGetProfileResponse(GetProfileResponse data) {
    _getGetProfileResponse = data;

    isFetching = false;
    notifyListeners();
  }

  GetProfileResponse getGetProfileResponse() {
    return _getGetProfileResponse;
  }

  void getProfile(BuildContext context) async {
    try {
      var _getGetProfileResponse = await ApiHandler.getProfile(context);
      if (_getGetProfileResponse?.statusCode == 200) {
        setGetProfileResponse(_getGetProfileResponse);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            content: Text(
          _getGetProfileResponse.message,
          style: TextStyle(color: Colors.white),
        ))));
        print("getSubscription api hit successfully Go for HomePage");
      } else if (_getGetProfileResponse?.statusCode == 404) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (_getGetProfileResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        // EasyLoading.showToast('Could not login, try later');
        ToastUtils.show(_getGetProfileResponse.message);
        print("error in doLogin api $_getGetProfileResponse");
      }
    } catch (e) {
      EasyLoading.showToast('Could not fetch subscription, try later');
      print("Knet -> getSubscription() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }

  setUpdateProfilePictureResponse(UpdateProfilePictureResponse data) {
    _getUpdateProfilePictureResponse = data;

    isFetching = false;
    notifyListeners();
  }

  UpdateProfilePictureResponse getUpdateProfilePictureResponse() {
    return _getUpdateProfilePictureResponse;
  }

  void updateProfilePic(BuildContext context, File file) async {
    try {
      var _getUpdateProfilePictureResponse =
          await ApiHandler.updateProfilePic(context, file);
      if (_getUpdateProfilePictureResponse?.statusCode == 200) {
        setUpdateProfilePictureResponse(_getUpdateProfilePictureResponse);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            content: Text(_getUpdateProfilePictureResponse.message))));
        print("getSubscription api hit successfully Go for HomePage");
      } else if (_getUpdateProfilePictureResponse?.statusCode == 404) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (_getUpdateProfilePictureResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        // EasyLoading.showToast('Could not login, try later');
        ToastUtils.show(_getUpdateProfilePictureResponse.message);
        print("error in doLogin api $_getUpdateProfilePictureResponse");
      }
    } catch (e) {
      EasyLoading.showToast(_getUpdateProfilePictureResponse.message);
      print("Knet -> getSubscription() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }

  setUpdateProfileResponse(UpdateProfileResponse data) {
    _getUpdateProfileResponse = data;

    isFetching = false;
    notifyListeners();
  }

  UpdateProfileResponse getUpdateProfileResponse() {
    return _getUpdateProfileResponse;
  }

  void updateProfile(BuildContext context, String name, String email,
      String mobile, String location, String description, String sellerType,
      String businessName, String fbAddress, String igAddress, var lat, var lng) async {
    try {
      var _getUpdateProfileResponse = await ApiHandler.updateProfile(
          context, name, email, mobile, location, description, sellerType,
          businessName, fbAddress, igAddress, lat, lng);
      if(_getUpdateProfileResponse.toString().contains('error')){
        Map resp = _getUpdateProfileResponse;
        print(">>>>>>>"+resp['error'].keys.toString());
        for(var key in resp['error'].keys){
          for(String error in resp['error'][key]) {
            ToastUtils.show(error);
          }
        }
        //ToastUtils.show(_getUpdateProfileResponse?.statusCode.toString());
        print("error in doLogin api $_getUpdateProfileResponse");
      }
      else if (_getUpdateProfileResponse.statusCode == 200) {
        Navigator.pop(context);
        setUpdateProfileResponse(_getUpdateProfileResponse);
        ScaffoldMessenger.of(context).showSnackBar(
            (SnackBar(content: Text(_getUpdateProfileResponse.message))));
        print("getSubscription api hit successfully Go for HomePage");
      } else if (_getUpdateProfileResponse?.statusCode == 404) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (_getUpdateProfileResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {

      }
    } on DioError catch (e) {
      EasyLoading.showToast('Could not fetch subscription, try later');
      print("Knet -> getSubscription() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }
}
