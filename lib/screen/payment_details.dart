import 'package:flutter/material.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/Network/Response/UserSubscriptionPlansResponse.dart';
import 'package:knet/provider/subscription_provider.dart';
import 'package:knet/widget/subscription_plan.dart';
import 'package:provider/provider.dart';

import 'SubscriptionPlanScreen.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({Key key}) : super(key: key);

  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  var _subscription;
  var _userSubscriptionPlansResponse;
  bool showLoader = true;
  int expiringIn = 0;

  @override
  void initState() {
    _subscription = Provider.of<SubscriptionProvider>(context, listen: false);

    super.initState();
    Future.delayed(Duration.zero, () {
      this.hitgetSubscriptionDetails();
    });
  }

  hitgetSubscriptionDetails() async {
    ApiHandler.getUserSubscription(context).then((value){
      print("<<<<<<<<<<<<"+value.data.toJson().toString());
      setState(() {
        _userSubscriptionPlansResponse = value.data;
        showLoader = false;
        setState(() {
          expiringIn = _userSubscriptionPlansResponse.endDate
              .difference(DateTime.now()).inDays;
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA23FA2),
        title: Text('Subscription Details'),
      ),
      body: showLoader ? Center(child: CircularProgressIndicator())
      : Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.215,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Tenure",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.215,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Amount",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.21,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("From",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w500
                      //fontWeight: FontWeight.w400
                    ),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.21,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("To",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w500
                    ),),
                ),

              ],
            ),
            Divider(thickness: 1,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.215,
                  padding: const EdgeInsets.all(12.0),
                  child: Text(_userSubscriptionPlansResponse.subscriptionType,
                    style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.215,
                  padding: const EdgeInsets.all(12.0),
                  child: Text('£'+_userSubscriptionPlansResponse.amount,
                    style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.21,
                  padding: const EdgeInsets.all(0.0),
                  child: Text(_userSubscriptionPlansResponse.startDate.toString().split(' ')[0],
                    style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.21,
                  padding: const EdgeInsets.all(0.0),
                  child: Text(_userSubscriptionPlansResponse.endDate.toString().split(' ')[0],
                    style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),

              ],
            ),

            Padding(padding: const EdgeInsets.all(8.0),),
            ListTile(
              title: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.022
                ),
                    children: <InlineSpan>[
                  TextSpan(
                      text: 'Subscription ending in ',
                      style: TextStyle(color: Colors.black87)),
                  TextSpan(
                      text: ' $expiringIn days',
                      style: TextStyle(
                          color: Color(0xFFA23FA2),
                          fontWeight: FontWeight.bold)),
                ]),
              ),
              //Text("Subscription ending in $expiringIn days"),
            ),
            Padding(padding: const EdgeInsets.all(8.0),),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SubscriptionPlanScreen(false),
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color(0xFFA23FA2),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Text("Subscribe Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.022
                    )
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
