import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knet/forgot_password_screen.dart';
import 'package:knet/provider/login_provider.dart';
import 'package:knet/provider/subscription_provider.dart';
import 'package:knet/screen/MapScreen.dart';
import 'package:knet/screen/auth_screen.dart';
import 'package:knet/screen/payment_screen.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:provider/provider.dart';

class SubscriptionPlan extends StatefulWidget {
  final bool isLoading;
  final goToLogin;

  SubscriptionPlan(this.isLoading, this.goToLogin);

  @override
  _SubscriptionPlanState createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _mobile = TextEditingController();
  var _cpassword = TextEditingController();
  var _lpassword = TextEditingController();
  var didSelected = false,

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

  var _subscription;
  var _login;
  var _isLogin = true;
  bool isLoginPasswordShow = true;
  bool isSignupPasswordShow = true;
  bool isSignupCPasswordShow = true;
  bool isShow = false;
  bool isColor = false;
  List<bool> isSelected = [false, false];
  var amount = '';

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
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });

    _subscription = Provider.of<SubscriptionProvider>(context, listen: false);

    super.initState();
    triggerObservers();
    Future.delayed(Duration.zero, () {
      this.hitpostSubscription();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void triggerObservers() {
    WidgetsBinding.instance.addObserver(this);
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
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 239, 255, 1),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(164, 164)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image(
                          height: 25,
                          width: 25,
                          // fit: BoxFit.contain,
                          image: AssetImage("assets/subscribe.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Subscribe our plans',
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          color: parseHexColor('#343537'),
                          fontSize: 24,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Vestibulum at pellentesque nisi. Nunc non arcu gravida, ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'dictum metus at, faucibus orci',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Consumer<SubscriptionProvider>(
                      builder: (context, plans, __) => plans.isFetching
                          ? Container(
                              color: Color(0xfff3f3f3),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Text(
                                    '1 Year Plan',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    '84.15',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),

                                ),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: plans
                                  .getSubscriptionPlansResponse()
                                  .data
                                  .length,
                              itemBuilder: (context, index) {
                                final item = plans
                                    .getSubscriptionPlansResponse()
                                    .data[index];
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print(index.toString());
                                         setState(() {
                                           if(index == 0) {
                                             isSelected[0] =
                                             !isSelected[index];
                                             isSelected[1] = false;
                                           }else{
                                             isSelected[1] =
                                             !isSelected[index];
                                             isSelected[0] =
                                             false;
                                           }
                                          amount =
                                              plans.getSubscriptionPlansResponse()
                                                  .data.elementAt(index).amount;
                                         });
                                      },
                                      child: Container(
                                        key: Key(item.id.toString()),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                            color: isSelected[index]
                                                ? Color(0xFF3F51B5)
                                                : Color(0xfff3f3f3),
                                          ),
                                        ),
                                        // color: Color(0xfff3f3f3),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(

                                            selectedTileColor: isSelected[index]
                                                ? Colors.blue
                                                : Colors.white,
                                            leading: Text(
                                              "${plans.getSubscriptionPlansResponse().data.elementAt(index).subscriptionPlan.toUpperCase()}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold),
                                            ),

                                            trailing: Text(
                                              "£${plans.getSubscriptionPlansResponse().data.elementAt(index).amount}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold),
                                            ),

                                            // Column(
                                            //   crossAxisAlignment: CrossAxisAlignment.end,
                                            //   children: [
                                            //     Text(
                                            //       '84.15',
                                            //       style: TextStyle(
                                            //         fontSize: 14,
                                            //         color: Colors.blue,
                                            //       ),
                                            //     ),
                                            //     SizedBox(
                                            //       height: 4,
                                            //     ),
                                            //     Text(
                                            //       '84.15',
                                            //       style: TextStyle(
                                            //           fontSize: 16,
                                            //           color: Colors.black54,
                                            //           fontWeight: FontWeight.bold
                                            //       ),
                                            //     ),
                                            //     Text(
                                            //       '99',
                                            //       style: TextStyle(
                                            //         fontSize: 14,
                                            //         color: Colors.grey,
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 12,
                                      color: Colors.transparent,
                                    )
                                  ],
                                );
                              }),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFA23FA2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        height: 50,
                        child: FlatButton(
                          child: Text(
                            'Subscribe Now',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if(amount.isNotEmpty){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Payment(amount: amount),
                              ));
                            }
                            /*Future.delayed(Duration.zero, () {
                              this.hitpostAddSubscription();
                            });*/
                          },
                        ),
                      ),
                    SizedBox(height: 24),
                    if (!widget.isLoading)
                      FlatButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            if(widget.goToLogin){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  /* builder: (_) => ChooseYourPlanPage(),*/
                                  builder: (_) => AuthScreen(true),
                                ),
                              );
                            }

                            // setState(() {
                            //   _isLogin = !_isLogin;
                            // });
                          }),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  hitpostSubscription() async {
    _subscription.getSubscription(context);
  }

  hitpostLogin() async {
    _login.doLogin(context, _email.text, _lpassword.text);
  }

  hitpostAddSubscription() {
    _subscription.postSubscription(context);
  }
}
