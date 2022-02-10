import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/Network/Response/AddReviewResponse.dart';
import 'package:knet/Network/Response/ReviewDetailsResponse.dart';
import 'package:knet/Network/Response/DeleteReviewResponse.dart';
import 'package:knet/utils/ToastUtils.dart';
import '../screen/auth_screen.dart';

class ReviewProvider extends ChangeNotifier {
  bool isFetching = true;

  AddReviewResponse _getAddReviewResponse = new AddReviewResponse();
  ReviewDetailsResponse _getReviewDetailsResponse = new ReviewDetailsResponse();
  DeleteReviewResponse _getDeleteReviewResponse = new DeleteReviewResponse();


  setAddReviewResponse(AddReviewResponse data) {
    _getAddReviewResponse = data;

    isFetching = false;
    notifyListeners();
  }

  AddReviewResponse getAddReviewResponse() {
    return _getAddReviewResponse;
  }

  void addReview(BuildContext context, String comment, String rating) async {
    try {
      var _getAddReviewResponse =
          await ApiHandler.addReview(context, comment, rating);
      if (_getAddReviewResponse?.statusCode == 200) {
        setAddReviewResponse(_getAddReviewResponse);
        ToastUtils.show('Success');
        print("getSubscription api hit successfully Go for HomePage");
      } else if (_getAddReviewResponse?.statusCode == 404) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (_getAddReviewResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        // EasyLoading.showToast('Could not login, try later');
        //ToastUtils.show(_getAddReviewResponse.message);
        print("error in doLogin api $_getAddReviewResponse");
      }
    } catch (e) {
      EasyLoading.showToast('Could not fetch subscription, try later');
      print("Knet -> getSubscription() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }

  setReviewDetailsResponse(ReviewDetailsResponse data) {
    _getReviewDetailsResponse = data;

    isFetching = false;
    notifyListeners();
  }

  ReviewDetailsResponse getReviewDetailsResponse() {
    return _getReviewDetailsResponse;
  }

  void reviewDetails(BuildContext context) async {
    try {
      var _getReviewDetailsResponse = await ApiHandler.reviewDetails(context);
      if (_getReviewDetailsResponse?.statusCode == 200) {
        setReviewDetailsResponse(_getReviewDetailsResponse);
        ToastUtils.show('Success');
        print("reviewDetails api hit successfully Go for HomePage");
      } else if (_getReviewDetailsResponse?.statusCode == 404) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (_getReviewDetailsResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        // EasyLoading.showToast('Could not login, try later');
        ToastUtils.show(_getReviewDetailsResponse.message);
        print("error in reviewDetails api $_getReviewDetailsResponse");
      }
    } catch (e) {
      EasyLoading.showToast('Could not fetch reviewDetails, try later');
      print("Knet -> reviewDetails() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }

/*Delete Review*/

  setDeleteReviewResponse(DeleteReviewResponse data) {
    _getDeleteReviewResponse = data;

    isFetching = false;
    notifyListeners();
  }

  DeleteReviewResponse getDeleteReviewResponse() {
    return _getDeleteReviewResponse;
  }

  void deleteReview(BuildContext context,String _id) async {
    try {
      var _getDeleteReviewResponse = await ApiHandler.deleteReview(context,_id);

      if (_getDeleteReviewResponse?.statusCode == 200) {
        setDeleteReviewResponse
          (_getDeleteReviewResponse);
        ToastUtils.show('Success');
        print("deleteReview api hit successfully Go for HomePage");
      } else if (_getDeleteReviewResponse?.statusCode == 404) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else if (_getDeleteReviewResponse?.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen(true)),
        );
      } else {
        // EasyLoading.showToast('Could not login, try later');
        ToastUtils.show(_getDeleteReviewResponse.message);
        print("error in deleteReview api $_getDeleteReviewResponse");
      }
    } catch (e) {
      EasyLoading.showToast('Could not fetch subscription, try later');
      print("Knet -> deleteReview() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }

}
