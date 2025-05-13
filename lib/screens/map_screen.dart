import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LocationData? currentLocation;
  final Location location = Location();
  late GoogleMapController mapController;

  final List<Marker> markers = [
    Marker(
      markerId: MarkerId('spot1'),
      position: LatLng(48.3809, -89.2477),
      infoWindow: InfoWindow(title: 'Marina Park'),
    ),
  ];

  Future<void> _getLocation() async {
    final loc = await location.getLocation();
    setState(() => currentLocation = loc);
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map View")),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 13,
        ),
        markers: Set.from(markers),
        myLocationEnabled: true,
        onMapCreated: (controller) => mapController = controller,
      ),
    );
  }
}