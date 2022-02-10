import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knet/forgot_password_screen.dart';
import 'package:knet/provider/login_provider.dart';
import 'package:knet/provider/register_provider.dart';
import 'package:knet/provider/subscription_provider.dart';
import 'package:knet/screen/MapScreen.dart';
import 'package:knet/screen/OnBoardingScreen.dart';
import 'package:knet/screen/get_markers.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:knet/Network/Response/LoginResponse.dart';


class AuthForm extends StatefulWidget {
  final bool isLoading;
  final bool isSignIn;

  AuthForm(this.isLoading, this.isSignIn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  var _username = TextEditingController();
  var _firstname = TextEditingController();
  var _password = TextEditingController();
  var _email = TextEditingController();
  var _mobile = TextEditingController();
  var _cpassword = TextEditingController();
  var _lpassword = TextEditingController();

  LoginResponse _loginResponse;


  bool didSelectedPosition = false,
      didSelectBranch = false,
      didSelecTermsAndConditions = false,
      didSelectStore = false,
      didRegisterSucessFully = false;
  String phoneNumberText = "",
      localCountryValue = "IN +91",
      countryCode = "",
      sendCountryCodeValue = "",
     ctedRetailerID = "";
  Country _selectedCountry;
  bool isCountrySelected = false;
  bool didChangedCountryCode = false;
  var selectedStore = "Founder", selectedBrach = "", selectedPosition = "";


  var _register;
  var _login;
  var _subscription;
  var _isLogin;
  bool isLoginPasswordShow = true;
  bool isSignupPasswordShow = true;
  bool isSignupCPasswordShow = true;
  bool isShow = false;
  bool isColor = false;
  var _userName = '';
  var _userEmail = '';
  var _userPassword = '';
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isLogin = widget.isSignIn;
    });
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    _register = Provider.of<RegisterProvider>(context, listen: false);
    _login = Provider.of<LoginProvider>(context, listen: false);
    _subscription=Provider.of<SubscriptionProvider>(context, listen: false);

    super.initState();
    triggerObservers();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // _femail.dispose();
    // _fPassword.dispose();
    super.dispose();
  }

  void triggerObservers() {
    WidgetsBinding.instance.addObserver(this);
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {

      _formKey.currentState.save();

      if (!_isLogin) {
        Future.delayed(Duration.zero, () {
          this.hitpostRegister();
        });
      }
      if (_isLogin) {
        Future.delayed(Duration.zero, () {
          this.hitpostLogin();
        });
      }

    }
  }
  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {

        didChangedCountryCode = true;
        _selectedCountry = country;
        print("o1");
        print(_selectedCountry.callingCode.toString());
        sendCountryCodeValue = _selectedCountry.callingCode.toString();
        countryCode = _selectedCountry.countryCode.toString();
        countryCode =
            countryCode + " " + _selectedCountry.callingCode.toString();
        print(countryCode);
        isCountrySelected = true;
      });
    }
  }

  Widget _ownerPhoneNumberWidget(BuildContext context) {
    // if (didChangedCountryCode == false) {
    //   Locale myLocale = Localizations.localeOf(context);
    //   print(myLocale.countryCode);
    //
    //   final Locale deviceLocale = CountryCodes.getDeviceLocale();
    //   final CountryDetails details = CountryCodes.detailsForLocale();
    //   localCountryValue = deviceLocale.countryCode + " " + details.dialCode;
    //   sendCountryCodeValue = details.dialCode;
    // }

    return
      Container(
      // margin: EdgeInsets.only( top: 8),
      color: Colors.white,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ))),
            child: Column(
              children: <Widget>[
                Container(
                    width: 100,
                    height: 60,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: FlatButton(
                        color: Colors.white,
                        onPressed: () {
                          _showCountryPicker();
                        },
                        child: Text(
                          isCountrySelected ? countryCode : localCountryValue,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ))),
              ],
            ),
          ),
          SizedBox(width: 8),
          new Flexible(
            child:
            TextFormField(
              key: ValueKey('mobile'),
              focusNode: _focusNodes[1],
              controller: _mobile,
              cursorColor: parseHexColor('#343537'),

              validator: (value) {
                if (value.isEmpty ) {
                  return 'Please enter mobile number';
                }
                return null;
              },
              style: TextStyle(
                  color: _focusNodes[1].hasFocus
                      ? parseHexColor('#343537')
                      : Colors.grey),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                // fillColor: parseHexColor('#F8F6F8'),
                filled: true,
                fillColor: Colors.white,
                // contentPadding:
                // EdgeInsets.only(top: 20.0, bottom: 20.0),
              ),
              onSaved: (newValue) {
                _userEmail = newValue;
              },
              onFieldSubmitted: (value) {
                isColor = !isColor;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  _createAccountView(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 8, top: 8),
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_isLogin ? " Dont Have An Account?" : 'Already Have An Account?',
              style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.normal,
                  color: Color(0XFF767676))),
          SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         /* builder: (_) => ChooseYourPlanPage(),*/
              //         builder: (_) => OnBoardingScreen(),
              //       ),
              //     );
              setState(() {
                _isLogin = !_isLogin;
              });
            },
            child: Text(_isLogin ? " Sign Up" : 'Sign In',
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA23FA2),)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _isLogin ? 'Sign In' : 'Signup',
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            color: parseHexColor('#343537'),
                            fontSize: 24,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('firstname'),
                          focusNode: _focusNodes[6],
                          controller: _firstname,
                          cursorColor: parseHexColor('#343537'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter First Name';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: _focusNodes[6].hasFocus
                                  ? parseHexColor('#343537')
                                  : Colors.grey),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                            ),
                            fillColor: Colors.white,
                            // contentPadding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          ),
                          onSaved: (newValue) {
                            _userEmail = newValue;
                          },
                          onFieldSubmitted: (value) {
                            isColor = !isColor;
                            setState(() {});
                          },
                        ),

                      // SizedBox(
                      //   height: 12,
                      // ),

                      if (!_isLogin)
                        SizedBox(
                          height: 12,
                        ),
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('username'),
                          focusNode: _focusNodes[0],
                          controller: _username,
                          cursorColor: parseHexColor('#343537'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter valid Email ID';
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
                            // contentPadding:
                            //     EdgeInsets.only(top: 20.0, bottom: 20.0),
                          ),
                          onSaved: (newValue) {
                            _userEmail = newValue;
                          },
                          onFieldSubmitted: (value) {
                            isColor = !isColor;
                            setState(() {});
                          },
                        ),

                      // SizedBox(
                      //   height: 12,
                      // ),

                      if (!_isLogin)
                        SizedBox(
                          height: 12,
                        ),
                      if (!_isLogin)
                        _ownerPhoneNumberWidget(context),

                      if (!_isLogin)
                        SizedBox(
                          height: 12,
                        ),
                      if (!_isLogin)
                        TextFormField(
                            key: ValueKey('password'),
                            focusNode: _focusNodes[2],
                            controller: _password,
                            style: TextStyle(
                                color: _focusNodes[2].hasFocus
                                    ? parseHexColor('#343537')
                                    : Colors.grey),
                            validator: (value) {
                              if (value.isEmpty || value.length < 7) {
                                return 'Password must be atleast 7 characters';
                              }
                              return null;
                            },
                            cursorColor: parseHexColor('#343537'),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                              ),
                              fillColor: Colors.white,
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSignupPasswordShow =
                                          !isSignupPasswordShow;
                                    });
                                  },
                                  child: Icon(
                                    isSignupPasswordShow
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.lock_outline,
                                    color: _focusNodes[1].hasFocus
                                        ? Colors.white
                                        : Colors.grey,
                                  )),
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              // ),
                            ),
                            obscureText: isSignupPasswordShow,
                            onSaved: (newValue) {
                              _userPassword = newValue;
                            }),
                      if (!_isLogin)
                        SizedBox(
                          height: 12,
                        ),
                      if (!_isLogin)
                        TextFormField(
                            key: ValueKey('cpassword'),
                            focusNode: _focusNodes[3],
                            controller: _cpassword,
                            style: TextStyle(
                                color: _focusNodes[3].hasFocus
                                    ? parseHexColor('#343537')
                                    : Colors.grey),
                            validator: (value) {
                              if (value.isEmpty || value.length < 8) {
                                return 'Password must be atleast 8 characters';
                              }
                              else if (value !=_password.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            cursorColor: parseHexColor('#343537'),
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                              ),
                              fillColor: Colors.white,
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSignupCPasswordShow =
                                          !isSignupCPasswordShow;
                                    });
                                  },
                                  child: Icon(
                                    isSignupCPasswordShow
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.lock_outline,
                                    color: _focusNodes[1].hasFocus
                                        ? Colors.white
                                        : Colors.grey,
                                  )),
                            ),
                            obscureText: isSignupCPasswordShow,
                            onSaved: (newValue) {
                              _userPassword = newValue;
                            }),
                      if (_isLogin)
                        TextFormField(
                          key: ValueKey('email'),
                          focusNode: _focusNodes[4],
                          controller: _email,
                          cursorColor: parseHexColor('#343537'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter valid Username';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: _focusNodes[4].hasFocus
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
                            // contentPadding:
                            //     EdgeInsets.only(top: 20.0, bottom: 20.0),
                          ),
                          onSaved: (newValue) {
                            _userEmail = newValue;
                          },
                          onFieldSubmitted: (value) {
                            isColor = !isColor;
                            setState(() {});
                          },
                        ),
                      if (_isLogin)
                        SizedBox(
                          height: 12,
                        ),
                      if (_isLogin)
                        TextFormField(
                            key: ValueKey('lpassword'),
                            focusNode: _focusNodes[5],
                            controller: _lpassword,
                            style: TextStyle(
                                color: _focusNodes[5].hasFocus
                                    ? parseHexColor('#343537')
                                    : Colors.grey),
                            validator: (value) {
                              if (value.isEmpty || value.length < 7) {
                                return 'Password must be atleast 7 characters';
                              }
                              return null;
                            },
                            cursorColor: parseHexColor('#343537'),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                              ),
                              fillColor: Colors.white,
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isLoginPasswordShow = !isLoginPasswordShow;
                                    });
                                  },
                                  child: Icon(
                                    isLoginPasswordShow
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.lock_outline,
                                    color: _focusNodes[1].hasFocus
                                        ? Colors.white
                                        : Colors.grey,
                                  )),
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              // ),
                            ),
                            obscureText: isLoginPasswordShow,
                            onSaved: (newValue) {
                              _userPassword = newValue;
                            }),
                      SizedBox(
                        height: 24,
                      ),
                      // if (widget.isLoading) CircularProgressIndicator(),
                      if (!widget.isLoading)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFFA23FA2),
                              // gradient: LinearGradient(
                              //     begin: Alignment.centerLeft,
                              //     end: Alignment.centerRight,
                              //     colors: [Colors.purple, Colors.blue]),0
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          height: 50,
                          child: FlatButton(
                            child: Text(
                              _isLogin ? 'Login to Continue' : 'SUBMIT NOW',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: _trySubmit,
                          ),
                        ),
                      SizedBox(height: 24),
                      if (!widget.isLoading)
                        FlatButton(
                            child: Text(
                              _isLogin
                                  ? 'Forgot Password?'
                                  : 'I already have an account',
                              style: TextStyle(color: Colors.grey),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  /* builder: (_) => ChooseYourPlanPage(),*/
                                  builder: (_) => ForgotPasswordScreen(),
                                ),
                              );

                              // setState(() {
                              //   _isLogin = !_isLogin;
                              // });
                            }),
                      /*if (_isLogin) SizedBox(height: 54),
                      if (_isLogin) SizedBox(height: 36.0),*/
                      SizedBox(height: 54),
                      _createAccountView(context),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  hitpostRegister() async {
    _register.doRegister(context, _firstname.text, _username.text, _mobile.text,
        _password.text, _cpassword.text);
  }

  hitpostLogin() async {
    _login.doLogin(context, _email.text, _lpassword.text);
    // await initPref();
  }
  clearPref() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences?.setString(Keys.emailID, '0');
    await sharedPreferences?.setString(Keys.password, '0');
    await sharedPreferences?.setString(
        Keys.userID, '0');
    await sharedPreferences?.setString(
        Keys.accessToken, '0');
  }
  initPref() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences?.setString(Keys.emailID, '0');
    await sharedPreferences?.setString(Keys.password, '0');
    await sharedPreferences?.setString(
    Keys.userID, '0');
    await sharedPreferences?.setString(
    Keys.accessToken, '0');
    _loginResponse =await _login.getLoginRes();
    await sharedPreferences?.setString(Keys.emailID, _loginResponse.accessToken);
    await sharedPreferences?.setString(Keys.password, _loginResponse.accessToken);
    await sharedPreferences?.setString(
        Keys.userID, _loginResponse.accessToken);
    await sharedPreferences?.setString(
        Keys.accessToken, _loginResponse.accessToken);
    print("KNET ACCESSTOKEN "+sharedPreferences.get(Keys.accessToken));
    print("KNET RESPONSE ACCESSTOKEN "+_loginResponse.accessToken);
    if(_loginResponse.statusCode == 200){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetPosition()),
      );
    }

    // await sharedPreferences?.clear();
  }
}
