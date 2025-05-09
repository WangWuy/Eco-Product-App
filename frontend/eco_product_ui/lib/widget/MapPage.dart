import 'dart:async';

import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}


class MapPageState extends State<MapPage> {

  Completer<GoogleMapController> _controller = Completer();
// this set will hold my markers
  Set<Marker> _markers = {};
// this will hold the generated polylines
  Set<Polyline> _polylines = {};
// this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyAZ6df2DrqkaZLPYjUMX4D_4iMCqeFMsZ0";
// for my custom icons
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;

  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20,20)),
      ConstantData.assetsPath+  'maps-and-flags.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(20,20)),
        ConstantData.assetsPath+  'location.png');
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION
    );
    return GoogleMap(
        myLocationEnabled: true,
        compassEnabled: true,
        tiltGesturesEnabled: false,
        markers: _markers,
        polylines: _polylines,
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        onMapCreated: onMapCreated
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION,
          icon: sourceIcon

      ));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: DEST_LOCATION,
          icon: destinationIcon
      ));
    });
  }
  setPolylines() async {
    // List<PointLatLng> result = await
    // polylinePoints?.getRouteBetweenCoordinates(
    //     googleAPIKey,
    //     SOURCE_LOCATION.latitude,
    //     SOURCE_LOCATION.longitude,
    //     DEST_LOCATION.latitude,
    //     DEST_LOCATION.longitude);
    // print("result---true");
    // if(result.isNotEmpty){
    //   print("result1---true");
    //   // loop through all PointLatLng points and convert them
    //   // to a list of LatLng, required by the Polyline
    //   result.forEach((PointLatLng point){
    //     polylineCoordinates.add(
    //         LatLng(point.latitude, point.longitude));
    //   });
    // }
    // setState(() {
    //   // create a Polyline instance
    //   // with an id, an RGB color and the list of LatLng pairs
    //   Polyline polyline = Polyline(
    //       polylineId: PolylineId('poly'),
    //       color: Colors.green,
    //       points: polylineCoordinates
    //   );
    //
    //
    //
    //   _polylines.add(polyline);
    // });
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BitmapDescriptor>('sourceIcon', sourceIcon));
    properties.add(DiagnosticsProperty<BitmapDescriptor>('destinationIcon', destinationIcon));
  }

}