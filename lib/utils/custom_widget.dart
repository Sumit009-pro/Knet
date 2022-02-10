import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PinEntryTextField.dart';
import 'StringUtils.dart';
import 'ToastUtils.dart';

class CustomWidget {
  static Widget getTextFormFieldForBeneficiary(BuildContext context,
      TextEditingController controller, String label, String hintText,
      {bool isPass = false,
      onChange,
      validator,
      keyboardType,
      color,
      icon,
      enabled}) {
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: Colors.grey,
          indicatorColor: Colors.grey,
          hintColor: Colors.grey),
      child: TextFormField(
        enabled: enabled,
        cursorColor: Colors.white,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
        controller: controller,
        obscureText: isPass,
        decoration: new InputDecoration(
          border: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          filled: true,
          fillColor: Colors.grey,
          suffixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          // labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
        ),
        onChanged: (value) {
          onChange(value);
        },
        validator: validator,
      ),
    );
  }

  static void showOTPview(BuildContext context, enteredEmail) {
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
                        // Provider.of<GetProfileProvider>(context, listen: false)
                        //     .getNewEmailEnterVerify(context, enteredEmail, pin);
                        ToastUtils.show('test');
                        print(pin);
                      }, // end onSubmit
                    ),
                    /* PinView (
                        count: 6, // describes the field number
                        autoFocusFirstField: false, // defaults to true
                        margin: EdgeInsets.all(2.5), // margin between the fields
                        obscureText: false, // describes whether the text fields should be obscure or not, defaults to false
                        style: TextStyle (
                          // style for the fields
                            fontSize: 19.0,
                            fontWeight: FontWeight.w500
                        ),
                        dashStyle: TextStyle (
                          // dash style
                            fontSize: 25.0,
                            color: Colors.grey
                        ),
                        submit: (String pin) {
                          // when all the fields are filled
                          // submit function runs with the pin,need to add verify otp api after development
                          Navigator.of(context).pop();
                          Provider.of<GetProfileProvider>(context,listen: false).getNewEmailEnterVerify(context, enteredEmail, pin);
                          ToastUtils.show('test');
                          print(pin);
                        }
                    ),*/
                  ],
                ),
              ),
            ),
          );
        });
  }

  static void showToast({
    @required BuildContext context,
  }) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(builder: (context) => ToastWidget());
    Overlay.of(context).insert(overlayEntry);
    Timer(Duration(seconds: 2), () => overlayEntry.remove());
  }
}

class ToastWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10.0,
      left: 5.0,
      child: Container(
        color: Colors.transparent,
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
