import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:knet/provider/login_provider.dart';
import 'package:knet/screen/MapScreen.dart';
import 'package:knet/screen/OnBoardingScreen.dart';
import 'package:knet/screen/RegisterScreen.dart';
import 'package:knet/screen/get_markers.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //sharedpreference
    SharedPreferences.getInstance().then((onValue) {
      sharedPreferences = onValue;
      sharedPreferences.setString(Keys.deviceType, Platform.operatingSystem);
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        deviceInfo.iosInfo.then((value) {
          sharedPreferences.setString(Keys.deviceId, value.identifierForVendor);
        });
      } else {
        deviceInfo.androidInfo.then((value) {
          sharedPreferences.setString(Keys.deviceId, value.androidId);
        });
      }
    });

    Timer(Duration(seconds: 2), () {
      try{
        print('Splash Token : '+sharedPreferences.getString(Keys.accessToken));
        if (sharedPreferences.getString(Keys.accessToken) != null || sharedPreferences.getString(Keys.accessToken) != ''||sharedPreferences.getString(Keys.accessToken) != '0') {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => GetPosition(),
              ),
                  (route) => false);
          // Provider.of<LoginProvider>(context, listen: false).doLogin(
          //     context,
          //     sharedPreferences.getString(Keys.emailID),
          //     sharedPreferences.getString(Keys.password));
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => OnBoardingScreen(),
              ),
                  (route) => false);
        }
      }
      catch(e){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => OnBoardingScreen(),
            ),
                (route) => false);
      }

    });
    super.initState();
  }

  //   Timer(Duration(seconds: 3), () {
  //     if (sharedPreferences.getString(Keys.emailID) != null) {
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(
  //             builder: (_) => RegisterScreen(),
  //           ),
  //           (route) => false);
  //
  //       // Provider.of<LoginProvider>(context, listen: false).doLogin(
  //       //     context,
  //       //     "9602320214",
  //       //     "qwertyuiop",
  //       //     "local",
  //       // );
  //     } else {
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(
  //             builder: (_) => OnBoardingScreen(),
  //           ),
  //           (route) => false);
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.0, 0.0),
            end: Alignment(0.174, 0.985),
            colors: [


              const Color(0xFFA23FA2),
              const Color(0xFF662D91),
            ],
          ),

        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              // border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20),


            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage(StringUtils.imagesplash),
                //fit: BoxFit.fitWidth,
                width: 150,
                height: 150,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
