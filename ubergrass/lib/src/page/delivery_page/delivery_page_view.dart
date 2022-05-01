import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import 'delivery_page_controller.dart';

class DeliveryPageView extends StatefulWidget {
  static const String routeName = "/delivery_page";
  const DeliveryPageView({Key? key}) : super(key: key);

  @override
  _DeliveryPageViewState createState() => _DeliveryPageViewState();
}

class _DeliveryPageViewState extends State<DeliveryPageView> {
  String googleApikey = "AIzaSyDQRHR9qa-aMU6etJT8kp0VX8I1QvnodLA";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(0, 0);
  DeliveryPageController controller = DeliveryPageController();
  dynamic order;
  Map<PolylineId, Polyline> _polylines = {};

  Future<Map<PolylineId, Polyline>> getPolyline(String addressStart, String addressDest) async {
    List<LatLng> polylineCoordinates = [];
    Map<PolylineId, Polyline> polylines = {};
    late PolylinePoints polylinePoints;
    List<Location> addressStartLoc = await locationFromAddress(addressStart);
    List<Location> addressDestLoc = await locationFromAddress(addressDest);
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              addressStartLoc[0].latitude,
              addressStartLoc[0].longitude,
            ),
            zoom: 11.0,
          ),
        ),
      );
      polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApikey,
        PointLatLng(addressStartLoc[0].latitude, addressStartLoc[0].longitude),
        PointLatLng(addressDestLoc[0].latitude, addressDestLoc[0].longitude),
        travelMode: TravelMode.driving,
      );
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
      PolylineId id = const PolylineId('poly');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 3,
      );
      polylines[id] = polyline;
      return polylines;
    }

  @override
  initState() {
    controller.getOrder().then((value) {
        order = value["data"];
        getPolyline(order["Address"], value["Seller_Address"]).then((value) {
          setState(() {
            _polylines = value;
          });
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
          children:[
            GoogleMap(
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              polylines: Set<Polyline>.of(_polylines.values),
              initialCameraPosition: CameraPosition(
                target: startLocation,
                zoom: 14.0,
              ),
              mapType: MapType.normal,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}