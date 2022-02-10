import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knet/screen/OTPVerificationScreen.dart';
import 'package:knet/screen/OnBoardingScreen.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:provider/provider.dart';
import 'package:knet/provider/forgot_password_provider.dart';


import '../screen/auth_screen.dart';

class ForgotPassword extends StatefulWidget {
  final bool isLoading;
  ForgotPassword(this.isLoading);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();

  var _otp1 = TextEditingController();
  var _otp2 = TextEditingController();
  var _otp3 = TextEditingController();
  var _otp4 = TextEditingController();


  var _isLogin = true;
  bool isShow = false;
  bool isColor = false;
  var _forgotPassword;
  var _userName = '';
  var _userEmail = '';
  var _userPassword = '';
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    _forgotPassword = Provider.of<ForgotPasswordProvider>(context, listen: false);
    super.initState();
  }

  void _trySubmit() {

    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(_isLogin) {
      if (isValid) {
        // widget.submitFn(_userEmail.trim(), _userPassword, _userName.trim(), _isLogin,context);
        _formKey.currentState.save();
        Future.delayed(Duration.zero, () {
          this.hitpostRequestOTP();
        });
      }
    }
    else
      {
        if (isValid) {
          // widget.submitFn(_userEmail.trim(), _userPassword, _userName.trim(), _isLogin,context);
          _formKey.currentState.save();
          Future.delayed(Duration.zero, () {
            this.hitpostVerifyOTP();
          });
        }
      }
  }

  hitpostVerifyOTP() async {
    await _forgotPassword.verifyOTP(context, _email.text,_otp1.text+_otp2.text+_otp3.text+_otp4.text);

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => MapScreen()),
    // );
    // setState(() {
    //   _isLogin = !_isLogin;
    // });
  }

  hitpostRequestOTP() async {
    await _forgotPassword.requestOTP(context, _email.text,);
    setState(() {
      _isLogin = !_isLogin;
    });
  }
  _createAccountView(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 8, top: 8),
      height: 25,
      child: FlatButton(
        onPressed: () {
          // __pushTORegistrationScreen();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                _isLogin
                    ? " Dont Have An Account?"
                    : 'Already Have An Account?',
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "WorkSans",
                    fontWeight: FontWeight.normal,
                    color: Color(0XFF767676))),
            SizedBox(width: 4),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    /* builder: (_) => ChooseYourPlanPage(),*/
                    builder: (_) => OnBoardingScreen(),
                  ),
                );
                // setState(() {
                //   _isLogin = !_isLogin;
                // });
              },
              child: Text(_isLogin ? " Sign Up" : 'Sign In',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: "WorkSans",
                      fontWeight: FontWeight.w500,
                      color: parseHexColor('#0C5CCD'))),
            )
          ],
        ),
      ),
    );
  }

  _socialView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            width: 120,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: parseHexColor('#B6B7B9')),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/gl.png",
                    // fit: BoxFit.cover,
                  ),
                  SizedBox(width: 8.0),
                  Text('Google')
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Flexible(
          child: Container(
            // padding: EdgeInsets.only(left: 8,right: 8),
            width: 120,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: parseHexColor('#B6B7B9')),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/fb.png",

                    // fit: BoxFit.cover,
                  ),
                  SizedBox(width: 8.0),
                  Text('Facebook')
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _dividerView(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Color(0XFF898989).withOpacity(0.5),
            height: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32),
          child: Text(
            "OR",
            style: TextStyle(color: Color(0XFF898989)),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0XFF898989).withOpacity(0.5),
            height: 1,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.center,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      _isLogin ? 'Forgot Password' : 'Verification Code',
                      style: TextStyle(
                        color: parseHexColor('#343537'),
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 26,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      _isLogin
                          ? 'Enter your registered email address'
                          : 'Please type the verifaction code send to',
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        color: parseHexColor('#646464'),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    if (!_isLogin)
                      Text(
                             '6824621132',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                          color: parseHexColor('#646464'),
                        ),
                      ),
                    SizedBox(
                      height: 40,
                    ),
                    if (!_isLogin)
                      Container(
                          margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: SizedBox(
                                  width: 80,
                                  child: new TextFormField(
                                    controller: _otp1,
                                    cursorColor: Colors.white70,
                                    textAlign: TextAlign.center,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    // controller: _controller,
                                    autofocus: false,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "WorkSans",
                                        color: Colors.blue),
                                    decoration: InputDecoration(
                                      filled: true,
                                      isDense: true,
                                      // border: OutlineInputBorder(
                                      //   borderSide: BorderSide.none,
                                      //   borderRadius: BorderRadius.circular(10),
                                      // ),
                                      fillColor: Colors.white,
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Color(0XFF898989)
                                              .withOpacity(0.5),
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
                              ),
                              SizedBox(width: 8),
                              SizedBox(
                                width: 80,
                                child: new TextFormField(
                                  controller: _otp2,
                                  cursorColor: Colors.white70,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  keyboardType:
                                      TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  // controller: _controller,
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: "WorkSans",
                                      color: Colors.blue),
                                  decoration: InputDecoration(
                                    filled: true,
                                    isDense: true,
                                    // border: OutlineInputBorder(
                                    //   borderSide: BorderSide.none,
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    fillColor: Colors.white,
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
                                width: 80,
                                child: new TextFormField(
                                  controller: _otp3,
                                  textAlign: TextAlign.center,
                                  cursorColor: Colors.white70,
                                  keyboardType:
                                      TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  // controller: _controller,
                                  autofocus: false,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: "WorkSans",
                                      color: Colors.blue),
                                  decoration: InputDecoration(
                                    filled: true,
                                    isDense: true,

                                    fillColor: Colors.white,
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
                              Expanded(
                                child: SizedBox(
                                  width: 80,
                                  child: new TextFormField(
                                    controller: _otp4,
                                    textAlign: TextAlign.center,
                                    cursorColor: Colors.white70,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    // controller: _controller,
                                    autofocus: false,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "Roboto",
                                        color: Colors.blue),
                                    decoration: InputDecoration(
                                      filled: true,
                                      isDense: true,

                                      fillColor: Colors.white,
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
                              ),
                              SizedBox(width: 8),
                            ],
                          )),
                    if (_isLogin)
                      TextFormField(
                        key: ValueKey('email'),
                        controller: _email,
                        focusNode: _focusNodes[0],
                        cursorColor: parseHexColor('#343537'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter valid Username';
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: _focusNodes[0].hasFocus
                                ? parseHexColor('#343537')
                                : Colors.grey),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Emai Address',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                          ),
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.only(top: 20.0, bottom: 20.0),

                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: _focusNodes[0].hasFocus
                                ? Colors.white
                                : Colors.grey,
                          ),
                          filled: true,
                        ),
                        onSaved: (newValue) {
                          _userEmail = newValue;
                        },
                        onFieldSubmitted: (value) {
                          isColor = !isColor;
                          setState(() {});
                        },
                      ),
                    // if(_isLogin)
                    SizedBox(
                      height: 40,
                    ),

                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: parseHexColor('#0C5CCD'),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        height: 50,
                        child: FlatButton(
                          child: Text(
                            _isLogin ? 'Continue' : 'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed:


                              _trySubmit,
                        ),
                      ),
                    SizedBox(height: 40),
                    if (!widget.isLoading)
                      FlatButton(
                          child: Text(
                            _isLogin ? 'Cancel' : 'Resend',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {
                            if(_isLogin)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  /* builder: (_) => ChooseYourPlanPage(),*/
                                  builder: (_) => AuthScreen(true),
                                ),
                              );

                          }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
