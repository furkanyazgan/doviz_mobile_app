import 'dart:async';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';


import 'package:latlong2/latlong.dart';

class AppConstants {
  static const String mapBoxAccessToken = 'pk.eyJ1IjoiZnVya2FueWF6Z2FuIiwiYSI6ImNsYWZ4dmxjYTBsOG00MHFqdXZ5dmphdjcifQ.RHi8SBcUTb-RvposrLB4sg';

  static const String mapBoxStyleId = 'mapbox.mapbox-streets-v8';

  static final myLocation = LatLng(41.01136838201195, 28.96878437685852) ;
}

class MapBox extends StatefulWidget {
  const MapBox({Key? key}) : super(key: key);

  @override
  _MapBoxState createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {


  @override
  Widget build(BuildContext context) {
     return ClipRRect(
       borderRadius: BorderRadius.circular(16),
       child: FlutterMap(

         options: MapOptions(onTap:(x,y){
           MapsLauncher.launchCoordinates(
               41.01136838201195, 28.96878437685852, 'Özak Kıymetli Madenler');

         } ,
           minZoom: 10,
           maxZoom: 17,
           zoom: 13,
           center: AppConstants.myLocation,
         ),
         children: [
           TileLayer(
             urlTemplate:
             "https://api.mapbox.com/styles/v1/furkanyazgan/clafyeg13005t14ql3t0xhyuj/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZnVya2FueWF6Z2FuIiwiYSI6ImNsYWZ4dmxjYTBsOG00MHFqdXZ5dmphdjcifQ.RHi8SBcUTb-RvposrLB4sg",
             additionalOptions: {
               'mapStyleId': AppConstants.mapBoxStyleId,
               'accessToken': AppConstants.mapBoxAccessToken,
             },
           ),
           MarkerLayer(markers: [
             Marker(rotate: true,
                 width: 25,
                 height: 50,
                 point:  AppConstants.myLocation
                 ,builder: (_)=> Image.asset("assets/images/location.png")
             )
           ],)
         ],
       ),
     );
}}
