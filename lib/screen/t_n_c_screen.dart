
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/provider/review_provider.dart';
import 'package:knet/widget/ShimmerWidget.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  final RateMyApp rateMyApp;

  const TermsAndConditionsScreen({Key key, this.rateMyApp}) : super(key: key);
  @override
  _TermsAndConditionsScreenState createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> with WidgetsBindingObserver {
  // var _reviewDetails;
  String comment = '';
  String content = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      ApiHandler.getTnCInfo().then((value){
        if(value != null){
          print(value['terms_conditions']);
          setState(() {
            content = value['terms_conditions'];
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
        'Terms & Conditions',
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
        backgroundColor: Colors.white,
        appBar: _appBarView(context),
        body: SafeArea(
          child:
          SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Html(data: content)
              ),),
          ),
        ));
  }
}