// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:knet/screen/rating_review/rate_comment_page.dart';
// import 'package:knet/screen/rating_review/rate_dialog_page.dart';
// import 'package:knet/screen/rating_review/rate_info_page.dart';
// import 'package:knet/screen/rating_review/rate_stars_page.dart';
// import 'package:knet/widget/rating/tabbar_widget.dart';
// import 'package:rate_my_app/rate_my_app.dart';
//
// import '../main.dart';
//
// class RatingReviewScreen extends StatefulWidget {
//   final RateMyApp rateMyApp;
//
//   const RatingReviewScreen({
//     Key key,
//     @required this.rateMyApp,
//   }) : super(key: key);
//   @override
//   _RatingReviewScreenState createState() => _RatingReviewScreenState();
// }
//
// class _RatingReviewScreenState extends State<RatingReviewScreen> {
//   @override
//   Widget build(BuildContext context) => TabBarWidget(
//     title: 'Rating',
//     tabs: [
//       Tab(icon: Icon(Icons.open_in_full), text: 'Dialog'),
//       Tab(icon: Icon(Icons.rate_review), text: 'Comment'),
//       Tab(icon: Icon(Icons.star_rate_sharp), text: 'Stars'),
//       Tab(icon: Icon(Icons.info_outline_rounded), text: 'Info'),
//     ],
//     children: [
//       RateDialogPage(rateMyApp: widget.rateMyApp),
//       RateCommentPage(rateMyApp: widget.rateMyApp),
//       RateStarsPage(rateMyApp: widget.rateMyApp),
//       RateInfoPage(rateMyApp: widget.rateMyApp),
//     ],
//   );
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knet/Network/Response/GetProfileResponse.dart';
import 'package:knet/provider/profile_provider.dart';
import 'package:knet/provider/review_provider.dart';
import 'package:knet/widget/ShimmerWidget.dart';
import 'package:knet/widget/rating/button_widget.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:knet/Network/Api/ApiHandler.dart';

class ProfileScreen extends StatefulWidget {
  final RateMyApp rateMyApp;
  final GetProfileResponse getProfileRes;

  const ProfileScreen({Key key, this.rateMyApp, this.getProfileRes}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var googlePlace = GooglePlace("AIzaSyDh6_44H4oqcGf4eol4WIauqFaCdvlUVV0");
  List placesList = [];
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  // var _reviewDetails;
  var _firstName = TextEditingController();
  var _location = TextEditingController();
  var _email = TextEditingController();
  var _phone = TextEditingController();
  var _description = TextEditingController();
  var _businessName = TextEditingController();
  var _facebook = TextEditingController();
  var _instagram = TextEditingController();
  var lat = '';
  var lng = '';
  String _image = '';
  String _sellerType = "Individual";
  var fileImage;

  var _profile;
  var isLoading= true;
  GetProfileResponse _getProfileResponse;
  String comment = '';

  String currentPositionValue = "";
  String postalCode = "";

  @override
  void initState() {
    // TODO: implement initState
    // triggerObservers();
    super.initState();
    _determinePosition().then((value){
      Position position = value;
      GetAddressFromLatLong(position);
      print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    });
    _profile = Provider.of<ProfileProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      this.hitpostGetProfile();
    });

    // setState(() {
    //   _firstName.text=widget.getProfileRes.data.name;
    //   _phone.text=widget.getProfileRes.data.mobile;
    //   _email.text=widget.getProfileRes.data.email;
    //   _location.text=widget.getProfileRes.data.location;
    //   _description.text=widget.getProfileRes.data.description;
    //
    //   print(_firstName.text);
    // });
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }
  //
  // void triggerObservers() {
  //   WidgetsBinding.instance.addObserver(this);
  // }

  Future openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        fileImage = File(pickedFile.path);
        // UserController().uploadProfileImage(pickedFile.path).then((value){
        //   saveImage(value);
        // });
        ApiHandler.updateProfilePic(context, fileImage);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      currentPositionValue = place.street +', '
          //+ place.subLocality + ', '
          + place.locality + ', '
          + place.subAdministrativeArea;
      if(_location.text.isEmpty){
        _location.text = currentPositionValue;
      }
      //surburb = place.administrativeArea;
      postalCode = place.postalCode;
    });
    print('${place.street}, ${place.subAdministrativeArea}, ${place.locality}, ${place.postalCode}, ${place.country}');

  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }



  hitpostGetProfile() async {
    await _profile.getProfile(
      context,
    );
    _getProfileResponse= _profile.getGetProfileResponse();
    setState(() {
      _sellerType = _getProfileResponse
          .data
          .sellerType;
      _firstName.text = _getProfileResponse
          .data
          .name;
      _phone.text = _getProfileResponse
          .data
          .mobile;
      _email.text = _getProfileResponse
          .data
          .email;
      _location.text = _getProfileResponse
          .data
          .location;
      _description.text = _getProfileResponse
          .data
          .description
          ??'';
      _image = _getProfileResponse
          .data
          .image;
      _businessName.text = _getProfileResponse
          .data
          .businessName;
      _facebook.text = _getProfileResponse
          .data
          .fbAddress;
      _instagram.text = _getProfileResponse
          .data
          .igAddress;
      lat = _getProfileResponse
          .data
          .lat;
      lng = _getProfileResponse
          .data
          .lng;
      isLoading=false;
    });

  }

  hitpostaddReview() async {
    // await _review.addReview(
    //   context,
    // );
  }

  hitpostdeleteReview(String _reviewID) async {
    // await _review.deleteReview(context, _reviewID);
  }

  hitpostupdateProfile() async {
    await _profile.updateProfile(
        context, _firstName.text, _email.text, _phone.text, _location.text,
        _description.text, _sellerType, _businessName.text, _facebook.text,
        _instagram.text, lat, lng);
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      // widget.submitFn(_userEmail.trim(), _userPassword, _userName.trim(), _isLogin,context);

      _formKey.currentState.save();
      // widget.submitFn(_userEmail.trim(), _userPassword, _userName.trim(), _isLogin,context);

      Future.delayed(Duration.zero, () {
        this.hitpostupdateProfile();
      });
      // widget.submitFn(_userEmail.trim(), _userPassword, _userName.trim(), _isLogin,context);
      // widget.submitFn(_userEmail.trim(), _userPassword, _userName.trim(), _isLogin,context);
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     /* builder: (_) => ChooseYourPlanPage(),*/
    //     builder: (_) => MapScreen(),
    //   ),
    // );
  }

  Widget buildComment(BuildContext context) =>
      TextFormField(
        autofocus: true,
        onFieldSubmitted: (_) => Navigator.of(context).pop(),
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Write Comment...',
          border: OutlineInputBorder(),
        ),
        onChanged: (comment) => setState(() => this.comment = comment),
      );

  List<Widget> actionsBuilder(BuildContext context) =>
      [buildOkButton(), buildCancelButton()];

  Widget buildOkButton() =>
      RateMyAppRateButton(
        widget.rateMyApp,
        text: 'SEND',
        callback: () {
          Future.delayed(Duration.zero, () {
            this.hitpostaddReview();
          });
          // print('Comment: $comment');
        },
      );

  Widget buildCancelButton() =>
      RateMyAppNoButton(
        widget.rateMyApp,
        text: 'CANCEL',
      );

  Widget _appBarView(BuildContext context) {
    return AppBar(
      //iconTheme: IconThemeData(color: Colors.black54),
      backgroundColor: Color(0xFFA23FA2),

      // Color(0xFF662D91),
      title: _title(context),
      elevation: 0,
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(
        //     Icons.add,
        //     color: Colors.black54,
        //   ),
        //   onPressed: () {
        //     widget.rateMyApp.showRateDialog(
        //       context,
        //       contentBuilder: (context, _) => buildComment(context),
        //       actionsBuilder: actionsBuilder,
        //     );
        //   },
        // )
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      child: Text(
        'Profile',
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

  Widget slideLeftBackground() {
    return Container(
      color:
      Color(0xFF0C5CCD),

      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget _ownerRegistrationView(BuildContext context) {
    return
      // Consumer<ProfileProvider>(
      //   builder: (context, profile, __) =>
        isLoading
            ?
        ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildShimmer();
            })
            :
        ListView.builder(
            itemCount: (1),
            // (getAllAgentsRepo.allAgentResponseModel.responseData.length),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // _firstName.text = profile
              //     .getGetProfileResponse()
              //     .data
              //     .name;
              // _phone.text = profile
              //     .getGetProfileResponse()
              //     .data
              //     .mobile;
              // _email.text = profile
              //     .getGetProfileResponse()
              //     .data
              //     .email;
              // _location.text = profile
              //     .getGetProfileResponse()
              //     .data
              //     .location;
              // _description.text = profile
              //     .getGetProfileResponse()
              //     .data
              //     .description ?? '';

              // var myInt = double.parse(
              //   reviewDetails
              //       .getReviewDetailsResponse()
              //       .data
              //       .elementAt(index)
              //       .rating,
              // );
              // assert(myInt is double);
              // // final items = List<String>;
              // final item = reviewDetails
              //     .getReviewDetailsResponse()
              //     .data[index];
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 100,
                      height: 110,
                      // color: Colors.yellow,
                      child: Stack(
                        fit: StackFit.loose,
                        children: [

                          ClipOval(
                            child: fileImage != null ?
                            ClipOval(
                              child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.file(fileImage)),
                            ) :
                            CachedNetworkImage(
                                width: 100,
                                height: 100,
                                imageUrl:
                                // 'https://cdn.pixabay.com/photo/2016/10/26/19/00/domain-names-1772242_960_720.jpg',
                                _image,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      width: 100,
                                      height: 1000,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          // colorFilter: ColorFilter.mode(
                                          //     Colors.red, BlendMode.colorBurn)
                                        ),
                                      ),
                                    ),
                                placeholder: (context, url) =>ClipOval(
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      child: Image.asset('assets/profile-icon.png')),
                                ),

                                    // CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    ClipOval(
                                        child: Image.asset(
                                          'assets/profile-icon.png',
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ))
                              // Icon(Icons.error,size: 100,),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: (){
                                openGallery();
                              },
                              child: ClipOval(
                                  child:Container(
                                    height: 40,
                                      width: 40,
                                      // margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                      color: Colors.grey[100],
                                      child: Icon(Icons.edit_outlined,size: 25,color: Colors.purple,)),
                                  // Image.asset(
                                  //   'assets/logo.png',
                                  //   height: 50,
                                  //   width: 50,
                                  //   fit: BoxFit.cover,
                                  // )),
                              ),
                            ) ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 30, top: 30, right: 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 15),
                            alignment: Alignment.center,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                /*decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none)
                          ),*/
                                focusColor:Colors.white,
                                value: _sellerType,
                                //elevation: 5,
                                //validator: ValidationBuilder().minLength(1, "Please Choose Goods Condition!").build(),
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor:Colors.black,
                                items: <String>[
                                  "Individual",
                                  "Showroom"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style:TextStyle(color:Colors.black),),
                                  );
                                }).toList(),
                                onChanged: (String value) {
                                  setState(() {
                                    _sellerType = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 8, top: 19),
                                  child: Icon(Icons.person_outline, size: 14,)


                              ),
                              Flexible(
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 0, top: 2),
                                  child:
                                  TextFormField(
                                    // initialValue:
                                    //     details.responseData.elementAt(0).firstName ?? '',
                                    controller: _firstName,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter First Name';
                                      }
                                      return null;
                                    },
                                    // controller: _controller,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w300,
                                        //color: Color(0XFF898989)
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // fillColor: Color(0xFFf69990),
                                      hintText: "First Name",
                                      hintStyle: TextStyle(
                                          color: Color(0XFF898989),
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onChanged: (text) {
                                      print("First text field: $text");
                                      // _firstName.text = text;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0XFF898989).withOpacity(0.1),
                            height: 1,
                            //  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 30, top: 15, right: 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 8, top: 19),
                                  child: Icon(Icons.phone_android, size: 14,)


                              ),
                              Flexible(
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 0, top: 2),
                                  child:
                                  TextFormField(
                                    // initialValue:
                                    //     details.responseData.elementAt(0).firstName ?? '',
                                    controller: _phone,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 10) {
                                        return 'Please enter valid mobile number';
                                      }
                                      return null;
                                    },
                                    // controller: _controller,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w300,
                                        //color: Color(0XFF898989)
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // fillColor: Color(0xFFf69990),
                                      hintText: "Mobile Number",
                                      hintStyle: TextStyle(
                                          color: Color(0XFF898989),
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onChanged: (text) {
                                      print("First text field: $text");
                                      // firstName = text;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0XFF898989).withOpacity(0.1),
                            height: 1,
                            //  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 30, top: 15, right: 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 8, top: 19),
                                  child: Icon(Icons.business, size: 14,)


                              ),
                              Flexible(
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 0, top: 2),
                                  child:
                                  TextFormField(
                                    // initialValue:
                                    //     details.responseData.elementAt(0).firstName ?? '',
                                    controller: _businessName,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    // validator: (value) {
                                    //   if (value.isEmpty || value.length < 10) {
                                    //     return 'Please enter valid Business Name';
                                    //   }
                                    //   return null;
                                    // },
                                    // controller: _controller,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w300,
                                        //color: Color(0XFF898989)
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // fillColor: Color(0xFFf69990),
                                      hintText: "Business Name",
                                      hintStyle: TextStyle(
                                          color: Color(0XFF898989),
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onChanged: (text) {
                                      print("First text field: $text");
                                      // firstName = text;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0XFF898989).withOpacity(0.1),
                            height: 1,
                            //  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 30, top: 15, right: 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 8, top: 19),
                                  child: Icon(Icons.mail_outline, size: 14,)


                              ),
                              Flexible(
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 0, top: 2),
                                  child:
                                  TextFormField(
                                    controller: _email,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    enabled: false,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w300,
                                        //color: Color(0XFF898989)
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // fillColor: Color(0xFFf69990),
                                      hintText: "Business Name",
                                      hintStyle: TextStyle(
                                          color: Color(0XFF898989),
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onChanged: (text) {
                                      print("First text field: $text");
                                      // firstName = text;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0XFF898989).withOpacity(0.1),
                            height: 1,
                            //  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 30, top: 15, right: 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 8, top: 19),
                                  child: Icon(Icons.facebook, size: 14,)


                              ),
                              Flexible(
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 0, top: 2),
                                  child:
                                  TextFormField(
                                    // initialValue:
                                    //     details.responseData.elementAt(0).firstName ?? '',
                                    controller: _facebook,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    // validator: (value) {
                                    //   if (value.isEmpty || value.length < 10) {
                                    //     return 'Please enter valid mobile number';
                                    //   }
                                    //   return null;
                                    // },
                                    // controller: _controller,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w300,
                                        //color: Color(0XFF898989)
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // fillColor: Color(0xFFf69990),
                                      hintText: "Facebook Profile",
                                      hintStyle: TextStyle(
                                          color: Color(0XFF898989),
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onChanged: (text) {
                                      print("First text field: $text");
                                      // firstName = text;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0XFF898989).withOpacity(0.1),
                            height: 1,
                            //  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 30, top: 15, right: 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 8, top: 19),
                                  child: Icon(Icons.monochrome_photos, size: 14,)


                              ),
                              Flexible(
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 0, top: 2),
                                  child:
                                  TextFormField(
                                    // initialValue:
                                    //     details.responseData.elementAt(0).firstName ?? '',
                                    controller: _instagram,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    // validator: (value) {
                                    //   if (value.isEmpty || value.length < 10) {
                                    //     return 'Please enter valid mobile number';
                                    //   }
                                    //   return null;
                                    // },
                                    // controller: _controller,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w300,
                                        //color: Color(0XFF898989)
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // fillColor: Color(0xFFf69990),
                                      hintText: "Instagram Profile",
                                      hintStyle: TextStyle(
                                          color: Color(0XFF898989),
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onChanged: (text) {
                                      print("First text field: $text");
                                      // firstName = text;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0XFF898989).withOpacity(0.1),
                            height: 1,
                            //  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 30, top: 15, right: 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 8, top: 19),
                                  child: Icon(
                                    Icons.location_on_outlined, size: 14,)


                              ),
                              Flexible(
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 0, top: 2),
                                  child:
                                  TextFormField(
                                    // initialValue:
                                    //     details.responseData.elementAt(0).firstName ?? '',
                                    controller: _location,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter location';
                                      }
                                      return null;
                                    },
                                    minLines: 1,
                                    maxLines: 3,
                                    // controller: _controller,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w300,
                                        //color: Color(0XFF898989)
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // fillColor: Color(0xFFf69990),
                                      hintText: "location",
                                      hintStyle: TextStyle(
                                          color: Color(0XFF898989),
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onChanged: (text) async{
                                      print("First text field: $text");
                                      var result = await googlePlace.autocomplete.get(text);
                                      setState(() {
                                        placesList = [];
                                        for(int i = 0; i < result.predictions.length; i++) {
                                          placesList.add(result.predictions[i].description);
                                          print(">>>>>${result.predictions[i].terms[0]?.value}");
                                          //setLatLng(result.predictions[i].description);
                                        }
                                      });
                                      // firstName = text;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0XFF898989).withOpacity(0.1),
                            height: 1,
                            //  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 30, top: 15, right: 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 8, top: 19),
                                  child: Icon(
                                    Icons.description_outlined, size: 14,)


                              ),
                              Flexible(
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 0, top: 2),
                                  child:
                                  TextFormField(
                                    controller: _description,
                                    cursorColor: Colors.black,
                                    autofocus: false,
                                    maxLines: 10,
                                    minLines: 1,
                                    // controller: _controller,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w300,
                                        //color: Color(0XFF898989)
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // fillColor: Color(0xFFf69990),
                                      hintText: "Description(About your business / you)",
                                      hintStyle: TextStyle(
                                          color: Color(0XFF898989),
                                          fontWeight: FontWeight.w300),
                                    ),
                                    onChanged: (text) {
                                      print("First text field: $text");
                                      // firstName = text;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0XFF898989).withOpacity(0.1),
                            height: 1,
                            //  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30)
                  ],
                ),
              );
            });
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: InkWell(
          onTap: () {
            _trySubmit();
          },
          child: Container(
            height: 60,
            color: Color(0xFFA23FA2),

            // Color(0xFF662D91),

            child: Align(
                alignment: Alignment.center,
                child: Text('UPDATE', style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Roboto'),)),),
        ),
        appBar: _appBarView(context),
        body: SafeArea(
          child: Stack(
            children: [
              _ownerRegistrationView(context),
              Container(
                //color: Color(0xFFA23FA2),
                child: ListView.builder(
                  itemCount: placesList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          _location.text = placesList[index];
                          setLatLng(placesList[index]);
                          placesList = [];
                        });
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(placesList[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildShimmer() =>
      ListTile(
          leading: ShimmerWidget.circular(
            width: 24,
            height: 24,
            shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
          title: Align(
              alignment: Alignment.centerLeft,
              child: ShimmerWidget.rectangular(
                height: 16,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.3,
              )),
          // subtitle: ShimmerWidget.rectangular(height: 14)
      );

  setLatLng(address) async{
    List<geo.Location> locations = await locationFromAddress(address);
    setState(() {
      lat = locations.first.latitude.toString();
      lng = locations.first.longitude.toString();
    });
    print("<><><><>"+lat+'<>'+lng);
  }
}
