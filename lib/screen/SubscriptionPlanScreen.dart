import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knet/widget/subscription_plan.dart';


class SubscriptionPlanScreen extends StatefulWidget {
  final goToLogin;
  SubscriptionPlanScreen(this.goToLogin);
  @override
  _SubscriptionPlanScreenState createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Container(
        color: Colors.white,
        child: SubscriptionPlan(_isLoading, widget.goToLogin)));
  }
}
