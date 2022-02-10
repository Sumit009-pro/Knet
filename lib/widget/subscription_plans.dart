// import 'package:country_calling_code_picker/country.dart';
// import 'package:country_calling_code_picker/functions.dart';
// import 'package:country_codes/country_codes.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:knet/forgot_password_screen.dart';
// import 'package:knet/provider/login_provider.dart';
// import 'package:knet/provider/subscription_provider.dart';
// import 'package:knet/screen/MapScreen.dart';
// import 'package:knet/screen/OnBoardingScreen.dart';
// import 'package:knet/utils/StringUtils.dart';
// import 'package:provider/provider.dart';
//
// class SubscriptionPlan extends StatefulWidget {
//   final bool isLoading;
//
//   // final void Function(
//   //     String email, String password, String username, bool isLogin,BuildContext ctx) submitFn;
//   // AuthForm(this.submitFn,this.isLoading);
//
//   SubscriptionPlan(this.isLoading);
//
//   @override
//   _SubscriptionPlanState createState() => _SubscriptionPlanState();
// }
//
// class _SubscriptionPlanState extends State<SubscriptionPlan> with WidgetsBindingObserver {
//   final _formKey = GlobalKey<FormState>();
//   var _username = TextEditingController();
//   var _firstname = TextEditingController();
//   var _password = TextEditingController();
//   var _email = TextEditingController();
//   var _mobile = TextEditingController();
//   var _cpassword = TextEditingController();
//   var _lpassword = TextEditingController();
//
//   bool didSelectedPosition = false,
//       didSelectBranch = false,
//       didSelecTermsAndConditions = false,
//       didSelectStore = false,
//       didRegisterSucessFully = false;
//   String phoneNumberText = "",
//       localCountryValue = "IN +91",
//       countryCode = "",
//       sendCountryCodeValue = "",
//       ctedRetailerID = "";
//   Country _selectedCountry;
//   bool isCountrySelected = false;
//   bool didChangedCountryCode = false;
//   var selectedStore = "Founder", selectedBrach = "", selectedPosition = "";
//
//
//   var _subscription;
//   var _login;
//   var _isLogin = true;
//   bool isLoginPasswordShow = true;
//   bool isSignupPasswordShow = true;
//   bool isSignupCPasswordShow = true;
//   bool isShow = false;
//   bool isColor = false;
//   var _userName = '';
//   var _userEmail = '';
//   var _userPassword = '';
//   List<FocusNode> _focusNodes = [
//     FocusNode(),
//     FocusNode(),
//     FocusNode(),
//     FocusNode(),
//     FocusNode(),
//     FocusNode(),
//     FocusNode(),
//   ];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   print("WidgetsBinding");
//     // });
//     _focusNodes.forEach((node) {
//       node.addListener(() {
//         setState(() {});
//       });
//     });
//     _subscription = Provider.of<SubscriptionProvider>(context, listen: false);
//     // _login = Provider.of<LoginProvider>(context, listen: false);
//
//     super.initState();
//     triggerObservers();
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     // _femail.dispose();
//     // _fPassword.dispose();
//     super.dispose();
//   }
//
//   void triggerObservers() {
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   void _trySubmit() {
//     final isValid = _formKey.currentState.validate();
//     FocusScope.of(context).unfocus();
//
//     if (isValid) {
//       // widget.submitFn(_userEmail.trim(), _userPassword, _userName.trim(), _isLogin,context);
//
//       _formKey.currentState.save();
//       // widget.submitFn(_userEmail.trim(), _userPassword, _userName.trim(), _isLogin,context);
//
//       if (!_isLogin) {
//         Future.delayed(Duration.zero, () {
//           this.hitpostSubscription();
//         });
//         // widget.submitFn(_userEmail.trim(), _userPassword, _userName.trim(), _isLogin,context);
//       }
//       if (_isLogin) {
//         Future.delayed(Duration.zero, () {
//           this.hitpostLogin();
//         });
//         // widget.submitFn(_userEmail.trim(), _userPassword, _userName.trim(), _isLogin,context);
//       }
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     /* builder: (_) => ChooseYourPlanPage(),*/
//       //     builder: (_) => MapScreen(),
//       //   ),
//       // );
//     }
//   }
//   void _showCountryPicker() async {
//     final country = await showCountryPickerSheet(
//       context,
//     );
//     if (country != null) {
//       setState(() {
//
//         didChangedCountryCode = true;
//         _selectedCountry = country;
//         print("o1");
//         print(_selectedCountry.callingCode.toString());
//         sendCountryCodeValue = _selectedCountry.callingCode.toString();
//         countryCode = _selectedCountry.countryCode.toString();
//         countryCode =
//             countryCode + " " + _selectedCountry.callingCode.toString();
//         print(countryCode);
//         isCountrySelected = true;
//       });
//     }
//   }
//
//   Widget _ownerPhoneNumberWidget(BuildContext context) {
//     // if (didChangedCountryCode == false) {
//     //   Locale myLocale = Localizations.localeOf(context);
//     //   print(myLocale.countryCode);
//     //
//     //   final Locale deviceLocale = CountryCodes.getDeviceLocale();
//     //   final CountryDetails details = CountryCodes.detailsForLocale();
//     //   localCountryValue = deviceLocale.countryCode + " " + details.dialCode;
//     //   sendCountryCodeValue = details.dialCode;
//     // }
//
//     return
//       Container(
//         // margin: EdgeInsets.only( top: 8),
//         color: Colors.white,
//         child: new Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(
//                         color: Colors.grey,
//                         width: 1.5,
//                       ))),
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                       width: 100,
//                       height: 75,
//                       color: Colors.white,
//                       alignment: Alignment.center,
//                       child: FlatButton(
//                           color: Colors.white,
//                           onPressed: () {
//                             _showCountryPicker();
//                           },
//                           child: Text(
//                             isCountrySelected ? countryCode : localCountryValue,
//                             style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontFamily: "Roboto",
//                                 fontStyle: FontStyle.normal,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.grey),
//                           ))),
//                 ],
//               ),
//             ),
//             SizedBox(width: 8),
//             new Flexible(
//               child: Column(
//                 children: [
//                   TextFormField(
//                     key: ValueKey('mobile'),
//                     focusNode: _focusNodes[1],
//                     controller: _mobile,
//                     cursorColor: parseHexColor('#343537'),
//                     validator: (value) {
//                       if (value.isEmpty ) {
//                         return 'Please enter mobile number';
//                       }
//                       return null;
//                     },
//                     style: TextStyle(
//                         color: _focusNodes[1].hasFocus
//                             ? parseHexColor('#343537')
//                             : Colors.grey),
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: 'Mobile Number',
//                       labelStyle: TextStyle(
//                         color: Colors.grey,
//                         fontFamily: "Roboto",
//                         fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.normal,
//                       ),
//                       fillColor: Colors.white,
//                       contentPadding:
//                       EdgeInsets.only(top: 20.0, bottom: 20.0),
//                     ),
//                     onSaved: (newValue) {
//                       _userEmail = newValue;
//                     },
//                     onFieldSubmitted: (value) {
//                       isColor = !isColor;
//                       setState(() {});
//                     },
//                   ),
//                   // TextField(
//                   //   cursorColor: Color(0XFF898989),
//                   //   autofocus: false,
//                   //   keyboardType: TextInputType.numberWithOptions(
//                   //       signed: true, decimal: true),
//                   //   style: TextStyle(
//                   //       fontSize: 17.0,
//                   //       fontFamily: "WorkSans",
//                   //       fontWeight: FontWeight.w300,
//                   //       color: Color(0XFF898989)),
//                   //   decoration: InputDecoration(
//                   //     filled: true,
//                   //     isDense: true,
//                   //     fillColor: Colors.transparent,
//                   //     border: OutlineInputBorder(
//                   //       borderSide: BorderSide.none,
//                   //       borderRadius: BorderRadius.circular(10),
//                   //     ),
//                   //     hintText: "Phone Number",
//                   //     hintStyle: TextStyle(
//                   //         color: Color(0XFF898989), fontWeight: FontWeight.w300),
//                   //   ),
//                   //   onChanged: (text) {
//                   //     print("First text field: $text");
//                   //     phoneNumberText = text;
//                   //   },
//                   // ),
//                   Container(
//                     color: Color(0XFF898989).withOpacity(0.5),
//                     height: 1,
//                     //margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//   }
//
//   _createAccountView(BuildContext context) {
//     return Container(
//       // margin: EdgeInsets.only(left: 8, top: 8),
//       height: 25,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(_isLogin ? " Dont Have An Account?" : 'Already Have An Account?',
//               style: TextStyle(
//                   fontSize: 14.0,
//                   fontFamily: "Roboto",
//                   fontWeight: FontWeight.normal,
//                   color: Color(0XFF767676))),
//           SizedBox(width: 4),
//           GestureDetector(
//             onTap: () {
//               //     Navigator.push(
//               //       context,
//               //       MaterialPageRoute(
//               //         /* builder: (_) => ChooseYourPlanPage(),*/
//               //         builder: (_) => OnBoardingScreen(),
//               //       ),
//               //     );
//               setState(() {
//                 _isLogin = !_isLogin;
//               });
//             },
//             child: Text(_isLogin ? " Sign Up" : 'Sign In',
//                 style: TextStyle(
//                     fontSize: 14.0,
//                     fontFamily: "Roboto",
//                     fontWeight: FontWeight.w500,
//                     color: parseHexColor('#0C5CCD'))),
//           )
//         ],
//       ),
//     );
//   }
//
//   _socialView(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Flexible(
//           child: Container(
//             width: 120,
//             height: 40,
//             decoration: BoxDecoration(
//               border: Border.all(color: parseHexColor('#B6B7B9')),
//               borderRadius: BorderRadius.all(Radius.circular(20.0)),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "assets/gl.png",
//                     // fit: BoxFit.cover,
//                   ),
//                   SizedBox(width: 8.0),
//                   Text('Google')
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 16.0),
//         Flexible(
//           child: Container(
//             // padding: EdgeInsets.only(left: 8,right: 8),
//             width: 120,
//             height: 40,
//             decoration: BoxDecoration(
//               border: Border.all(color: parseHexColor('#B6B7B9')),
//               borderRadius: BorderRadius.all(Radius.circular(20.0)),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "assets/fb.png",
//
//                     // fit: BoxFit.cover,
//                   ),
//                   SizedBox(width: 8.0),
//                   Text('Facebook')
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   _dividerView(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             color: Color(0XFF898989).withOpacity(0.5),
//             height: 1,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 32.0, right: 32),
//           child: Text(
//             "OR",
//             style: TextStyle(color: Color(0XFF898989)),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             color: Color(0XFF898989).withOpacity(0.5),
//             height: 1,
//           ),
//         )
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Align(
//         alignment: Alignment.center,
//         child: Container(
//           color: Colors.white,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 30.0, right: 30.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Color.fromRGBO(233, 239, 255, 1),
//                         borderRadius: BorderRadius.all(Radius.elliptical(164, 164)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Image(
//                           height: 25,
//                           width: 25,
//                           // fit: BoxFit.contain,
//                           image: AssetImage("assets/subscribe.png"),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     Text(
//                       'Subscribe our plans',
//                       style: TextStyle(
//                           fontFamily: "Roboto",
//                           fontStyle: FontStyle.normal,
//                           color: parseHexColor('#343537'),
//                           fontSize: 24,
//                           fontWeight: FontWeight.normal),
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     Text(
//                       'Vestibulum at pellentesque nisi. Nunc non arcu gravida, ',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     Text(
//                       'dictum metus at, faucibus orci',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//
//                     Container(
//                       color: Color(0xfff3f3f3),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ListTile(
//                           leading:
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Limited Offer',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 4,
//                               ),
//                               Text(
//                                 '1 Year Plan',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black54,
//                                     fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                               Text(
//                                 'Effective price 9/month',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           trailing: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 '84.15',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 4,
//                               ),
//                               Text(
//                                 '84.15',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black54,
//                                     fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                               Text(
//                                 '99',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     Container(
//                       color: Color(0xfff3f3f3),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ListTile(
//                           leading:
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Limited Offer',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 4,
//                               ),
//                               Text(
//                                 '1 Year Plan',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black54,
//                                     fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                               Text(
//                                 'Effective price 9/month',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           trailing: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 '84.15',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 4,
//                               ),
//                               Text(
//                                 '84.15',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black54,
//                                     fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                               Text(
//                                 '99',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       height: 24,
//                     ),
//
//                     if (widget.isLoading) CircularProgressIndicator(),
//                     if (!widget.isLoading)
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             color: parseHexColor('#0C5CCD'),
//                             // gradient: LinearGradient(
//                             //     begin: Alignment.centerLeft,
//                             //     end: Alignment.centerRight,
//                             //     colors: [Colors.purple, Colors.blue]),
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(30))),
//                         height: 50,
//                         child: FlatButton(
//                           child: Text(
//                             'Subscribe Now',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           onPressed:() {
//                             Future.delayed(Duration.zero, () {
//                               this.hitpostSubscription();
//                             });
//                           },
//                         ),
//                       ),
//                     SizedBox(height: 24),
//                     if (!widget.isLoading)
//                       FlatButton(
//                           child: Text(
//                             'Cancel',
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 /* builder: (_) => ChooseYourPlanPage(),*/
//                                 builder: (_) => ForgotPasswordScreen(),
//                               ),
//                             );
//
//                             // setState(() {
//                             //   _isLogin = !_isLogin;
//                             // });
//                           }),
//
//                     SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ]);
//   }
//
//   hitpostSubscription() async {
//     _subscription.getSubscription(context);
//   }
//
//   hitpostLogin() async {
//     _login.doLogin(context, _email.text, _lpassword.text);
//   }
// }
