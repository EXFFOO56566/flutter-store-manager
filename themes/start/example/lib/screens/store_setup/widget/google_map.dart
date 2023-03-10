// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapToFind extends StatefulWidget{
//   @override
//   _MapToFindState createState() => _MapToFindState();
// }
//
// class _MapToFindState extends State<MapToFind> {
//   String googleApikey = "GOOGLE_MAP_API_KEY";
//   GoogleMapController? mapController; //contrller for Google map
//   CameraPosition? cameraPosition;
//   LatLng startLocation = const LatLng(27.6602292, 85.308027);
//   String location = "Location Name:";
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         appBar: AppBar(
//           title: const Text("Longitude Latitude Picker in Google Map"),
//           backgroundColor: Colors.deepPurpleAccent,
//         ),
//         body: Stack(
//             children:[
//
//               GoogleMap( //Map widget from google_maps_flutter package
//                 zoomGesturesEnabled: true, //enable Zoom in, out on map
//                 initialCameraPosition: CameraPosition( //innital position in map
//                   target: startLocation, //initial position
//                   zoom: 14.0, //initial zoom level
//                 ),
//                 mapType: MapType.normal, //map type
//                 onMapCreated: (controller) { //method called when map is created
//                   setState(() {
//                     mapController = controller;
//                   });
//                 },
//                 onCameraMove: (CameraPosition cameraPositiona) {
//                   cameraPosition = cameraPositiona; //when map is dragging
//                 },
//                 onCameraIdle: () async { //when map drag stops
//                   List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
//                   setState(() { //get place name from lat and lang
//                     location = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
//                   });
//                 },
//               ),
//
//               Center( //picker image on google map
//                 child: Image.asset("assets/images/picker.png", width: 80,),
//               ),
//
//
//               Positioned(  //widget to display location name
//                   bottom:100,
//                   child: Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Card(
//                       child: Container(
//                           padding: const EdgeInsets.all(0),
//                           width: MediaQuery.of(context).size.width - 40,
//                           child: ListTile(
//                             leading: Image.asset("assets/images/picker.png", width: 25,),
//                             title:Text(location, style: const TextStyle(fontSize: 18),),
//                             dense: true,
//                           )
//                       ),
//                     ),
//                   )
//               )
//             ]
//         )
//     );
//   }
// }
