import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/screen/MapScreen.dart';

class GetMarkers extends StatefulWidget {
  final double lat, lng;
  const GetMarkers({Key key, this.lat, this.lng}) : super(key: key);

  @override
  _GetMarkersState createState() => _GetMarkersState();
}

class _GetMarkersState extends State<GetMarkers> {

  List nearbyUsersList = [];
  List<Marker> markersList = [];

  @override
  void initState() {
    ApiHandler.getUsersLocation("All", widget.lat, widget.lng).then((value){
      if(value != null){
        setState(() {
          nearbyUsersList = value['data'];
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MapScreen(userList: nearbyUsersList,),
          ));
        });
        print("***************************"+nearbyUsersList.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: Colors.purple,),);
  }
}

//--------------------------------------------------------
class GetPosition extends StatefulWidget {
  const GetPosition({Key key}) : super(key: key);

  @override
  _GetPositionState createState() => _GetPositionState();
}

class _GetPositionState extends State<GetPosition> {
  double lat, lng;

  var _initialCameraPosition =
  CameraPosition(target: LatLng(29.401, 45.254), zoom: 11.5);
  GoogleMapController _googleMapController;

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((currloc) {
      setState(() {
        lat = currloc.latitude;
        lng = currloc.longitude;
        _googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(currloc.latitude, currloc.longitude), 14));
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => GetMarkers(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (controller){
        setState(() {
          _googleMapController = controller;
        });
      },
    );
  }
}

