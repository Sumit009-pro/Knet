import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:knet/provider/login_provider.dart';
import 'package:knet/provider/logout_provider.dart';
import 'package:knet/provider/register_provider.dart';
import 'package:knet/provider/subscription_provider.dart';
import 'package:knet/provider/forgot_password_provider.dart';
import 'package:knet/provider/profile_provider.dart';
import 'package:knet/provider/user_provider.dart';

import 'package:knet/screen/MapScreen.dart';
import 'package:knet/provider/review_provider.dart';
import 'package:knet/screen/OTPVerificationScreen.dart';
import 'package:knet/screen/SubscriptionPlanScreen.dart';
import 'package:knet/screen/auth_screen.dart';
import 'package:knet/screen/home_page.dart';
import 'package:knet/utils/CustomAnimation.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:knet/widget/rating/rate_app_init_widget.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SplashScreen.dart';

SharedPreferences sharedPreferences;

main() async {
  // configLoading();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51JzLtLH2QgrbE84t2FiKWR1zIVoOD9Adx4UGdi8tPB3wOUfDhghKRFAVmM7baFMmxCLsZQ9OJukG1RwNTHEIAWJA00tzKAvg8H';
  sharedPreferences = await SharedPreferences.getInstance();
  _determinePosition().then((value){
    Position position = value;
    GetAddressFromLatLong(position);
    print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<RegisterProvider>(
          create: (context) => RegisterProvider(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<SubscriptionProvider>(
          create: (context) => SubscriptionProvider(),
        ),
        ChangeNotifierProvider<ForgotPasswordProvider>(
          create: (context) => ForgotPasswordProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider<ReviewProvider>(
          create: (context) => ReviewProvider(),
        ),
        ChangeNotifierProvider<LogoutProvider>(
          create: (context) => LogoutProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
  configLoading();
}

Future<void> GetAddressFromLatLong(Position position)async {
  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  print(placemarks);
  Placemark place = placemarks[0];
  //print('${place.street}, ${place.subAdministrativeArea}, ${place.locality}, ${place.postalCode}, ${place.country}');
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


Future<void> initPreference() async {
  sharedPreferences = await SharedPreferences.getInstance();
  // await sharedPreferences.setInt('counter', counter);
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // primarySwatch: Colors.purple,
      ),
      home: SplashScreen(),
      builder: EasyLoading.init(),

      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
