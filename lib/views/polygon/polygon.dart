import 'package:flutter/material.dart';
import 'package:frontend/controllers/location_controller.dart';
import 'package:frontend/controllers/polygon_controller.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/views/polygon/loader.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  final id;
  final fullname;
  final phone;
  final roleid;
  final role;
  final email;
  final image;
  final isLoggedIn;
  const PolygonScreen(
      {Key? key,
      this.id,
      this.fullname,
      this.phone,
      this.roleid,
      this.role,
      this.email,
      this.isLoggedIn = false,
      this.image})
      : super(key: key);

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  var location = Get.put(LocationController());
  var polygon = Get.put(PolygonController());
  var user = Get.put(UserController());
  double lati = 0;
  double longi = 0;
  Set<Marker> markers = {}; // Set to store markers
  List<LatLng> polylinePoints = []; // List to store polyline points

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        body: (location.isDataLoading.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(location.position.latitude,
                            location.position.longitude),
                        zoom: 14,
                      ),
                      markers: markers,
                      polylines: polylinePoints.isNotEmpty
                          ? {
                              Polyline(
                                polylineId: const PolylineId('polyline'),
                                color: Colors.red,
                                width: 3,
                                points: polylinePoints,
                              ),
                            }
                          : {},
                      onTap: (LatLng point) {
                        // Add a new marker when the map is tapped
                        setState(() {
                          markers.add(
                            Marker(
                              markerId: MarkerId(point.toString()),
                              position: point,
                              draggable: true,
                              onDragEnd: (newValue) {
                                lati = newValue.latitude;
                                longi = newValue.longitude;
                              },
                            ),
                          );
                          polylinePoints
                              .add(point); // Add point to polyline list
                          if (polylinePoints.length == 4) {
                            polylinePoints.add(polylinePoints[0]);
                          }
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: size.width * 0.1,
                    child: Container(
                      height: size.height * 0.1,
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                        onPressed: () async {
                          if(widget.isLoggedIn == true){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const PolygonLoader()));
                          }
                          if (polylinePoints.length == 5) {
                            List<LatLng> latlng = [];
                            polylinePoints.forEach((element) {
                              latlng.add(element);
                            });
                            print(latlng);
                            await polygon.createPolygon(latlng);
                            user.addUser(context,
                                userId: widget.id,
                                name: widget.fullname,
                                phone: widget.phone,
                                email: widget.email,
                                role: widget.role,
                                image: widget.image,
                                lat: location.position.latitude,
                                long: location.position.longitude,
                                polygonId: polygon.polygondata.value.id ?? "",
                                district: location.district.value,
                                city: location.city.value,
                                state: location.state.value,
                                locality: location.locality.value);
                          }
                        },
                        child: const Text(
                          'Create Polygon',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
