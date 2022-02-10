import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knet/widget/forgot_password.dart';

import 'widget/auth_form.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.white,
        body: ForgotPassword(_isLoading));

  }
}
