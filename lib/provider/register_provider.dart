import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/Network/Response/RegisterResponse.dart';
import '../main.dart';
import '/screen/auth_screen.dart';
import 'package:knet/screen/SubscriptionPlanScreen.dart';
import 'package:knet/utils/PinEntryTextField.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:knet/utils/ToastUtils.dart';

class RegisterProvider extends ChangeNotifier {
  bool isFetching = true;

  RegisterResponse _getRegisterResponse = new RegisterResponse();

  setRegisterRes(RegisterResponse data) {
    _getRegisterResponse = data;

    isFetching = false;
    notifyListeners();
  }

  RegisterResponse getRegisterRes() {
    return _getRegisterResponse;
  }

  savePref(BuildContext context, RegisterResponse data) async {
    await sharedPreferences?.setString(Keys.emailID, data.accessToken);
    await sharedPreferences?.setString(Keys.password, data.accessToken);
    await sharedPreferences?.setString(Keys.userID, data.accessToken);
    await sharedPreferences?.setString(Keys.accessToken, data.accessToken);
    print("KNET ACCESSTOKEN " + sharedPreferences.get(Keys.accessToken));
    print("KNET RESPONSE ACCESSTOKEN " + data.accessToken);
    notifyListeners();
  }

  void doRegister(
    BuildContext context,
    String firstname,
    String email,
    String mobile,
    String password,
    String cpassword,
    // String isSubscribedToNewsletters,
    // String planId,
    // String specialoffer
  ) async {
    try {
      var getRegisterResponse = await ApiHandler.Register(
          context, firstname, email, mobile, password, cpassword);
      if (getRegisterResponse?.statusCode == 200) {
        setRegisterRes(getRegisterResponse);
        savePref(context, getRegisterResponse);
        ToastUtils.show('Success');
        EasyLoading.showToast('Success');
        // showDialog(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SubscriptionPlanScreen(true)),
        );
        print("Register api hit successfully Go for HomePage");
      } else {
        EasyLoading.showToast('Could not register, try later');
        ToastUtils.show(getRegisterResponse.message);
        print("error in Register api $getRegisterResponse");
      }
    } catch (e) {
      // EasyLoading.showToast(_getRegisterResponse.message);
      print("KNet -> doRegister() -> ${e.toString()}");
    }
    /*  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);*/
  }

  void showDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black.withOpacity(0.4),
        transitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        },
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 50, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 250,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Verify Email Address",
                      style: new TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "We have sent you an OTP on your email address. Please enter the OTP below to verify your email address.",
                      textAlign: TextAlign.center,
                      style:
                          new TextStyle(color: Colors.white70, fontSize: 14.0),
                    ),
                    PinEntryTextField(
                      showFieldAsBox: false,
                      fields: 6,
                      textColor: Colors.white,
                      cursorColor: parseHexColor(StringUtils.themeColor),
                      onSubmit: (String pin) {
                        // when all the fields are filled
                        // submit function runs with the pin,need to add verify otp api after development
                        Navigator.of(context).pop();
                        print(pin);
                      }, // end onSubmit
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
