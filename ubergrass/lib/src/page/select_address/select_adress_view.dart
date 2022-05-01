import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class SelectAddressView extends StatefulWidget {
  static const String routeName = "/select_adress";
  @override
  _SelectAddressViewState createState() => _SelectAddressViewState();
}

class _SelectAddressViewState extends State<SelectAddressView> {
  String googleApikey = "AIzaSyDQRHR9qa-aMU6etJT8kp0VX8I1QvnodLA";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Search Location";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
            children:[
              GoogleMap(
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
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
              Positioned(
                  top:10,
                  child: InkWell(
                      onTap: () async {
                        var place = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: googleApikey,
                            mode: Mode.overlay,
                            types: [],
                            strictbounds: false,
                            components: [Component(Component.country, 'fr')],
                            onError: (err){
                              print(err);
                            }
                        );

                        if(place != null){
                          setState(() {
                            location = place.description.toString();
                          });

                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(apiKey:googleApikey,
                            apiHeaders: await const GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );
                          String placeid = place.placeId ?? "0";
                          final detail = await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          final lat = geometry.location.lat;
                          final lang = geometry.location.lng;
                          var newlatlang = LatLng(lat, lang);


                          //move map camera to selected place with animation
                          mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                        }
                      },
                      child:Padding(
                        padding: const EdgeInsets.all(15),
                        child: Card(
                          child: Container(
                              padding: const EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width - 40,
                              child: ListTile(
                                title:Text(location, style: const TextStyle(fontSize: 18),),
                                trailing: const Icon(Icons.search),
                                dense: true,
                              )
                          ),
                        ),
                      )
                  )
              )
            ]
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, location);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}