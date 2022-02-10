import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPVerification extends StatefulWidget {
  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: _appBarView(context),
          body:
          Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: SafeArea(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(32.0, 30.0, 16.0, 0.0),
                          child: Text(
                            'Enter the OTP you get in your phone'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto',
                                color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                            padding: EdgeInsets.fromLTRB(32.0, 30.0, 32.0, 30.0),
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 30,
                                  child: new TextField(
                                    cursorColor: Colors.white70,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                    // controller: _controller,
                                    autofocus: false,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "WorkSans",
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor: Color(0XFF898989).withOpacity(0.5),
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Color(0XFF898989).withOpacity(0.5),
                                          fontWeight: FontWeight.normal),
                                    ),
                                    onChanged: (text) {
                                      print("First text field: $text");

                                      if (text.length >= 1) {
                                        // firstDigitTextField = text;
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 30,
                                  child: new TextField(
                                    cursorColor: Colors.white70,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    keyboardType: TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                    // controller: _controller,
                                    autofocus: false,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "WorkSans",
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor: Color(0XFF898989).withOpacity(0.5),
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    onChanged: (text) {
                                      print("second text field: $text");
                                      if (text.length >= 1) {
                                        // secondDigitTextField = text;
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 40,
                                  child: new TextField(
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.white70,
                                    keyboardType: TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                    // controller: _controller,
                                    autofocus: false,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "WorkSans",
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor: Color(0XFF898989).withOpacity(0.5),
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    onChanged: (text) {
                                      print("Third text field: $text");

                                      if (text.length >= 1) {
                                        // thirdDigitTextField = text;
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 40,
                                  child: new TextField(
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.white70,
                                    keyboardType: TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                    // controller: _controller,
                                    autofocus: false,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "WorkSans",
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor: Color(0XFF898989).withOpacity(0.5),
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    onChanged: (text) {
                                      print("Fourth text field: $text");

                                      if (text.length >= 1) {
                                        // fourthDigitTextField = text;

                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 40,
                                  child: new TextField(
                                    cursorColor: Colors.white70,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                    // controller: _controller,
                                    autofocus: false,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "WorkSans",
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor: Color(0XFF898989).withOpacity(0.5),
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    onChanged: (text) {
                                      print("First text field: $text");

                                      if (text.length >= 1) {
                                        // fifthDigitTextField = text;
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 40,
                                  child: new TextField(
                                    cursorColor: Colors.white70,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                    // controller: _controller,
                                    autofocus: false,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "WorkSans",
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor: Color(0XFF898989).withOpacity(0.5),
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    onChanged: (text) {
                                      print("First text field: $text");

                                      if (text.length >= 1) {
                                        // sixthDigitTextField = text;
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(height: 64),
                        FractionallySizedBox(
                          // margin: EdgeInsets.only(left: 8, top: 8),
                            alignment: Alignment.center,
                            widthFactor: 0.7,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0XFFFF3668),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(60))),
                              height: 50,
                              width: 0,
                              child: FlatButton(
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                // color: Colors.green,
                                child: Text("Resend OTP",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.normal,
                                        color: Color(0XFFFFFFFF))),
                                onPressed: () {
                                  print("SUBMIT1");
                                },
                              ),
                            )),
                        SizedBox(height: 16),
                        FractionallySizedBox(
                          // margin: EdgeInsets.only(left: 8, top: 8),
                          //alignment: Alignment.center,
                            widthFactor: 0.7,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0XFFFF3668),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(60))),
                              height: 50,
                              width: 0,
                              child: FlatButton(
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                child:Text(
                                  '''Submit''',
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    height: 1.171875,
                                    fontSize: 40.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 255, 255, 255),

                                    /* letterSpacing: 0.0, */
                                  ),
                                ),


                                onPressed: () {
                                  // _verifyUser(context);
                                },
                              ),
                            )),
                        SizedBox(width: 16),
                      ])))),
    );
  }
}
