
import 'package:contactus/contactus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/provider/review_provider.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:knet/widget/ShimmerWidget.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class HelpAndSupportScreen extends StatefulWidget {
  final RateMyApp rateMyApp;

  const HelpAndSupportScreen({Key key, this.rateMyApp}) : super(key: key);
  @override
  _HelpAndSupportScreenState createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> with WidgetsBindingObserver {
  // var _reviewDetails;
  String comment = '';
  var content = {};


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      ApiHandler.getContactUsInfo().then((value){
        if(value != null){
          print(value['terms_conditions']);
          setState(() {
            content = value;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  Widget _appBarView(BuildContext context) {
    return AppBar(
      //iconTheme: IconThemeData(color: Colors.black54),
      backgroundColor: Color(0xFFA23FA2),

      // Color(0xFF662D91),
      title: _title(context),
      elevation: 0,
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      child: Text(
        'Help & Support',
        style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            //color: Colors.black
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarView(context),
      backgroundColor: const Color(0xFFA23FA2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage(StringUtils.imagesplash),
              //fit: BoxFit.fitWidth,
              width: 200,
              //height: 200,
            ),
            ContactUs(
              //logo: AssetImage(StringUtils.imagesplash, ),
              email: content['contact_email']??"",
              companyName: '',
              phoneNumber: content['contact_number']??"",
              dividerThickness: 0,
              website: 'https://www.knet.com',
              //githubUserName: 'AbhishekDoshi26',
              //linkedinURL: 'https://www.linkedin.com/in/abhishek-doshi-520983199/',
              tagLine: '',
              //twitterHandle: 'AbhishekDoshi26',
              dividerColor: const Color(0xFFA23FA2),
              //instagramUserName: '_abhishek_doshi',
            ),
          ],
        ),
      ),
    );
  }
}