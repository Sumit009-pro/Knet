
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/provider/review_provider.dart';
import 'package:knet/widget/ShimmerWidget.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FAQScreen extends StatefulWidget {
  final RateMyApp rateMyApp;

  const FAQScreen({Key key, this.rateMyApp}) : super(key: key);
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> with WidgetsBindingObserver {
  // var _reviewDetails;
  String comment = '';
  List content = [];
  List<bool> showFlags = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      ApiHandler.getFaq().then((value){
        if(value != null){
          print(value['data']);
          setState(() {
            content = value['data'];
            showFlags = List.filled(content.length, false);
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
        'FAQs',
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
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: content.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){
                setState(() {
                  showFlags[index] = !showFlags[index];
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    children: [
                      Html(data: content[index]['questions'],
                        defaultTextStyle: TextStyle(
                          fontSize:  MediaQuery.of(context).size.height * 0.022,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      if(showFlags[index]) Html(data: content[index]['answers']),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}