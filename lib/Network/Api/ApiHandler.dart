import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:knet/Network/Response/AddSubscriptionResponse.dart';
import 'package:knet/Network/Response/AllUserDetailsResponse.dart';
import 'package:knet/Network/Response/LoginResponse.dart';
import 'package:knet/Network/Response/RegisterResponse.dart';
import 'package:knet/Network/Response/RequestOtpResponse.dart';
import 'package:knet/Network/Response/GetProfileResponse.dart';
import 'package:knet/Network/Response/LogoutResponse.dart';
import 'package:knet/Network/Response/SingleUserDetailsResponse.dart';
import 'package:http/http.dart' as http;


import 'package:knet/Network/Response/SubscriptionPlansResponse.dart';
import 'package:knet/Network/Response/DeleteReviewResponse.dart';

import 'package:knet/Network/Response/AddReviewResponse.dart';
import 'package:knet/Network/Response/ReviewDetailsResponse.dart';
import 'package:knet/Network/Response/UpdateProfilePictureResponse.dart';
import 'package:knet/Network/Response/UpdateProfileResponse.dart';
import 'package:knet/Network/Response/VerifyResponse.dart';
import 'package:knet/Network/Response/UserSubscriptionPlansResponse.dart';

import 'package:knet/provider/login_provider.dart';

import 'package:knet/utils/StringUtils.dart';
import 'package:knet/utils/DialogUtils.dart';
import 'package:knet/utils/PrintUtils.dart';
import 'package:knet/utils/ToastUtils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'NetworkCallInterceptor.dart';
import 'CustomInterceptor.dart';

class ApiHandler {
  ///Production URL
  static final String BASE_URL = "https://demos.mydevfactory.com/debarati/knet/public/api/";

  static ApiHandler _instance;
  static Dio _api;

  static ApiHandler getInstance() {
    if (_instance == null) _instance = new ApiHandler();
    return _instance;
  }

  /// dio instance method.
  static Future<Dio> getApi() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (_api == null) {
      _api = new Dio();
      _api.options.baseUrl = BASE_URL;
      _api.options.connectTimeout= 30000;
      _api.options.headers["Content-Type"] = "application/json";
      _api.options.headers["Accept"] = "application/json";
      _api.interceptors.add(NetworkCallInterceptor());
      _api.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    return _api;
  }

  static Future<Dio> getApis(BuildContext context) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (_api == null) {
      _api = new Dio();
      _api.options.baseUrl = BASE_URL;
      _api.options.headers["Content-Type"] = "application/json";
      _api.options.headers["Accept"] = "application/json";
      _api.interceptors.add(CustomInterceptor(context));
      _api.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    return _api;
  }

  static Future<Dio> getAPI(BuildContext context,String tok) async {
    print('getAPI TOKEN '+tok);
      _api = new Dio();
      _api.options.baseUrl = BASE_URL;
      _api.options.headers["Content-Type"] = "application/json";
      _api.options.headers["Accept"] = "application/json";
      _api.options.headers["Authorization"] = "Bearer "+tok;
      _api.interceptors.add(CustomInterceptor(context));
      _api.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    return _api;
  }

  static Future<RegisterResponse> Register(
      BuildContext context,String firstname,
      String email,
      String mobile,
      String password,
      String cpassword
      ) async {
    try {
      EasyLoading.show();
      var dio = await getApi();
      var formData = FormData.fromMap({
        'name': firstname,
        'email': email,
        'mobile': mobile,
        'password': password,
        'password_confirmation': cpassword,
        'location':'Mumbai',
        'lat':'19.0760',
        'lng':'72.8777',
        'device_type':'ANDROID'
      });
      var response = await dio.post("register", data: formData);
      print(response.data);
      if (response.data['status code']==422){
          await EasyLoading.showToast('${response.data['errors']['email'][0]}');
        }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      RegisterResponse objectResponse = RegisterResponse.fromJson(user);
      EasyLoading.dismiss();
      return objectResponse;
    } catch (e) {
      EasyLoading.dismiss();
      PrintUtils.printLog(e);
    }
    DialogUtils.hideProgress(context);
    return null;
  }

  static Future<LoginResponse> doLogin(
      BuildContext context,String email, String password) async {
    try {
      EasyLoading.show();
      var dio = await getApi();
      var formData = FormData.fromMap({
        'email': email,
        'password': password,
        'device_token': '1234',
        'device_type': 'ANDROID'
      });
      var response = await dio.post("login",data:formData);
      print('code : ${response.statusCode}');
      if(response.statusCode==401){
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      LoginResponse objectResponse = LoginResponse.fromJson(user);
      EasyLoading.dismiss();
      return objectResponse;
    } catch (e) {
      EasyLoading.dismiss();
      PrintUtils.printLog(e);
    }
    EasyLoading.dismiss();
    return null;
  }


  /*Logout*/

  static Future<LogoutResponse> doLogout(
      BuildContext context) async {
    try {
      EasyLoading.show();
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      print("KNet -> Get doLogout Screen -> API Request -> ");
      print(sharedPreferences.getString(Keys.accessToken));

      var response = await dio.post("logout",);
      print('code : ${response.statusCode}');
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      LogoutResponse objectResponse = LogoutResponse.fromJson(user);
      return objectResponse;
    } catch (e) {
      EasyLoading.dismiss();
      PrintUtils.printLog(e);
    }
    EasyLoading.dismiss();
    return null;
  }

  static Future<VerifyResponse> verifyOTP(
      BuildContext context,String email,String otp) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      var formData = FormData.fromMap({
        'email': email,
        'otp':otp
      });
      var response = await dio.post("verify_otp",data:formData);
      if(response.statusMessage == 'Invalid otp entered'){
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      VerifyResponse objectResponse = VerifyResponse.fromJson(user);
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    return null;
  }

  static Future<RequestOtpResponse> requestOTP(
      BuildContext context,String email) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      var formData = FormData.fromMap({
        'email': email,
      });
      print('email '+email);
      var response = await dio.post("request_otp",data:formData);
      print('code : ${response}');
        ToastUtils.show('${response.data['email'].elementAt(0)}');
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      RequestOtpResponse objectResponse = RequestOtpResponse.fromJson(user);
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    DialogUtils.hideProgress(context);
    return null;
  }

  static Future<UserSubscriptionPlansResponse> getUserSubscription(
      BuildContext context) async {
    try {
      var dio = await getApi();
      print("KNet -> Get Subscription Screen -> API Request -> ");
      var response = await dio.get("get_user_subscription_details");
      print('code : ${response.statusCode}');
      if(response.statusCode==401){
        // ToastUtils.show('Email or Password is incorrect');
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      UserSubscriptionPlansResponse objectResponse = UserSubscriptionPlansResponse.fromJson(user);
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    DialogUtils.hideProgress(context);
    return null;
  }

  static Future<SubscriptionPlansResponse> getSubscription(
      BuildContext context) async {
    try {
      var dio = await getApi();
      print("KNet -> Get Subscription Screen -> API Request -> ");
      var response = await dio.get("get_plans");
      print('code : ${response.statusCode}');
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      SubscriptionPlansResponse objectResponse = SubscriptionPlansResponse.fromJson(user);
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    DialogUtils.hideProgress(context);
    return null;
  }

  static Future<AddSubscriptionResponse> postSubscription(
      BuildContext context) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      print("KNet -> Get Subscription Screen -> API Request -> ");
      var formData = FormData.fromMap({
        'subscription_type': 'monthly',
      });
      var response = await dio.post("add_subscription",data:formData);
      print(response.data.toString());
      print('code : ${response.statusCode}');
      if(response.statusCode==401){
        ToastUtils.show('Email or Password is incorrect');
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      AddSubscriptionResponse objectResponse = AddSubscriptionResponse.fromJson(user);
      EasyLoading.dismiss();
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    return null;
  }

  static Future<AddReviewResponse> addReview(
      BuildContext context, String comment, String rating) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      int id = sharedPreferences.getInt("id");
      print('??????????????'+sharedPreferences.getString(Keys.userID));
      var dio = await getAPI(context,token);
      print("KNet -> Get Subscription Screen -> API Request -> ");
      var formData = FormData.fromMap({
        'seller_id': id,
        'review': comment,
        'rating': rating
      });
      var response = await dio.post("add_review",data:formData);
      print(formData);
      print('code : ${response.statusCode}');
      if(response.statusCode==401){
        ToastUtils.show('Email or Password is incorrect');
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      AddReviewResponse objectResponse = AddReviewResponse.fromJson(user);
      EasyLoading.dismiss();
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    return null;
  }



  static Future<ReviewDetailsResponse> reviewDetails(
      BuildContext context) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      print("KNet -> reviewDetails -> API Request -> ");
      var response = await dio.get("review_details",);
      print('code : ${response.statusCode}');
      if(response.statusCode==401){
        ToastUtils.show('Email or Password is incorrect');
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      ReviewDetailsResponse objectResponse = ReviewDetailsResponse.fromJson(user);
      EasyLoading.dismiss();
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    return null;
  }

  static Future<DeleteReviewResponse> deleteReview(
      BuildContext context,String _id) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      print('review ID'+_id);
      print("KNet -> Get ReviewRating Screen -> API Request -> ");
      var formData = FormData.fromMap({
        'review_id': _id,
      });
      var response = await dio.post("delete_review",data: formData);
      var name=response.data['message'];
      print('code : ${response.statusCode}');
      if(response.statusCode==401){
        ToastUtils.show('Email or Password is incorrect');
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      DeleteReviewResponse objectResponse = DeleteReviewResponse.fromJson(user);
      EasyLoading.dismiss();
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    return null;
  }

  static Future<GetProfileResponse> getProfile(
      BuildContext context) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      print("KNet -> Get Subscription Screen -> API Request -> ");
      var response = await dio.get("get_profile");
      print('code : ${response.statusCode}');
      if(response.statusCode==401){
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      GetProfileResponse objectResponse = GetProfileResponse.fromJson(user);
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    DialogUtils.hideProgress(context);
    return null;
  }
  static Future updateProfile(
      BuildContext context,String name,String email, String mobile,String location,
      String description, String sellerType, String businessName, String fbAddress,
      String igAddress, var lat, var lng) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      print("KNet -> Get Subscription Screen -> API Request -> ");
      var formData = FormData.fromMap({
        'name':name,
        'mobile': mobile,
        'location':location,
        'description':description,
        'seller_type': sellerType,
        'business_name': businessName,
        'fb_address': fbAddress,
        'ig_address': igAddress,
        'lat': lat,
        'lng': lng
      });
      var response = await dio.post("update_profile",data: formData);
      print('code : ${response.data.containsKey('error')}');
      if(response.data.containsKey('error')){
        //print("<><><>><>"+response.data['error'].toString());
        return response.data;
      }else {
        String responseOfApi = response.toString();
        Map<String, dynamic> user = json.decode(responseOfApi);
        UpdateProfileResponse objectResponse = UpdateProfileResponse.fromJson(
            user);
        return objectResponse;
      }
    } catch (e) {
      //PrintUtils.printLog(e);
    }
    return null;
  }
  static Future<UpdateProfilePictureResponse> updateProfilePic(
      BuildContext context,File file) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      print("KNet -> Get Subscription Screen -> API Request -> ");
      String fileName = file.path.split('/').last;
      var formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(file.path, filename:fileName),
      });
      var response = await dio.post("edit_profile_picture",data: formData);
      print('code : ${response.statusCode}');
      if(response.statusCode==401){
        // ToastUtils.show('Email or Password is incorrect');
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      UpdateProfilePictureResponse objectResponse = UpdateProfilePictureResponse.fromJson(user);
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    return null;
  }

  /* User API */

  static Future<SingleUserDetailsResponse> singleUserDetails(
      BuildContext context) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      print("KNet -> Get Subscription Screen -> API Request -> ");
      var formData = FormData.fromMap({
        'id': '2'
      });
      var response = await dio.post("single_user_details",data:formData);
      print('code : ${response.statusCode}');
      if(response.statusCode==401){
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      SingleUserDetailsResponse objectResponse = SingleUserDetailsResponse.fromJson(user);
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    DialogUtils.hideProgress(context);
    return null;
  }

  static Future<AllUserDetailsResponse> allUserDetails(
      BuildContext context) async {
    try {
      String token= sharedPreferences.getString(Keys.accessToken);
      var dio = await getAPI(context,token);
      print("KNet -> Get Subscription Screen -> API Request -> ");
      var response = await dio.get("user_details");
      print('code : ${response.statusCode}');
      if(response.statusCode==401){
      }
      String responseOfApi = response.toString();
      Map<String, dynamic> user = json.decode(responseOfApi);
      AllUserDetailsResponse objectResponse = AllUserDetailsResponse.fromJson(user);
      return objectResponse;
    } catch (e) {
      PrintUtils.printLog(e);
    }
    DialogUtils.hideProgress(context);
    return null;
  }

  static Future<Map<String, dynamic>> getAboutUsInfo()async{
    Map<String, dynamic> responseData;
    var headers = {
      'timeZone': 'GMT+5:30'
    };
    var request = http.Request('POST', Uri.parse('https://demos.mydevfactory.com/debarati/knet/public/api/get/aboutus'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      responseData = jsonDecode(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
    return responseData;
  }

  static Future<Map<String, dynamic>> getContactUsInfo()async{
    Map<String, dynamic> responseData;
    var headers = {
      'timeZone': 'GMT+5:30'
    };
    var request = http.Request('POST', Uri.parse('https://demos.mydevfactory.com/debarati/knet/public/api/get/contactus'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      responseData = jsonDecode(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
    return responseData;
  }

  static Future<Map<String, dynamic>> getTnCInfo()async{
    Map<String, dynamic> responseData;
    var headers = {
      'timeZone': 'GMT+5:30'
    };
    var request = http.Request('POST', Uri.parse('https://demos.mydevfactory.com/debarati/knet/public/api/get/terms/conditions'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      responseData = jsonDecode(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
    return responseData;
  }

  static Future<Map<String, dynamic>> getFaq()async{
    Map<String, dynamic> responseData;
    var headers = {
      'timeZone': 'GMT+5:30'
    };
    var request = http.Request('POST', Uri.parse('https://demos.mydevfactory.com/debarati/knet/public/api/get/faqs'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      responseData = jsonDecode(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
    return responseData;
  }

  static Future<Map<String, dynamic>> getUsersLocation(sellerType, lat, lng)async{
    String token= sharedPreferences.getString(Keys.accessToken);
    Map<String, dynamic> responseData;
    var request = http.MultipartRequest('POST', Uri.parse('https://demos.mydevfactory.com/debarati/knet/public/api/userfind'));
    request.fields.addAll({
      'seller_type': sellerType,
      'lat': lat.toString(),
      'lng': lng.toString()
    });

    request.headers.addAll({"Authorization" : "Bearer $token"});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      responseData = jsonDecode(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
    return responseData;
  }

}
