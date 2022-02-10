import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/auth_form.dart';

class AuthScreen extends StatefulWidget {
  final bool isSignIn;
  AuthScreen(this.isSignIn);
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.white,
        body: AuthForm(_isLoading, widget.isSignIn));

  }
}
