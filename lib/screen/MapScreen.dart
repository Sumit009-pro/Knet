// import 'dart:html';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_place/google_place.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/provider/profile_provider.dart';
import 'package:knet/provider/review_provider.dart';
import 'package:knet/utils/StringUtils.dart';
import 'package:knet/widget/MenuWidget.dart';
import 'package:knet/widget/ShimmerWidget.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'get_markers.dart';
import 'MenuBarScreen.dart';

enum ImageSourceType { gallery, camera }

class MapScreen extends StatefulWidget {
  final RateMyApp rateMyApp;
  final userList;

  const MapScreen({Key key, this.rateMyApp, this.userList}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {
  //var googlePlace = GooglePlace("AIzaSyDh6_44H4oqcGf4eol4WIauqFaCdvlUVV0");
  PickResult selectedPlace;
  bool isUser = false;
  File _image1;
  List<File> _imageArr = [];
  final picker = ImagePicker();
  bool didSelectFirstImage = false;

  var _initialCameraPosition =
      CameraPosition(target: LatLng(29.401, 45.254), zoom: 11.5);
  List<String> _tempListOfCities;

  //1
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _profile;
  var _review;
  File image;
  var currentLocation;
  final TextEditingController textController = new TextEditingController();
  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  String comment = '';
  static List<String> _listOfCities = <String>[
    "Tokyo",
    "New York",
    "London",
    "Paris",
    "Madrid",
    "Dubai",
    "Rome",
    "Barcelona",
    "Cologne",
    "Monte Carlo",
    "Puebla",
    "Florence"
  ];
  bool _isChecked = false;
  bool _isShowroomChecked = false;
  bool _isIndividualChecked = false;
  String searchByValue = "All";
  String province;
  String city;
  String surburb;
  String postalCode;
  List placesList = [];
  bool showPlacePicker = false;
  List<Marker> markersList = [];
  Map userData = {};
  bool showMap = false;
  BitmapDescriptor bitmapIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);

  @override
  void initState() {
    // TODO: implement initState
    initializeIcon().whenComplete((){
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((currloc) {
        setState(() {
          currentLocation = currloc;
          //_isLocationGranted = true;
          _initialCameraPosition =
              CameraPosition(
                  target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 11.5);
          _googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLocation.latitude, currentLocation.longitude), 14));
        });
      });
      setState(() {
        int i = 0;
        for(var obj in widget.userList){
          i++;
          markersList.add(Marker(
            onTap: (){
              print(obj['name'],);
              setState(() {
                isUser = true;
                userData = obj;
              });
            },
            draggable: false,
            markerId: MarkerId('$i'),
            position: LatLng(double.parse(obj['lat']), double.parse(obj['lng'])),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
            //icon: bitmapIcon,
            infoWindow: InfoWindow(
              title: obj['name'],
              snippet: obj['seller_type'],

            ),
          ));
        }
        showMap = true;
      });
    });
    super.initState();
    _determinePosition().then((value){
      Position position = value;
      getAddressFromLatLong(position);
      print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    });
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((currloc) {
      setState(() {
        currentLocation = currloc;
        //_isLocationGranted = true;
        _initialCameraPosition =
            CameraPosition(
                target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 11.5);
        _googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLocation.latitude, currentLocation.longitude), 14));
      });
    }).whenComplete((){
      /*_determinePosition().then((value){
        Position position = value;
        GetAddressFromLatLong(position);
        print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((currloc) {
          setState(() {
            currentLocation = currloc;
            //_isLocationGranted = true;
            _initialCameraPosition =
                CameraPosition(target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 11.5);
            _googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLocation.latitude, currentLocation.longitude), 14));
          });
        });
      });*/
    });
    _profile = Provider.of<ProfileProvider>(context, listen: false);
    _review = Provider.of<ReviewProvider>(context, listen: false);
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        showPlacePicker = true;
      });
    });
  }

  Future initializeIcon() async{
    bitmapIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10, 10),devicePixelRatio: 1), 'assets/logo.png');
  }

  // ignore: non_constant_identifier_names
  Future<void> getAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    province = place.street;
    city = place.subAdministrativeArea;
    surburb = place.administrativeArea;
    postalCode = place.postalCode;
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

  initPref() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences?.setString(Keys.emailID, '0');
    await sharedPreferences?.setString(Keys.password, '0');
    await sharedPreferences?.setString(Keys.userID, '0');
    await sharedPreferences?.setString(Keys.accessToken, '0');
    // await sharedPreferences?.clear();
  }

  hitpostaddReview() async {
    await _review.addReview(
      context,
    );
  }

  hitpostUpdateProfilePic() async {
    await _profile.updateProfilePic(context, image);
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void _showModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          //3
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
                expand: true,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: TextField(
                                  controller: textController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                  onChanged: (value) {
                                    //4
                                    setState(() {
                                      _tempListOfCities =
                                          _buildSearchList(value);
                                    });
                                  })),
                          IconButton(
                              icon: Icon(Icons.close),
                              color: Color(0xFF1F91E7),
                              onPressed: () {
                                setState(() {
                                  textController.clear();
                                  _tempListOfCities.clear();
                                });
                              }),
                        ])),
                    Expanded(
                      child: ListView.separated(
                          controller: scrollController,
                          //5
                          itemCount: (_tempListOfCities != null &&
                                  _tempListOfCities.length > 0)
                              ? _tempListOfCities.length
                              : _listOfCities.length,
                          separatorBuilder: (context, int) {
                            return Divider();
                          },
                          itemBuilder: (context, index) {
                            return InkWell(

                                //6
                                child: (_tempListOfCities != null &&
                                        _tempListOfCities.length > 0)
                                    ? _showBottomSheetWithSearch(
                                        index, _tempListOfCities)
                                    : _showBottomSheetWithSearch(
                                        index, _listOfCities),
                                onTap: () {
                                  //7
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text((_tempListOfCities !=
                                                      null &&
                                                  _tempListOfCities.length > 0)
                                              ? _tempListOfCities[index]
                                              : _listOfCities[index])));

                                  Navigator.of(context).pop();
                                });
                          }),
                    )
                  ]);
                });
          });
        });
  }

  Widget _showBottomSheetWithSearch(int index, List<String> listOfCities) {
    return Text(listOfCities[index],
        style: TextStyle(color: Colors.black, fontSize: 16),
        textAlign: TextAlign.center);
  }

  //9
  List<String> _buildSearchList(String userSearchTerm) {
    List<String> _searchList = List();

    for (int i = 0; i < _listOfCities.length; i++) {
      String name = _listOfCities[i];
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        _searchList.add(_listOfCities[i]);
      }
    }
    return _searchList;
  }

  Widget _button(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Icon(
        icon,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            ),
          ]),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });

      await hitpostUpdateProfilePic();
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      // await confirm(context);

      // await hitpostUpdateProfilePic();

    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Widget confirm(context) {
    return AlertDialog(
      content: Text("Are you sure you want to delete ?"),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            "Proceed",
            style: TextStyle(color: Colors.purple),
          ),
          onPressed: () async {
            // TODO: Delete the item from DB etc..
            await hitpostUpdateProfilePic();
          },
        ),
      ],
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(
                        'Photo Library',
                        style: TextStyle(
                          fontFamily: 'JosefinSans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () async {
                        await pickImage();
                        await showAlertDialog(context);

                        // confirm(context);

                        // _getFromGallery();
                        // getImageFromGallery(index);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                    ),
                    title: new Text(
                      'Camera',
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () async {
                      await pickImageFromCamera();
                      await showAlertDialog(context);

                      // getImageFromCamera(index);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Change Profile"),
      content: Text("Proceed"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'Search by address',
                          fillColor: parseHexColor('#F8F6F8'),
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(25.0),
                          //   borderSide: BorderSide(
                          //     color: Colors.blue,
                          //   ),
                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: parseHexColor('#F8F6F8'),
                              width: 2.0,
                            ),
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            // borderSide: BorderSide(
                            //   color: Colors.blue,
                            // ),
                            // borderSide: BorderSide(
                            //     color: Colors.grey,
                            //     width: 0.0,
                            //   ),
                            // borderSide: new BorderSide(),
                          ),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) async{
                          //4
                          //var result = await googlePlace.autocomplete.get(value);
                          setState(() {
                            /*placesList = [];
                            for(int i = 0; i < result.predictions.length; i++) {
                              placesList.add(result.predictions[i].description);
                              print(">>>>>${result.predictions[i].terms[0]?.value}");

                            }*/
                            _tempListOfCities = _buildSearchList(value);
                          });
                        }),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: parseHexColor('#F8F6F8'),
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    child: IconButton(
                        icon: Icon(Icons.filter_list_alt),
                        color: parseHexColor('#A4A0A4'),
                        onPressed: () {
                          setState(() {
                            textController.clear();
                            _tempListOfCities.clear();
                          });
                        }),
                  ),
                ),
              ]),
            ),
            // _showModal(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Text(
                    "Search By",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                'All',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Roboto',
                  fontSize: 16.0,
                ),
              ),
              activeColor: Color(0xFFA23FA2),
              checkColor: Colors.white,
              selected: _isChecked,
              value: _isChecked,
              onChanged: (bool value) {
                setState(() {
                  _isChecked = value;
                  _isShowroomChecked = value;
                  _isIndividualChecked = value;
                  if(value){
                    searchByValue = "All";
                  }
                });
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                'Ex Showroom',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Roboto',
                  fontSize: 16.0,
                ),
              ),
              activeColor: Color(0xFFA23FA2),
              checkColor: Colors.white,
              selected: _isShowroomChecked,
              value: _isShowroomChecked,
              onChanged: (bool value) {
                setState(() {
                  _isShowroomChecked = value;
                  if((_isShowroomChecked && _isIndividualChecked)){
                    _isChecked = true;
                    searchByValue = "All";
                  }else{
                    _isChecked = false;
                  }
                  if((!_isChecked) && _isShowroomChecked) {
                    searchByValue = "Showroom";
                  }else if((!_isChecked) && (!_isShowroomChecked) && _isIndividualChecked){
                    searchByValue = "Individual";
                  }
                });
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Individual'),
              activeColor: Color(0xFFA23FA2),
              checkColor: Colors.white,
              selected: _isIndividualChecked,
              value: _isIndividualChecked,
              onChanged: (bool value) {
                setState(() {
                  _isIndividualChecked = value;
                  if((_isShowroomChecked && _isIndividualChecked)){
                    _isChecked = true;
                    searchByValue = "All";
                  }else{
                    _isChecked = false;
                  }
                  if((!_isChecked) && _isIndividualChecked) {
                    searchByValue = "Individual";
                  }else if((!_isChecked) && (!_isIndividualChecked) && _isShowroomChecked){
                    searchByValue = "Showroom";
                  }
                });
              },
            ),

            SizedBox(
              height: 24,
            ),
          ],
        ));
  }

  Widget buildShimmer() => ListTile(
      leading: ShimmerWidget.circular(
        width: 48,
        height: 48,
        shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      title: Align(
          alignment: Alignment.centerLeft,
          child: ShimmerWidget.rectangular(
            height: 16,
            width: MediaQuery.of(context).size.width * 0.3,
          )),
      subtitle: ShimmerWidget.rectangular(height: 14));

  Widget _userPanel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Stack(
          children: [
            Column(
            children: [
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFA23FA2),
                      borderRadius:
                      BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 6, right: 16, bottom: 6),
                    child: Text(
                      userData['seller_type']??"Seller Type",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 90,
                      child: Stack(
                        children: [
                          /*ClipOval(
                            child: ClipOval(
                              child: Container(
                                  height: 80,
                                  width: 80,
                                  child: Image.asset(
                                      'assets/logo.png')),
                            ),
                          ),*/
                          CachedNetworkImage(
                              imageUrl: userData['image'],
                              imageBuilder:
                                  (context, imageProvider) =>
                                  ClipOval(
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          // colorFilter:
                                          // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                        ),
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) =>
                                  ClipOval(
                                    child: Container(
                                        height: 80,
                                        width: 80,
                                        child: Image.asset(
                                            'assets/profile-icon.png')),
                                  ),
                              errorWidget:
                                  (context, url, error) => Icon(
                                Icons.error,
                                size: 80,
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  userData['name']??"name",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.01
                ),
                child: Text(
                  userData['location']??'location',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Text(userData['description']??'Description',
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.016,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto')),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                child: Divider(
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                                height: 30,
                                width: 30,
                                // margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                color: Colors.grey[100],
                                child: Icon(
                                  Icons.phone_android,
                                  size: 15,
                                  color: Color(0xFFA23FA2),
                                )),
                          ),
                          // CircleAvatar(
                          //   radius: 20,
                          //   backgroundImage: AssetImage('assets/avatar1.jpg'),
                          // ),
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context)
                                        .style,
                                    children: [
                                      TextSpan(
                                        text: 'Phone   \n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto'),
                                      ),
                                      TextSpan(
                                          text: userData['mobile']??"9898989898",
                                          style: TextStyle(
                                              color: Color(0xFFA23FA2),
                                              fontSize: 12,
                                              fontFamily: 'Roboto')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                                height: 30,
                                width: 30,
                                // margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                color: Colors.grey[100],
                                child: Icon(
                                  Icons.email_outlined,
                                  size: 15,
                                  color: Colors.purple,
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context)
                                        .style,
                                    children: [
                                      TextSpan(
                                        text: 'Email  \n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto'),
                                      ),
                                      TextSpan(
                                        text: userData['email']??"user@knet.com",
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontSize: 12,
                                            fontFamily: 'Roboto'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
            Align(alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: (){
                  setState(() {
                    isUser = false;
                  });
                },
                    icon: Icon(Icons.cancel_outlined,
                      size: MediaQuery.of(context).size.height * 0.04,
                    )
                ),
              ),
            )
          ],
        ));
  }

  Widget buildComment(BuildContext context) => TextFormField(
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

  Widget buildOkButton() => RateMyAppRateButton(
        widget.rateMyApp,
        text: 'SEND',
        callback: () {
          Future.delayed(Duration.zero, () {
            this.hitpostaddReview();
          });
          // print('Comment: $comment');
        },
      );

  Widget buildCancelButton() => RateMyAppNoButton(
        widget.rateMyApp,
        text: 'CANCEL',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isUser = !isUser;
                    });
                    Future.delayed(Duration.zero, () {
                      this.hitpostProfile();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(100),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.white54,
                      //     blurRadius: 5.0,
                      //     offset: Offset(0, 10),
                      //     spreadRadius: 0.1,
                      //   ),
                      // ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: AssetImage("assets/pic.png"),
                        //fit: BoxFit.fitWidth,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                )),*/
            Visibility(
              visible: false,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // widget.rateMyApp.showRateDialog(context);
                      widget.rateMyApp.showRateDialog(
                        context,
                        contentBuilder: (context, _) => buildComment(context),
                        actionsBuilder: actionsBuilder,
                      );
                      // Future.delayed(Duration.zero, () {
                      //   this.hitpostProfile();
                      // });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.white54,
                        //     blurRadius: 5.0,
                        //     offset: Offset(0, 10),
                        //     spreadRadius: 0.1,
                        //   ),
                        // ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: AssetImage("assets/logo.png"),
                          //fit: BoxFit.fitWidth,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  )),
            ),
          ],
          // leading: MenuWidget(),

          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: AssetImage("assets/hamburger.png"),
                  fit: BoxFit.fill,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
          ),
        ),
        body: SlidingUpPanel(
          maxHeight: isUser ? 375 : 300,
          minHeight: isUser ? 200 : 102,
          parallaxEnabled: true,
          parallaxOffset: .5,
          body: Stack(//alignment: Alignment.center,
              children: [
                currentLocation?.latitude == null ? Center(
                    child: CircularProgressIndicator(color: Colors.purple,)) :
            Container(
              child: !showMap ? CircularProgressIndicator(color: Colors.purple,)
                  : GoogleMap(
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller){
                  setState(() {
                    _googleMapController = controller;
                  });
                },
                markers: Set<Marker>.of(
                  markersList,
                ),
                onLongPress: _addMarker,
                onTap: (value){
                  setState(() {
                    //isUser = !isUser;
                  });
                  print(value.latitude);
                },
              ),
            ),
              /*!showPlacePicker ? Center(child: CircularProgressIndicator()) :
              PlacePicker(
                  apiKey: "AIzaSyDh6_44H4oqcGf4eol4WIauqFaCdvlUVV0",
                  initialPosition: LatLng(currentLocation?.latitude, currentLocation?.longitude),
                  useCurrentLocation: true,
                  selectInitialPosition: true,

                  //usePlaceDetailSearch: true,
                  onPlacePicked: (result) {
                    selectedPlace = result;
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  //forceSearchOnZoomChanged: true,
                  //automaticallyImplyAppBarLeading: false,
                  //autocompleteLanguage: "ko",
                  //region: 'au',
                  //selectInitialPosition: true,
                  // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                  //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                  //   return isSearchBarFocused
                  //       ? Container()
                  //       : FloatingCard(
                  //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                  //           leftPosition: 0.0,
                  //           rightPosition: 0.0,
                  //           width: 500,
                  //           borderRadius: BorderRadius.circular(12.0),
                  //           child: state == SearchingState.Searching
                  //               ? Center(child: CircularProgressIndicator())
                  //               : RaisedButton(
                  //                   child: Text("Pick Here"),
                  //                   onPressed: () {
                  //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                  //                     //            this will override default 'Select here' Button.
                  //                     print("do something with [selectedPlace] data");
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                 ),
                  //         );
                  // },
                  // pinBuilder: (context, state) {
                  //   if (state == PinState.Idle) {
                  //     return Icon(Icons.favorite_border);
                  //   } else {
                  //     return Icon(Icons.favorite);
                  //   }
                  // },
                ),
                selectedPlace == null ? Container() : Align(alignment: Alignment.center,
                    child: Text(selectedPlace.formattedAddress ?? "")),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 110),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      child: ClipOval(
                        child: Material(
                          color: parseHexColor('#0C5CCD'), // button color
                          child: InkWell(
                            splashColor:
                                parseHexColor('#0C5CCD').withOpacity(0.5),
                            // inkwell color
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(
                                Icons.my_location,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              // _showModal(context);
                              // mapController.animateCamera(
                              //   CameraUpdate.newCameraPosition(
                              //     CameraPosition(
                              //       target: LatLng(
                              //         _currentPosition.latitude,
                              //         _currentPosition.longitude,
                              //       ),
                              //       zoom: 18.0,
                              //     ),
                              //   ),
                              // );
                              Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
                                  .then((currloc) {
                                setState(() {
                                  currentLocation = currloc;
                                  //_isLocationGranted = true;
                                  _initialCameraPosition =
                                      CameraPosition(
                                          target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 11.5);
                                  _googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLocation.latitude, currentLocation.longitude), 14));
                                });
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if(textController.text.isNotEmpty)SafeArea(
              child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10)
                    ),
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                height: MediaQuery.of(context).size.height * 0.76,
                    child: ListView.builder(
                      itemCount: widget.userList.length,
                      shrinkWrap: true,
                      controller: ScrollController(keepScrollOffset: true),
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                            onTap: (){
                              setState(() {
                                isUser = true;
                                userData = widget.userList[index];
                                FocusScope.of(context).unfocus();
                                _initialCameraPosition =
                                    CameraPosition(
                                        target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 1.5);
                                _googleMapController?.animateCamera(
                                    CameraUpdate.newLatLngZoom(LatLng(
                                        double.parse(widget.userList[index]['lat']),
                                        double.parse(widget.userList[index]['lng'])), 14));
                                textController.text = "";
                              });
                            },
                            child: !(widget.userList[index]['location'].toString()
                                .toLowerCase().contains(textController.text.toLowerCase())
                                &&
                                (widget.userList[index]['seller_type'] == (searchByValue == "All" ?
                                (widget.userList[index]['seller_type'] == 'Individual' ? 'Individual'
                                    : 'Showroom') : searchByValue
                                )))
                                ? Container() :
                            Card(
                              child: ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: widget.userList[index]['image'],
                                  imageBuilder:
                                      (context, imageProvider) =>
                                      ClipOval(
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              // colorFilter:
                                              // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                            ),
                                          ),
                                        ),
                                      ),
                                  placeholder: (context, url) =>
                                      ClipOval(
                                        child: Container(
                                            height: 50,
                                            width: 50,
                                            child: Image.asset(
                                                'assets/profile-icon.png')),
                                      ),
                                  errorWidget:
                                      (context, url, error) => Icon(
                                    Icons.error,
                                    size: 50,
                                  ),
                                ),
                                title: Text(widget.userList[index]['name'],
                                ),
                                subtitle: Text(widget.userList[index]['seller_type'],
                                ),
                                trailing: //Text(widget.userList[index]['distance'].toString()),
                                RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(style: TextStyle(
                                      //fontSize: MediaQuery.of(context).size.height * 0.022
                                  ),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: 'Distance\n',
                                            style: TextStyle(color: Colors.black54)
                                        ),
                                        TextSpan(
                                            text: widget.userList[index]['distance'].toString().split('.')[0]+" Km(s)",
                                            style: TextStyle(
                                                color: Color(0xFFA23FA2),
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
            ),
          ]
          ),

          panelBuilder: (sc) => isUser ? _userPanel(sc) : _panel(sc),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36.0), topRight: Radius.circular(36.0)),
          // onPanelSlide: (double pos) => setState(() {
          //   _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
          //       _initFabHeight;
          // }),
        ),
        drawer: NavDrawer());
  }

  onPress() {
    _showModal(context);
  }

  void _addMarker(LatLng pos) {
    if (_origin == null || (_origin != null && _destination != null)) {
    } else {
      setState(() {
        _origin = Marker(
            markerId: MarkerId('origin'),
            infoWindow: const InfoWindow(title: ''));
      });
    }
  }

  hitpostProfile() {
    _profile.getProfile(context);
  }
}
