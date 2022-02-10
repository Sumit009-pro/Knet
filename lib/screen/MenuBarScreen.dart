import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:knet/Network/Response/GetProfileResponse.dart';
import 'package:knet/Network/Response/SubscriptionPlansResponse.dart';
import 'package:knet/provider/logout_provider.dart';
import 'package:knet/provider/profile_provider.dart';
import 'package:knet/provider/subscription_provider.dart';

import 'package:knet/screen/MapScreen.dart';
import 'package:knet/screen/RatingReviewScreen.dart';
import 'package:knet/screen/ProfileScreen.dart';
import 'package:knet/screen/about_us.dart';
import 'package:knet/screen/faq_screen.dart';
import 'package:knet/screen/help_and_support.dart';
import 'package:knet/screen/payment_details.dart';
import 'package:knet/screen/payment_screen.dart';

import 'package:knet/screen/shop_screen.dart';
import 'package:knet/screen/t_n_c_screen.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:knet/widget/rating/rate_app_init_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_screen.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String userType = "Store", fullName = "", emailID = "";

  var _logoff, _profile, _subscription;

  Widget _headerView(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        _pushToProfileScreen();
      },
      child: Consumer<ProfileProvider>(
        builder: (context, profile, __) => profile.isFetching
            ? Container(
                height: 100,
              )
            : Container(
                // color:Color(0xFF662D91),
                // color: parseHexColor('#0C5CCD'),
                child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                      // alignment: Alignment.topLeft,
                      // decoration: BoxDecoration(
                      //   shape: BoxShape.circle,
                      // ),
                      child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    leading: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.white54,
                        //     blurRadius: 5.0,
                        //     offset: Offset(0, 10),
                        //     spreadRadius: 0.1,
                        //   ),
                        // ],
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: profile.getGetProfileResponse().data.image,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                // colorFilter:
                                // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                              ),
                            ),
                          ),
                          placeholder: (context, url) => ClipOval(
                            child: Container(
                                height: 40,
                                width: 40,
                                child: Image.asset('assets/profile-icon.png')),
                          ),
                          errorWidget: (context, url, error) => ClipOval(
                              child: Image.asset(
                                'assets/profile-icon.png',
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ))
                        ),
                      ),
                    ),
                    title: Text(profile.getGetProfileResponse().data.name,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.getGetProfileResponse().data.email,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.normal,
                                color: Colors.white.withOpacity(0.5))),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16.0, top: 2, bottom: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Monthly',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                                Text('Expires on 21-4-2010',
                                    style: TextStyle(
                                        fontSize: 8.0,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(height: 4),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                    height: 2,
                    color: Colors.grey.withOpacity(0.7),
                  )
                ],
              )),
      ),
    );
  }

  _logout() async {
    await Future.delayed(Duration.zero, () {
      this.hitpostLogout();
    });
  }

  _showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        print("Cancel");
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        print("OKKK");
        // _clearAllValue();
        Navigator.of(context).pop();
        _logout();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure to Logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _pushToRatingReviewScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => new RateAppInitWidget(
        builder: (rateMyApp) => RatingReviewScreen(rateMyApp: rateMyApp),
      ),
    ));
  }

  void _pushToProfileScreen() {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => ProfileScreen());
    Navigator.of(context).push(route);
  }

  void _pushToShopScreen() {
    var route =
        new MaterialPageRoute(builder: (BuildContext context) => ShopScreen());
    Navigator.of(context).push(route);
  }

  Widget _storeManagerMenuContainWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        _headerView(context),
        SizedBox(
          height: 8,
        ),
        Container(
          // color: Color(0xFF662D91),
          // parseHexColor('#0C5CCD'),
          height: 50,
          child: ListTile(
            title: Text('Payment Details',
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.normal,
                    color: Colors.white)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PaymentDetailsScreen(),
              ));
            },
          ),
        ),
        Container(
          // color: Color(0xFF662D91),
          // parseHexColor('#0C5CCD'),
          height: 55,
          child: ListTile(
            title: Text('Rating & Reviews',
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.normal,
                    color: Colors.white)),
            onTap: () =>
                {Navigator.of(context).pop(), _pushToRatingReviewScreen()},
          ),
        ),
        Container(
          // color: Color(0xFF662D91),
          // parseHexColor('#0C5CCD'),
          height: 50,
          child: ListTile(
            title: Text('About Us',
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.normal,
                    color: Colors.white)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AboutUsScreen(),
              ));
            },
          ),
        ),
        Container(
          // color:Color(0xFF662D91),
          // parseHexColor('#0C5CCD'),
          height: 55,
          child: ListTile(
            title: Text('FAQ',
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.normal,
                    color: Colors.white)),
            onTap: () {Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => FAQScreen(),
            ));
            },
          ),
        ),
        Container(
          // color: Color(0xFF662D91),
          // parseHexColor('#0C5CCD'),
          height: 50,
          child: ListTile(
            title: Text('Terms & Conditions',
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.normal,
                    color: Colors.white)),
            onTap: () {Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => TermsAndConditionsScreen(),
            ));
            },
          ),
        ),
        Container(
          // color: Color(0xFF662D91),
          // parseHexColor('#0C5CCD'),
          height: 55,
          child: ListTile(
            title: Text('Help & Support',
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.normal,
                    color: Colors.white)),
            onTap: () {Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => HelpAndSupportScreen(),
            ));
            },
          ),
        ),

        Container(
            height: 90,
            child: Container(
              height: 2,
              // color:Color(0xFF662D91),
              // parseHexColor('#0C5CCD'),
            )),
        Container(
          height: 55,
          // color: Color(0xFF662D91),
          // parseHexColor('#0C5CCD'),
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),

            // Image(
            //   image: AssetImage("assets/logout.png"),
            //   width: 25,
            //   height: 25,
            // ),
            title: Text('Log Out',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            onTap: () => {
              //Navigator.of(context).pop(),
              _showAlertDialog(context)
            },
          ),
        ),
        // SizedBox(height: 30),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _setTitle();
    _logoff = Provider.of<LogoutProvider>(context, listen: false);
    _profile = Provider.of<ProfileProvider>(context, listen: false);
    _subscription = Provider.of<SubscriptionProvider>(context, listen: false);
    //

    Future.delayed(Duration.zero, () {
      this.hitpostGetProfile();
    });
  }

  GetProfileResponse _getProfileResponse;
  SubscriptionPlansResponse _subscriptionPlansResponse;

  hitpostGetProfile() async {
    await _subscription.getSubscription(
      context,
    );
    await _profile.getProfile(
      context,
    );
    _getProfileResponse = _profile.getGetProfileResponse();
    _subscriptionPlansResponse = _subscription.getSubscriptionPlansResponse();
  }

  hitpostLogout() async {
    await _logoff.doLogout(
      context,
    );
  }

  _setTitle() async {
    final prefs = await SharedPreferences.getInstance();

    var firstName = prefs.getString('firstName') ?? " ";
    var lastName = prefs.getString('lastName') ?? " ";

    setState(() {
      fullName = firstName + " " + lastName;
      print('fullName$fullName');
      userType = prefs.getString('userType') ?? " ";
      emailID = prefs.getString('userEmailID') ?? " ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color:
                // Color(0xFF662D91),
            Color(0xFFA23FA2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _storeManagerMenuContainWidget(context),
            )));
  }
}
